# 06 — Read-only commands and safety boundary

## Commands used

```text
/D NET,ID=OSATRL1E
/D TCPIP,,NETSTAT,HOME
/D A,TCPIP
/D A,VTAM
/D A,TN3270
/D A,PAGENT
/D A,IKED
/D A,NSSD
/D NET,EE
```

## Browse-only configuration discovery

The active VTAM started task output was inspected from SDSF to identify the `VTAMLST` DD concatenation.

## Commands intentionally avoided

```text
VARY TCPIP,,OBEYFILE
VARY NET,...
MODIFY VTAM,...
START/STOP network resources
TRACE activation
DUMP commands
RACF changes
host network adapter changes
```

## Why this matters

The goal is to build operational understanding and portfolio evidence without destabilizing the learning system.

Read-only evidence is enough for this lab:

```text
configuration path discovered
TRLE existence and inactive state proven
security-policy runtime absence observed
Enterprise Extender inactive state proven
```
