# Sanitized Findings - Lab 04

## Profile source

```text
PROFILE DD: ADCD.Z111S.TCPPARMS(PROF1)
SYSTCPD DD: ADCD.Z111S.TCPPARMS(TCPDATA)
```

## Device and link

```text
DEVICE LCS1 LCS E20 AUTORESTART
LINK ETH1 ETHERNET 0 LCS1
```

## HOME and routes

```text
HOME
  <ZOS_IP> ETH1

BEGINRoutes
  ROUTE <LOCAL_SUBNET> <MASK> = ETH1
  ROUTE DEFAULT <DEFAULT_GATEWAY> ETH1
ENDRoutes
```

## Hardening

```text
IPCONFIG NODATAGRAMFWD
UDPCONFIG RESTRICTLOWPORTS
TCPCONFIG RESTRICTLOWPORTS
```

## AUTOLOG

```text
AUTOLOG 5
  FTPD JOBNAME FTPD1    ; FTP Server
ENDAUTOLOG
```

## Port reservations

The profile contains static port reservations for services including FTP, TN3270, SMTP, DNS, HTTP, HTTPS, syslog, Kerberos, MQ and CICS-related services.

## No visible policy-based security references

No visible references to PAGENT, TTLS/AT-TLS, IPSEC, IDS, IKED or TRMD were observed in the provided profile screenshots.

## Publication warning

Do not publish the original DOCX evidence files. Use only the sanitized screenshots and notes included in this lab package.
