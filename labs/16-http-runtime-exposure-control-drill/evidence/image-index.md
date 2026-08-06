# Evidence Image Index - Lab 16

| File | Description |
|---|---|
| 01_httpd1_active_before_stop.png | HTTPD1 address space active before the runtime stop drill. |
| 02_port_80_listen_before_stop.png | NETSTAT evidence showing TCP port 80 in LISTEN state. |
| 03_port_443_no_records_before_stop.png | NETSTAT evidence showing no observed TCP 443 listener. |
| 04_httpd1_stop_not_active_response.png | Runtime control response while stopping/checking HTTPD1. |
| 05_httpd1_not_found_after_stop.png | HTTPD1 not found after runtime stop. |
| 06_port_80_no_records_after_stop.png | TCP port 80 no longer listening after HTTPD1 stop. |
| 07_httpd1_active_after_restart.png | HTTPD1 active again after rollback/restart. |
| 08_port_80_listen_after_restart.png | TCP port 80 listening again after rollback/restart. |
