# Lab 04 Commands - TCP/IP Profile Security Review

## Locate active TCP/IP profile from SDSF

```text
SDSF
ST
```

Select the active TCPIP started task and browse its expanded JCL/output.

Search terms used:

```text
F PROFILE
F TCPPARMS
F SYSTCPD
F TCPDATA
```

Observed active profile:

```text
ADCD.Z111S.TCPPARMS(PROF1)
```

Observed SYSTCPD/TCPDATA member:

```text
ADCD.Z111S.TCPPARMS(TCPDATA)
```

## Browse profile member

In ISPF option 3.4:

```text
ADCD.Z111S.TCPPARMS
```

Open member:

```text
PROF1
```

Mode used:

```text
BROWSE only
```

## Search terms inside PROF1

```text
F DEVICE
F LINK
F HOME
F BEGINROUTES
F IPCONFIG
F UDPCONFIG
F TCPCONFIG
F AUTOLOG
F PORT
F PAGENT
F TTLS
F IPSEC
F IDS
F IKED
F TRMD
```

## Commands intentionally not used

```text
VARY TCPIP,,OBEYFILE
START PAGENT
START IKED
START TRMD
EDIT ADCD.Z111S.TCPPARMS(PROF1)
ipsec command
packet trace commands
```
