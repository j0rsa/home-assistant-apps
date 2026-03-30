# Changelog

## 1.5.0

- Update Netmaker server to v1.5.0

## 0.99.0.1

- Fix MQ broker config: use SERVER_BROKER_ENDPOINT env var instead of MQ_HOST/MQ_PORT
- Replace mq_host, mq_port, mq_use_tls options with single mq_broker_endpoint URL

## 0.24.2

- Add Netmaker Controller add-on for Home Assistant
- Support SQLite persistence at /data/netmaker.db
- Auto-generate master key, admin password, and MQTT password if not provided
- Configure via HA UI with domain, MQTT broker, and security settings
