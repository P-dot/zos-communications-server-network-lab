# Sanitized Findings - Lab 19

## Finding 1 - FTPD1 uses a dedicated identity

`FTPD1` was active and showed `USERID=FTPD`.

Security interpretation: FTP has a dedicated started-task identity in the captured baseline.

## Finding 2 - HTTPD1 uses a dedicated identity

`HTTPD1` was active and showed `USERID=WEBSRV1`.

Security interpretation: HTTP has a dedicated service-style identity in the captured baseline.

## Finding 3 - SSHD4 and TN3270 share START2

`SSHD4` and `TN3270` both showed `USERID=START2`.

Security interpretation: this shared identity should be reviewed before deeper hardening because it is associated with more than one network-facing service.

## Finding 4 - STARTED class profiles exist

`SEARCH CLASS(STARTED)` returned multiple STARTED profiles.

Security interpretation: the environment uses RACF STARTED class profile mappings, so service identity assignment can be audited through RACF profile evidence.

## Finding 5 - FTPD has an explicit STARTED profile

`RLIST STARTED FTPD.* ALL` returned a generic STARTED profile.

Security interpretation: FTP has explicit RACF STARTED profile evidence.

## Finding 6 - Exact SSHD, HTTPD1 and TN3270 STARTED profiles were not found

The exact commands for `SSHD.*`, `HTTPD1.*`, and `TN3270.*` returned not found.

Security interpretation: this does not prove absence of started-task identity mapping. It means the exact profile names tested were not present. The mapping might be provided by broader generic rules, alternative names, or legacy mechanisms.

## No-change assurance

This lab was an audit-only lab. No RACF profiles, started task definitions, TCP/IP profiles or runtime services were modified.
