# Commands - Lab 14

## Backup library reviewed

```text
IBMUSER.NETSEC.TCPPARMS.BKUP
```

## Candidate member created

```text
IBMUSER.NETSEC.TCPPARMS.BKUP(PROF1FTP)
```

## Profile section reviewed

```text
F AUTOLOG
```

## Candidate change staged

```text
AUTOLOG 5
; FTPD JOBNAME FTPD1
ENDAUTOLOG
```

## Runtime validation

```text
/D TCPIP,,NETSTAT,CONN,PORT=21
```

## Commands intentionally not issued

```text
VARY TCPIP,,OBEYFILE
STOP FTPD
P FTPD
MODIFY TCPIP
EDIT ADCD.Z111S.TCPPARMS(PROF1)
```
