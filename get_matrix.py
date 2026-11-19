import os
import yaml
import subprocess
import argparse
import json

class MatrixGenerator:
    def __init__(self, directory = '.', from_changes:bool = False, previous: bool = False):
        if from_changes:
            if previous:
                print("Getting git changes from HEAD")
                self.directories = self.__get_changed_directories(directory, "HEAD~1")
            else:
                print("Getting uncommitted git changes from working directory")
                self.directories = self.__get_changed_directories(directory)
        else:
            print("Using the current directory")
            self.directories = [directory]
    
    def __get_changed_directories(self, directory, hash = '') -> list:
        git_command = ['git', 'diff', '--name-only']
        if hash:
            git_command.append(hash)
        output = subprocess.check_output(git_command, cwd=directory, universal_newlines=True)
        changed_files = output.strip().split('\n')
        print(f"Changed files: {changed_files}")
        changed_directories = set()
        for file in changed_files:
            directory_name = os.path.dirname(file)
            changed_directories.add(directory_name)
        return list(changed_directories)

    def __find_module_architectures(self) -> dict:
        result = {}
        for directory in self.directories:
            for root, dirs, files in os.walk(directory):
                for file in files:
                    if file == 'config.yaml':
                        file_path = os.path.join(root, file)
                        with open(file_path, 'r') as f:
                            config = f.read()
                            # Assuming the architecture is specified in the config.yaml file
                            architecture = self.extract_architecture(config)
                            directory_name = os.path.basename(root)
                            result[directory_name] = architecture
        return result

    def extract_architecture(self, config) -> list:
        """Extracts the architecture from the config.yaml file"""
        config_data = yaml.safe_load(config)
        architecture = config_data.get('arch')
        return architecture

    RUNNERS = {'amd64': 'ubuntu-24.04', 'aarch64': 'ubuntu-24.04-arm'}

    @staticmethod
    def __load_yaml(path) -> dict:
        if not os.path.isfile(path):
            return {}
        with open(path, 'r') as f:
            return yaml.safe_load(f) or {}

    def get_matrix(self, architectures = None) -> dict:
        """Generates one matrix entry per add-on and architecture"""
        if architectures is None:
            architectures = self.__find_module_architectures()
        result = []
        for target, architecture in architectures.items():
            config = self.__load_yaml(os.path.join(target, 'config.yaml'))
            build = self.__load_yaml(os.path.join(target, 'build.yaml'))
            for arch in architecture:
                if arch not in self.RUNNERS:
                    raise ValueError(f"{target}: unsupported architecture {arch}")
                build_args = []
                build_from = (build.get('build_from') or {}).get(arch)
                if build_from:
                    build_args.append(f"BUILD_FROM={build_from}")
                for key, value in (build.get('args') or {}).items():
                    build_args.append(f"{key}={value}")
                description = str(config.get('description', '')).strip().splitlines()
                result.append({
                    'target': target,
                    'arch': arch,
                    'os': self.RUNNERS[arch],
                    'image': config['image'].replace('{arch}', arch),
                    'name': config.get('name', target),
                    'description': description[0] if description else '',
                    'url': config.get('url', ''),
                    'build_args': "\n".join(build_args),
                })
        return {'include': result}
    
    def get_json_matrix(self, architectures = None) -> str:
        """Converts matrix dict to json"""
        matrix = self.get_matrix(architectures)
        return json.dumps(matrix)


parser = argparse.ArgumentParser()
parser.add_argument('--from-changes', action='store_true', help='Generate matrix from changed directories')
parser.add_argument('--previous', action='store_true', help='Use previous commit to generate matrix')
parser.add_argument('--apps', default='', help='Space or comma separated app directories to build (skips git diff)')
args = parser.parse_args()

apps = args.apps.replace(',', ' ').split()
if apps:
    missing = [a for a in apps if not os.path.isfile(os.path.join(a, 'config.yaml'))]
    if missing:
        raise SystemExit(f"Unknown app(s), no config.yaml found: {', '.join(missing)}")
    print(f"Building requested apps: {apps}")
    converter = MatrixGenerator(from_changes=False)
    converter.directories = apps
else:
    converter = MatrixGenerator(from_changes=True, previous=True)

matrix = converter.get_matrix()
with open('matrix-count.txt', 'w', encoding='utf-8') as f:
    f.write(str(len(matrix['include'])))

json_matrix = converter.get_json_matrix()
print(json_matrix)
with open('matrix.txt', 'w', encoding='utf-8') as f:
    f.write(json_matrix)