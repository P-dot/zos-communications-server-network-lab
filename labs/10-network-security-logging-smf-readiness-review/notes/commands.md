# Commands - Lab 10

All commands were read-only.

## Runtime displays

```text
/D A,SMF
/D SMF
/D SMF,O
/D A,SYSLOGD
/D A,TRMD
```

## PARMLIB review

```text
ISPF 3.4
Dataset: ADCD.Z111S.PARMLIB
Member:  SMFPRM00
Mode:    Browse
```

Search terms used conceptually:

```text
SYS(
TYPE
119
INTVAL
SUBSYS
TCPIP
OMVS
```

## Commands intentionally not used

```text
SET SMF
START SYSLOGD
START TRMD
EDIT SMFPRM00
VARY TCPIP,,OBEYFILE
START PAGENT
START IKED
```
