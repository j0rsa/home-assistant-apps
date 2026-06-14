# Changelog

## 0.1.2

- Fix apk packages py3-pip/py3-setuptools/py3-wheel no longer available in Alpine 3.21 (base-python 18.0.0 already bundles them)

## 0.1.1

- Fix build failure caused by COPY of missing hailo_packages/ directory (wheels are user-supplied at runtime)
- Fix base image version mismatch between build.yaml and Dockerfile (align to 18.0.0)
