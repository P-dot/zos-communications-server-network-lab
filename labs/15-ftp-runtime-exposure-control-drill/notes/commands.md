# Commands Used - Lab 15

## Baseline

```text
/D A,FTPD1
/D TCPIP,,NETSTAT,CONN,PORT=21
```

## Runtime exposure reduction

```text
/P FTPD1
```

## Verification after stop

```text
/D A,FTPD1
/D TCPIP,,NETSTAT,CONN,PORT=21
```

## Rollback / restoration validation

The captured evidence shows TCP port 21 listening again after service restoration.

```text
/D TCPIP,,NETSTAT,CONN,PORT=21
```

## Commands intentionally not used

```text
VARY TCPIP,,OBEYFILE
EDIT ADCD.Z111S.TCPPARMS(PROF1)
START PAGENT
START IKED
START TRMD
RACDCERT ADD
RACDCERT CONNECT
```
