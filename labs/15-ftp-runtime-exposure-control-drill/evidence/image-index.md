# Evidence Image Index - Lab 15

| Image | Description |
|---|---|
| `01_ftpd1_active_before_stop.png` | `FTPD1` active before the drill. |
| `02_port21_listen_before_stop.png` | TCP port 21 listening before FTP shutdown. |
| `03_ftp_shutdown_in_progress.png` | FTP server shutdown in progress. |
| `04_ftpd1_not_found_after_stop.png` | `FTPD1 NOT FOUND` after shutdown. |
| `05_port21_no_records_after_stop.png` | TCP port 21 no longer listening after shutdown. |
| `06_port21_no_records_recheck.png` | Additional verification that TCP port 21 has no listener. |
| `07_ftpd1_not_found_recheck.png` | Additional verification that `FTPD1` is not active. |
| `08_port21_listen_after_restart.png` | TCP port 21 listening again after service restoration. |

## Sanitization note

The screenshots do not expose external client addresses. Runtime listener addresses such as `0.0.0.0` are generic bind addresses and were retained.
