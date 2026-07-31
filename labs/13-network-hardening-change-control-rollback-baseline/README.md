# Lab 13 - z/OS Network Hardening Change Control and Rollback Baseline

## Objective

This lab starts the controlled hardening phase after the read-only network security audit. Before changing any z/OS Communications Server configuration, backup libraries were created and key TCP/IP configuration members and network-related started task procedures were copied into user-owned backup datasets.

The goal is to establish a rollback baseline before any future hardening work involving TCP/IP profiles, TN3270, FTPD, SSHD, HTTPD1, AT-TLS, IPSec, IDS or other network security components.

## Scope

The lab covers backup preparation for:

- `ADCD.Z111S.TCPPARMS(PROF1)`
- `ADCD.Z111S.TCPPARMS(TN3270)`
- `ADCD.Z111S.TCPPARMS(TCPDATA)`
- `ADCD.Z111S.PROCLIB(TCPIP)`
- `ADCD.Z111S.PROCLIB(TN3270)`
- `ADCD.Z111S.PROCLIB(FTPD)`
- `ADCD.Z111S.PROCLIB(SSHD)`
- `ADCD.Z111S.PROCLIB(HTTPD1)`

## Backup datasets

The following backup libraries were used:

```text
IBMUSER.NETSEC.TCPPARMS.BKUP
IBMUSER.NETSEC.PROCLIB.BKUP
```

## Findings

### Backup libraries

The backup libraries were observed in the `IBMUSER.NETSEC.*` dataset list.

### TCP/IP profile member backup

The `CPYTCP` job was used to copy selected members from `ADCD.Z111S.TCPPARMS` into `IBMUSER.NETSEC.TCPPARMS.BKUP`.

Selected members:

```text
PROF1
TN3270
TCPDATA
```

### PROCLIB member backup

The first `CPYPROC` approach used a long multi-member `SELECT MEMBER` statement. This was replaced with a safer one-member-at-a-time `IEBCOPY` control approach.

The final backup library `IBMUSER.NETSEC.PROCLIB.BKUP` was verified to contain:

```text
FTPD
HTTPD1
SSHD
TCPIP
TN3270
```

## Rollback principle

If a future hardening change breaks a network service, the original member can be recovered from the corresponding backup library.

Example rollback direction:

```text
IBMUSER.NETSEC.TCPPARMS.BKUP(PROF1)  -> ADCD.Z111S.TCPPARMS(PROF1)
IBMUSER.NETSEC.PROCLIB.BKUP(SSHD)    -> ADCD.Z111S.PROCLIB(SSHD)
```

No rollback was executed in this lab. The purpose was to create and verify the backup baseline only.

## Safety statement

No active TCP/IP, TN3270, FTPD, SSHD or HTTPD1 configuration was modified.
No `VARY TCPIP,,OBEYFILE` command was issued.
No network service was stopped or started.
No Policy Agent, IKED, TRMD or SYSLOGD component was activated.

## Conclusion

The lab establishes a controlled change baseline for the next phase of network security hardening. Backup libraries exist and key network configuration/procedure members were copied or verified before any future configuration changes are attempted.
