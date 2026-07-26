# Sanitized findings

## Positive evidence

- RACF CERTAUTH certificate material was observed.
- Multiple certificate authority entries were observed.
- Some certificate entries showed ring associations.
- At least one trusted certificate authority entry was observed.

## Negative evidence

- No certificate information was observed for `TCPIP`.
- No RACF keyrings were observed for `TCPIP`.
- No certificate information was observed for `FTPD`.
- No RACF keyrings were observed for `FTPD`.
- `WEBSERV` was not defined to RACF in the reviewed evidence.
- No certificate information was observed for `START2`.
- No RACF keyrings were observed for `START2`.

## Evidence limitations

- `RACDCERT SITE LIST` output was not observed in the provided evidence.
- `RACDCERT ID(START1)` output was not observed in the provided evidence.
- Findings are limited to the screenshots reviewed.
