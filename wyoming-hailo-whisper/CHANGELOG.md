# Changelog

## 0.1.4

- Fix musl version conflict by upgrading musl before installing musl-dev (Alpine 3.19 repo drift)

## 0.1.3

- Revert build.yaml base image to 13.1.3 (18.0.0 causes musl version conflict); restore py3-pip/setuptools/wheel for Alpine 3.19

## 0.1.2

- Fix apk packages py3-pip/py3-setuptools/py3-wheel no longer available in Alpine 3.21 (base-python 18.0.0 already bundles them)

## 0.1.1

- Fix build failure caused by COPY of missing hailo_packages/ directory (wheels are user-supplied at runtime)
- Fix base image version mismatch between build.yaml and Dockerfile (align to 18.0.0)
