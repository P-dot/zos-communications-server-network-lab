# Commands - Lab 19

## Runtime identity discovery

```text
/D A,FTPD1
/D A,SSHD4
/D A,HTTPD1
/D A,TN3270
```

Purpose: identify whether each network-facing started task is active and which RACF `USERID=` is attached to the address space.

Observed mapping:

```text
FTPD1   -> USERID=FTPD
SSHD4   -> USERID=START2
HTTPD1  -> USERID=WEBSRV1
TN3270  -> USERID=START2
```

## RACF global options review

```text
SETROPTS LIST
```

Purpose: inspect active RACF class and global option context. This is read-only.

## STARTED class discovery

```text
SEARCH CLASS(STARTED)
```

Purpose: discover RACF profiles in the STARTED class before querying individual profile names.

## Specific STARTED profile checks

```text
RLIST STARTED FTPD.* ALL
RLIST STARTED SSHD.* ALL
RLIST STARTED HTTPD1.* ALL
RLIST STARTED TN3270.* ALL
```

Purpose: determine whether explicit STARTED class profiles exist for the observed network service names.

Observed result summary:

```text
FTPD.*    -> found
SSHD.*    -> not found under that exact name
HTTPD1.*  -> not found under that exact name
TN3270.*  -> not found under that exact name
```

## Shared runtime identity review

```text
LU START2
```

Purpose: inspect the RACF profile for the shared runtime identity used by SSHD4 and TN3270.

## Commands intentionally not executed

```text
RDEFINE STARTED
RALTER STARTED
PERMIT
SETROPTS RACLIST(STARTED) REFRESH
STOP/CANCEL network services
VARY TCPIP,,OBEYFILE
```
