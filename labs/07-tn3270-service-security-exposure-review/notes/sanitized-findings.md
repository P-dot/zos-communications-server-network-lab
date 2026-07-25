# Sanitized findings

## Observed configuration

```text
ADCD.Z111S.TCPPARMS(TN3270)
```

Observed relevant statements and sections:

```text
TelnetGlobals
TelnetParms
Port 23
BeginVTAM
DEFAULTLUS
DEFAULTAPPL TSO
LINEMODEAPPL TSO
ALLOWAPPL
RESTRICTAPPL
USSTCP
IPGROUP
LUGROUP
PRTGROUP
MonitorGroup
EndVTAM
```

## Security-relevant observations

- TN3270 is configured on classic TCP port 23.
- Secure TN3270 examples such as `TTLSPort`, `SecurePort`, `Keyring`, `ClientAuth` and cipher/encryption options were observed as commented sample configuration.
- Application mapping and access-related statements exist in the member.
- Sensitive IP addresses, hostnames and user-like identifiers were sanitized before publication.

## Not claimed

This lab does not claim that no secure TN3270 configuration exists anywhere else on the system. It only documents what was observed in the reviewed `TN3270` member and previous runtime evidence.
