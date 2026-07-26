# Lab 09 - RACF Certificate and Keyring Inventory for Network Security

## Objective

This lab reviews RACF digital certificate and keyring inventory relevant to z/OS network security in read-only mode.

The objective is to determine whether certificate material exists for TCP/IP-related users or services that could support TLS, AT-TLS, HTTPS, FTPS, secure TN3270 or IPSec/IKE configurations.

No certificate or keyring changes were performed.

## Source evidence

The lab is based on screenshots captured from RACF `RACDCERT` display commands.

The original evidence document was not included in this repository because it contains certificate labels, serial numbers, distinguished names, certificate IDs and keyring names. Public evidence images were replaced with sanitized summary screenshots.

## Commands reviewed

```text
RACDCERT CERTAUTH LIST
RACDCERT ID(TCPIP) LIST
RACDCERT ID(TCPIP) LISTRING(*)
RACDCERT ID(FTPD) LIST
RACDCERT ID(FTPD) LISTRING(*)
RACDCERT ID(WEBSERV) LIST
RACDCERT ID(WEBSERV) LISTRING(*)
RACDCERT ID(START2) LIST
RACDCERT ID(START2) LISTRING(*)
```

## Findings

### CERTAUTH certificate inventory

`RACDCERT CERTAUTH LIST` returned RACF certificate authority entries.

The reviewed output showed multiple CA certificates, status values such as `TRUST` and `NOTRUST`, and some ring associations.

This indicates that RACF certificate authority material exists in the environment and may support TLS trust validation for components using System SSL or RACF keyrings.

Sensitive certificate details were redacted.

### TCPIP user

No personal certificate information was observed for `TCPIP`.

No RACF keyrings were observed for `TCPIP`.

### FTPD user

No personal certificate information was observed for `FTPD`.

No RACF keyrings were observed for `FTPD`.

### WEBSERV user

The reviewed evidence showed that `WEBSERV` was not defined to RACF.

Therefore, WEBSERV-specific certificate and keyring inventory could not be performed for that user ID.

### START2 user

No personal certificate information was observed for `START2`.

No RACF keyrings were observed for `START2`.

## Security interpretation

The environment contains RACF CERTAUTH material, but no service-owned certificates or keyrings were observed for the reviewed service users.

This supports earlier network security findings:

- FTP was observed on TCP port 21, but no FTPD-owned RACF certificate/keyring was observed.
- HTTP was observed on TCP port 80, while HTTPS on TCP 443 was not observed in runtime evidence.
- TN3270 was observed on TCP port 23, while secure TN3270 examples in the configuration were commented.
- Policy Agent was not observed active in runtime evidence, so active AT-TLS policy enforcement was not evidenced.

## Limitations

The evidence reviewed does not include a captured `RACDCERT SITE LIST` result.

The evidence reviewed does not include a captured `RACDCERT ID(START1)` result.

Therefore, this lab documents observed evidence only and does not claim that no certificates or keyrings exist anywhere else in the system.

## Safety statement

All commands used in this lab were read-only RACF display commands.

No `RACDCERT ADD`, `GENCERT`, `DELETE`, `CONNECT`, `REMOVE`, `ALTER` or `SETROPTS RACLIST REFRESH` command was issued.
