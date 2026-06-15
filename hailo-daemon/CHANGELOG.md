# Changelog

## 0.0.3

- Fix binary name: use /usr/local/bin/hailort_service (not hailortd)
- Discover socket path dynamically instead of hardcoding it

## 0.0.2

- Find hailortd by path search instead of assuming it is on PATH; log dpkg contents on failure to help diagnose install location

## 0.0.1

- Initial release: runs hailortd to multiplex Hailo device access across containers
