# Sanitized findings

## Sanitization

The following values were sanitized before publication:

- IP addresses
- hostnames
- host aliases

The original DOCX should not be uploaded to GitHub because it contains raw host mapping details.

## Findings

- OMVS shell access was confirmed.
- `/etc/ssh` and `/etc/ssh/sshd_config` were observed.
- SSHD configuration includes Protocol 2, disabled root login, password authentication, public key authentication, host key references and SFTP subsystem configuration.
- No explicit Ciphers entry was observed in the captured grep output.
- `/etc/syslog.conf` was not found in the captured evidence.
- `/etc/resolv.conf` was not found in the captured evidence.
- `/etc/hosts` exists and was sanitized.
- UNIX process evidence showed SSH, HTTP and FTP processes.
- No syslog daemon process was observed in the captured process search.

## Caution

These findings are based only on the captured evidence and reviewed paths. They do not prove that no other configuration files exist elsewhere in the z/OS UNIX file system.
