# 04 - Commands used

## z/OS / SDSF commands

```text
/D A,TCPIP
/D A,VTAM
/D A,TN3270
/D A,FTPD1
/D A,SSHD4
/D TCPIP,,NETSTAT,DEVLINKS
/D TCPIP,,NETSTAT,HOME
/D TCPIP,,NETSTAT,ROUTE
/D TCPIP,,NETSTAT,CONN
/D TCPIP,,NETSTAT,CONN,PORT=23
/D TCPIP,,NETSTAT,VIPADCFG
/D XCF,S
/D XCF,GRP
/D XCF,COUPLE,TYPE=SYSPLEX
/D XCF,COUPLE,TYPE=WLM
```

## Windows read-only checks

```powershell
ipconfig /all
route print
arp -a
Test-NetConnection <ZOS_IP> -Port 23
Test-NetConnection <ZOS_IP> -Port 22
Test-NetConnection <ZOS_IP> -Port 21
```

## Rule for this repository

Do not commit command output until it has been sanitized.
