# Commands used

## Runtime validation before planning

```text
/D A,TN3270
/D TCPIP,,NETSTAT,CONN,PORT=23
```

## Candidate member creation

The active member was not modified. A copy was created in the backup library:

```text
IBMUSER.NETSEC.TCPPARMS.BKUP(TN3270SEC)
```

## Candidate member review

```text
F PORT
F TTLSPORT
F SECUREPORT
F KEYRING
F CLIENTAUTH
F ENCRYPTION
F BEGINVTAM
```

## Runtime validation after planning

```text
/D A,TN3270
/D TCPIP,,NETSTAT,CONN,PORT=23
```

## Commands intentionally not used

```text
/P TN3270
/C TN3270
VARY TCPIP,,OBEYFILE
```
