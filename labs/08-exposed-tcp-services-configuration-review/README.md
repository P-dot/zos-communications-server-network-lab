# Lab 08 - z/OS Exposed TCP Services Configuration Review

## Objective

This lab reviews the started task procedures and visible configuration references for exposed TCP services in the z/OS Communications Server environment.

The review focuses on FTP, SSH and HTTP because earlier runtime evidence showed these services listening on TCP ports 21, 22 and 80. HTTPS port 443 was also checked and no listener was observed in the captured evidence.

All work was performed in read-only mode. No started task procedure, TCP/IP profile, UNIX file or service configuration was modified.

## Scope

Reviewed components:

- `ADCD.Z111S.PROCLIB(FTPD)`
- `ADCD.Z111S.PROCLIB(SSHD)`
- `ADCD.Z111S.PROCLIB(HTTPD1)`
- Runtime `NETSTAT CONN` checks for ports 21, 22, 80 and 443

## Safety statement

The lab used display and browse-only evidence.

No services were started or stopped.
No PROCLIB members were edited.
No UNIX configuration files were modified.
No TLS, SSL, AT-TLS or IPsec policy was activated.
No TCP/IP profile reload or `VARY TCPIP,,OBEYFILE` command was issued.

## Findings

### FTP service

The FTP started task procedure was observed in `ADCD.Z111S.PROCLIB(FTPD)`.

The procedure references the FTP daemon module and visible TCP/IP resolver/configuration datasets, including `SYSTCPD` and FTP-related configuration through `SYSFTPD`.

Runtime evidence confirmed that `FTPD1` was listening on TCP port 21.

Security relevance:

- FTP is an exposed TCP service.
- The reviewed procedure does not by itself prove encrypted FTP protection.
- Earlier labs did not observe active Policy Agent or AT-TLS enforcement.

### SSH service

The SSH started task procedure was observed in `ADCD.Z111S.PROCLIB(SSHD)`.

The procedure uses `BPXBATCH` and references UNIX System Services startup logic for SSH.

Runtime evidence confirmed that `SSHD4` was listening on TCP port 22.

Security relevance:

- SSH is an encrypted remote access service.
- The procedure indicates that SSH is started through UNIX System Services.
- Detailed SSH hardening would require a separate read-only review of the referenced USS SSH configuration files.

### HTTP service

The HTTP started task procedure was observed in `ADCD.Z111S.PROCLIB(HTTPD1)`.

The procedure references an HTTP configuration file path and starts an HTTP daemon program.

Runtime evidence confirmed that `HTTPD1` was listening on TCP port 80.

HTTPS port 443 was checked and no records were observed in the captured runtime evidence.

Security relevance:

- HTTP was observed as an exposed TCP service on port 80.
- HTTPS was not observed listening on port 443 in the captured evidence.
- The reviewed procedure points to a configuration file that would require a separate read-only review before making stronger conclusions about HTTP security settings.

## Runtime correlation

| Service | Runtime port | Observed state | Started task / user ID shown |
|---|---:|---|---|
| FTP | 21 | LISTEN | FTPD1 |
| SSH | 22 | LISTEN | SSHD4 |
| HTTP | 80 | LISTEN | HTTPD1 |
| HTTPS | 443 | No records observed | Not observed |

## Conclusion

This lab correlates exposed TCP services with their started task procedures. FTP, SSH and HTTP were observed as listening services, and their associated procedures were reviewed in read-only mode. HTTPS on port 443 was checked and no runtime listener was observed in the captured evidence.

The lab strengthens the network security baseline by connecting runtime service exposure with configuration artifacts.
