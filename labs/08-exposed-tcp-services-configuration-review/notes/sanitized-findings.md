# Sanitized findings - Lab 08

## Observed findings

- FTPD procedure reviewed in read-only mode.
- SSHD procedure reviewed in read-only mode.
- HTTPD1 procedure reviewed in read-only mode.
- FTPD1 listening on TCP port 21 was observed.
- SSHD4 listening on TCP port 22 was observed.
- HTTPD1 listening on TCP port 80 was observed.
- No records were observed for TCP port 443 in the captured runtime evidence.

## Security interpretation

- FTP and HTTP are traditional cleartext service families unless protected by a separate mechanism such as TLS, AT-TLS or a secure variant.
- SSH is encrypted by design, but its detailed hardening depends on the USS SSH configuration files, which were not reviewed in this lab.
- HTTPS was not observed at runtime on port 443 in the captured evidence.
- Earlier labs did not observe active Policy Agent, IKED or IDS-related runtime components.

## Publication notes

The original DOCX should not be published. Only the sanitized screenshots and markdown notes should be committed.
