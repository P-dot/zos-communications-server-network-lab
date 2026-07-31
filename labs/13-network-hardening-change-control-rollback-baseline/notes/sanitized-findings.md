# Sanitized Findings

## Finding 1 - Backup libraries were created or already existed

Two user-owned backup PDS libraries were present:

```text
IBMUSER.NETSEC.TCPPARMS.BKUP
IBMUSER.NETSEC.PROCLIB.BKUP
```

## Finding 2 - TCPPARMS backup was prepared

The TCPPARMS backup JCL targeted these members:

```text
PROF1
TN3270
TCPDATA
```

## Finding 3 - Initial CPYPROC needed correction

The initial PROCLIB copy job used a long multi-member `SELECT MEMBER` statement. A corrected version copied one member per `COPY/SELECT` block to avoid IEBCOPY control statement issues.

## Finding 4 - PROCLIB backup contents were verified

The backup library `IBMUSER.NETSEC.PROCLIB.BKUP` was verified to contain:

```text
FTPD
HTTPD1
SSHD
TCPIP
TN3270
```

## Security relevance

This backup baseline reduces operational risk before future hardening work. It provides a recovery point before changes to network service procedures or TCP/IP configuration are attempted.
