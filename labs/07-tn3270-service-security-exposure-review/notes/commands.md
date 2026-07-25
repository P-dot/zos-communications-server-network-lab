# Commands and navigation used

## Runtime context from previous lab

```text
/D TCPIP,,NETSTAT,CONN,PORT=23
```

Purpose: confirm whether TN3270 is listening on TCP port 23.

## Configuration review

```text
ISPF 3.4
ADCD.Z111S.TCPPARMS
Browse member TN3270
```

Searches performed in Browse mode:

```text
F PORT
F TELNETPARMS
F BEGINVTAM
F ENDVTAM
F SECURITY
F SECUREPORT
F KEYRING
F CONNTYPE
F LU
F DEFAULTLUS
F ALLOWAPPL
F RESTRICTAPPL
```

No edit, activation or refresh command was issued.
