# Node exporter - Prometheus logging service

## Install

```bash
$ # User root
root$ cp node-exporter.service /etc/systemd/system/node-exporter.service
root$ systemctl enable node-exporter.service
root$ systemctl start node-exporter.service
```
