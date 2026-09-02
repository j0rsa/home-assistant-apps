# Changelog

## 1.3.4-3

- Resolve latest Xray-core version via GitHub release redirect instead of the rate-limited `/releases/latest` API

## 1.3.4-1

- Rebuild images after codenotary/`app_config` migration so CI publishes updated manifests

## 1.3.4

- Remove deprecated `codenotary` field from config and build metadata
- Replace legacy `addon_config` map type with `app_config`

## 1.3.3

- Fix Ubuntu 26.04 build: install `netcat-openbsd` instead of removed virtual `netcat` package

## 1.3.2

- Update base image to Ubuntu 26.04

## 1.3.1

- Remove armv7 architecture support
