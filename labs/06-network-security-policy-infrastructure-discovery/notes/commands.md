# Commands and Navigation Used

## TCPPARMS member discovery

ISPF navigation:

```text
3.4
Dsname Level: ADCD.Z111S.TCPPARMS
Browse / member list
```

Purpose:

```text
Identify TCP/IP profile and policy-related members in the TCPPARMS library.
```

Observed members:

```text
PROFILE
PROF1
PROF2
TCPDATA
TN3270
```

## PROCLIB member discovery

ISPF navigation:

```text
3.4
Dsname Level: ADCD.Z111S.PROCLIB
Browse / member list
```

Purpose:

```text
Identify started task procedures related to z/OS Communications Server, TCP/IP services and network security policy infrastructure.
```

Observed network-related members included:

```text
FTPD
HTTPD1
NFS
NFSC
PORTMAP
SSHD
TCPIP
TN3270
VTAM
```

## Commands intentionally not used

```text
START PAGENT
START IKED
START TRMD
START SYSLOGD
VARY TCPIP,,OBEYFILE
ipsec command
EDIT of TCPPARMS
EDIT of PROCLIB
```
