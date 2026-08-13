# Lab 19 - Network Started Task Identity Baseline

## Purpose

This lab documents the RACF runtime identities used by network-facing started tasks in a z/OS ADCD laboratory system.

The goal is not to change the system. The goal is to build a security baseline that connects:

```text
network service -> started task/jobname -> RACF runtime user ID -> STARTED class evidence
```

This is important because an exposed network service is also an exposed operating identity. Before hardening FTP, SSH, HTTP or TN3270 permanently, the service identity must be known.

## Scope

Reviewed services:

| Service | Runtime jobname | Network role | Observed runtime USERID |
|---|---:|---|---|
| FTP | FTPD1 | FTP server / TCP 21 | FTPD |
| SSH | SSHD4 | SSH server / TCP 22 | START2 |
| HTTP | HTTPD1 | Web server / TCP 80 | WEBSRV1 |
| TN3270 | TN3270 | 3270 interactive access / TCP 23 | START2 |

## Main findings

1. `FTPD1` runs under a dedicated RACF identity: `FTPD`.
2. `HTTPD1` runs under a dedicated RACF identity: `WEBSRV1`.
3. `SSHD4` and `TN3270` both run under the shared started-task identity `START2`.
4. RACF `SETROPTS LIST` was reviewed to understand the active RACF class environment.
5. `SEARCH CLASS(STARTED)` returned multiple `STARTED` class profiles, confirming that started-task identity mapping is present in the RACF database.
6. `RLIST STARTED FTPD.* ALL` found an explicit generic STARTED profile for FTP.
7. `RLIST STARTED SSHD.* ALL`, `RLIST STARTED HTTPD1.* ALL`, and `RLIST STARTED TN3270.* ALL` did not find profiles under those exact names.
8. `LU START2` was reviewed because `START2` is used by more than one network-facing service.

## Interpretation

The most relevant security observation is that not all network daemons use the same identity.

`FTPD1` and `HTTPD1` appear to use service-oriented identities. `SSHD4` and `TN3270` share `START2`, which is acceptable as a lab baseline but should be reviewed before enterprise hardening.

The `NOT FOUND` results for some `RLIST STARTED` commands do not prove that the tasks have no RACF started-task mapping. They only prove that profiles with those exact names were not found. The runtime identity can still come from a broader generic STARTED profile, another naming pattern, or legacy started procedure mechanisms.

## Commands executed

All commands were read-only except normal display/listing operations.

```text
/D A,FTPD1
/D A,SSHD4
/D A,HTTPD1
/D A,TN3270
SETROPTS LIST
SEARCH CLASS(STARTED)
RLIST STARTED FTPD.* ALL
RLIST STARTED SSHD.* ALL
RLIST STARTED HTTPD1.* ALL
RLIST STARTED TN3270.* ALL
LU START2
```

## Safety statement

No hardening change was applied in this lab.

```text
No RDEFINE STARTED
No RALTER STARTED
No PERMIT
No SETROPTS RACLIST REFRESH
No user ID assignment change
No PROCLIB change
No TCP/IP profile change
No service restart
No service stop
No OBEYFILE
```

## Evidence

Evidence screenshots are stored in:

```text
evidence/screenshots/
```

Evidence list:

```text
01_ftpd1_runtime_userid.png
02_sshd4_runtime_userid.png
03_httpd1_runtime_userid.png
04_tn3270_runtime_userid.png
05_setropts_list_active_classes_part1.png
06_setropts_list_started_raclist_global_options.png
07_setropts_list_misc_options_part1.png
08_setropts_list_misc_options_part2.png
09_search_started_class_part1.png
10_search_started_class_part2.png
11_rlist_started_ftpd_profile_part1.png
12_rlist_started_ftpd_profile_part2.png
13_rlist_started_sshd_not_found.png
14_rlist_started_httpd1_not_found.png
15_rlist_started_tn3270_not_found.png
16_listuser_start2_runtime_identity.png
```

## Portfolio conclusion

This lab establishes a baseline of RACF runtime identities for network-facing started tasks. It demonstrates that network exposure analysis on z/OS should not stop at ports and listeners: each service must also be mapped to its started-task identity and RACF profile evidence before any permanent hardening is planned.

## References

- IBM, z/OS MVS JCL Reference, section on started tasks and START command processing.
- IBM, z/OS Security Server RACF Security Administrator's Guide, RACF classes, SETROPTS, SEARCH, RLIST and user/profile listing concepts.
- Dinesh D. Dattani, IBM Mainframe Security: Beyond the Basics, chapters on started procedures and security administration.
