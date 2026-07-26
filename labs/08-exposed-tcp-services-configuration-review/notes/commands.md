# Commands used - Lab 08

## Browse-only configuration review

Reviewed in ISPF Browse mode:

```text
ADCD.Z111S.PROCLIB(FTPD)
ADCD.Z111S.PROCLIB(SSHD)
ADCD.Z111S.PROCLIB(HTTPD1)
```

Search terms used during the review included:

```text
EXEC
PGM=
PARM=
PROFILE
SYSFTPD
FTP.DATA
SYSTCPD
STDENV
BPXBATCH
sshd_config
/etc/ssh
httpd.conf
SSL
KEY
CERT
```

## Runtime correlation commands

```text
/D TCPIP,,NETSTAT,CONN,PORT=21
/D TCPIP,,NETSTAT,CONN,PORT=22
/D TCPIP,,NETSTAT,CONN,PORT=80
/D TCPIP,,NETSTAT,CONN,PORT=443
```

## Commands deliberately not used

```text
START FTPD
START SSHD
START HTTPD1
STOP FTPD
STOP SSHD
STOP HTTPD1
VARY TCPIP,,OBEYFILE
EDIT PROCLIB
EDIT USS configuration files
Activate TLS, AT-TLS or IPsec policy
```
