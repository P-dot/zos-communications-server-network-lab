# Lab 11 - z/OS UNIX Network Service Configuration Review

## Objective

This lab reviews z/OS UNIX-side configuration artifacts for exposed network services in read-only mode.

The objective is to correlate MVS started task and runtime NETSTAT evidence with UNIX configuration files and UNIX process evidence for SSHD, HTTPD, FTPD, SYSLOGD and resolver-related files.

No UNIX service configuration was modified.

## Scope

Reviewed areas:

- OMVS shell identity and operating environment
- `/etc/ssh` directory
- `/etc/ssh/sshd_config`
- SSH daemon security parameters
- SYSLOGD configuration presence
- HTTP-related configuration search under `/etc`
- resolver and host files
- UNIX process evidence for SSH, HTTP, FTP and syslog

## Safety statement

All commands used in this lab were read-only commands.

No files were edited.
No services were started or stopped.
No permissions were changed.
No SSH, HTTP, FTP, resolver or syslog configuration was modified.
No certificates, keys or RACF profiles were changed.

## Evidence summary

### OMVS environment

The OMVS shell was entered and basic identity/system information was collected using `pwd`, `whoami` and `uname -a`.

### SSH configuration artifacts

The `/etc/ssh` directory exists and contains SSH-related configuration and host key files.

The file `/etc/ssh/sshd_config` exists and was reviewed using read-only `grep` commands.

Observed SSH configuration evidence:

- SSH listens on the default SSH port 22.
- Protocol 2 is configured.
- `PermitRootLogin no` was observed.
- `PasswordAuthentication yes` was observed.
- `PubkeyAuthentication yes` was observed.
- RSA and DSA host key references were observed.
- The SFTP subsystem points to `/usr/lib/ssh/sftp-server`.
- No explicit `Ciphers` entry was observed in the captured grep output.

### SYSLOGD configuration

`/etc/syslog.conf` was not found in the captured evidence.

This aligns with the earlier runtime finding where `SYSLOGD` was not observed as an active address space.

### HTTP configuration search

An HTTP-related search under `/etc` was performed. No HTTP server configuration file under `/etc` was confirmed in the captured evidence.

This does not prove that no HTTP configuration exists elsewhere. Earlier MVS PROC evidence indicated that HTTPD1 can use configuration outside `/etc`.

### Resolver and hosts files

`/etc/resolv.conf` was not found in the captured evidence.

`/etc/hosts` exists and contains a local host mapping. Address and hostname details were sanitized before publication.

### UNIX process evidence

UNIX process checks were performed for SSH, HTTP, FTP and syslog.

Observed process evidence:

- SSH daemon process observed using `/usr/sbin/sshd -f /etc/ssh/sshd_config`.
- HTTP process observed.
- FTP process observed.
- No active syslog daemon process was observed in the captured `grep` output.

## Findings

| Area | Finding | Security relevance |
|---|---|---|
| SSHD | `/etc/ssh/sshd_config` exists | SSH has UNIX-side configuration artifacts |
| SSHD | Protocol 2 observed | Legacy SSH protocol 1 is not evidenced as active |
| SSHD | `PermitRootLogin no` observed | Root login is explicitly disabled in reviewed config |
| SSHD | Password and public key authentication observed | Both authentication paths are visible in config |
| SSHD | Host key references observed | SSH server identity depends on host keys |
| SYSLOGD | `/etc/syslog.conf` not found | No UNIX syslog configuration was evidenced in this path |
| Resolver | `/etc/resolv.conf` not found | No UNIX resolver file was evidenced in this path |
| Hosts | `/etc/hosts` exists | Local host mapping exists and was sanitized |
| Processes | SSH, HTTP and FTP processes observed | UNIX evidence aligns with exposed network services |
| Processes | No syslog daemon process observed | Aligns with previous SYSLOGD NOT FOUND evidence |

## Conclusion

This lab extends the network security baseline from MVS datasets and started tasks into z/OS UNIX.

The most significant result is that SSHD is backed by visible UNIX configuration under `/etc/ssh`, with protocol 2, disabled root login, password and public key authentication, host keys and SFTP subsystem evidence. FTP and HTTP processes were also observed from UNIX process listings. SYSLOGD and `/etc/syslog.conf` were not observed in the captured evidence.

The review was read-only and did not alter any service or configuration file.
