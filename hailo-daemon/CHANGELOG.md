# Changelog

## 0.0.5

- Configure hailort_service socket path via /etc/default/hailort_service and HAILORT_SERVICE_ADDRESS env var so socket lands in /share/hailo/ accessible to other containers
- Log config file contents to help diagnose if config key differs

## 0.0.4

- Fix container exiting: hailort_service daemonizes itself so run it in foreground mode and monitor the socket instead of the PID

## 0.0.3

- Fix binary name: use /usr/local/bin/hailort_service (not hailortd)
- Discover socket path dynamically instead of hardcoding it

## 0.0.2

- Find hailortd by path search instead of assuming it is on PATH; log dpkg contents on failure to help diagnose install location

## 0.0.1

- Initial release: runs hailortd to multiplex Hailo device access across containers
