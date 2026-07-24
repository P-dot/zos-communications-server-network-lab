# Sanitized Findings

## TCPPARMS

The reviewed `ADCD.Z111S.TCPPARMS` member list showed:

```text
PROFILE
PROF1
PROF2
TCPDATA
TN3270
```

No policy members named `PAGENT`, `TTLS`, `IPSEC`, `IDS`, `IKED`, `TRMD` or `SYSLOGD` were observed in the captured list.

## PROCLIB

The reviewed `ADCD.Z111S.PROCLIB` member-list captures showed network-related procedures such as:

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

No `PAGENT`, `IKED`, `TRMD` or `SYSLOGD` procedure was observed in the captured PROCLIB views.

## Scope note

These findings are based only on the captured evidence. They do not prove that matching members are absent from every possible library or concatenation on the system.
