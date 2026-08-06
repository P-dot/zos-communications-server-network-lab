# Commands - Lab 16

All commands were runtime display/control commands. No permanent configuration member was modified.

## Initial state

```text
/D A,HTTPD1
/D TCPIP,,NETSTAT,CONN,PORT=80
/D TCPIP,,NETSTAT,CONN,PORT=443
```

## Runtime exposure reduction

```text
/P HTTPD1
/D A,HTTPD1
/D TCPIP,,NETSTAT,CONN,PORT=80
```

## Rollback validation

```text
/S HTTPD1
/D A,HTTPD1
/D TCPIP,,NETSTAT,CONN,PORT=80
```

## Explicitly not performed

```text
VARY TCPIP,,OBEYFILE
EDIT ADCD.Z111S.PROCLIB(HTTPD1)
EDIT HTTP configuration files
START PAGENT
Certificate or keyring changes
HTTPS enablement
```
