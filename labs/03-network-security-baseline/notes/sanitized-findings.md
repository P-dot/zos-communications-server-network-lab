# Sanitized Findings - Lab 03

## Confirmed evidence

- TCP/IP NETSTAT commands responded successfully.
- Local HOME list included a z/OS address on `ETH1` and loopback.
- Routing table included default route, loopback, local subnet route and host route.
- `NETSTAT DEVLINKS` showed loopback and `ETH1` in ready state.
- `NETSTAT PORTL` and `NETSTAT CONN` showed listening TCP services.
- FTP, SSH, TN3270 and HTTP listeners were observed.
- No listener was observed for HTTPS port 443 in the specific port check.
- `PAGENT`, `IKED`, `NSSD`, `TRMD` and `SYSLOGD` were not found active.
- No records were observed for ports 500 and 4500.
- No records were observed for Enterprise Extender ports 12000-12004.
- VTAM was active.
- Enterprise Extender XCA major node was not active.

## Sanitized service inventory

| Service area | Evidence | Sanitized interpretation |
|---|---|---|
| TCP/IP stack | NETSTAT command response | Stack operational |
| Routing | NETSTAT ROUTE | Default/local/loopback routes present |
| Interface | NETSTAT DEVLINKS | ETH1/LCS link ready |
| FTP | port 21 LISTEN | FTP service active |
| SSH | port 22 LISTEN | SSH service active |
| TN3270 | port 23 LISTEN | TN3270 service active |
| HTTP | port 80 LISTEN | HTTP service active |
| HTTPS | port 443 no records | HTTPS not observed |
| Policy Agent | PAGENT NOT FOUND | No active policy agent runtime |
| IKE | IKED NOT FOUND | No active IKE runtime |
| IDS runtime | TRMD/SYSLOGD NOT FOUND | No active IDS reporting runtime observed |
| Enterprise Extender | IST2045I | EE not active |
