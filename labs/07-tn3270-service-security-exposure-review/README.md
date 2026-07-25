# Lab 07 - TN3270 Service Security Exposure Review

## Objective

This lab reviews the TN3270 service configuration in read-only mode after the z/OS TCP/IP stack was confirmed operational.

The goal is to connect runtime evidence from `NETSTAT CONN,PORT=23` with the actual `ADCD.Z111S.TCPPARMS(TN3270)` configuration member, and to determine whether the observed TN3270 service is using the classic Telnet port or whether secure/TLS-related TN3270 configuration is active in the reviewed member.

## Safety statement

All activity was read-only.

No TN3270 configuration was edited.
No `VARY TCPIP,,OBEYFILE` command was issued.
No TN3270, TCP/IP or VTAM service was stopped or restarted.
No Policy Agent or AT-TLS policy was activated.

## Reviewed source

The reviewed member was:

```text
ADCD.Z111S.TCPPARMS(TN3270)
```

## Key findings

### 1. TN3270 member reviewed

The `TN3270` member was opened in Browse mode. The member contains `TelnetGlobals`, `TelnetParms`, `BeginVTAM` mapping definitions, application access examples, USS mapping statements, printer-related examples and monitoring-related definitions.

### 2. Classic TN3270 port 23 is configured

The active `TelnetParms` section defines:

```text
Port 23
```

This aligns with previous runtime evidence where `TN3270` was observed listening on TCP port 23.

### 3. Secure TN3270 examples are present but commented

The member contains commented examples for secure TN3270/TLS-related ports, including:

```text
TTLSPort 2023
SecurePort 992
Keyring SAF ...
ClientAuth SAF...
Encryption ...
```

These lines were observed as commented sample configuration, not active configuration in the reviewed member.

### 4. VTAM mapping for port 23 is present

The `BeginVTAM` section includes mapping for the basic Telnet/TN3270 port:

```text
BeginVTAM
  Port 23
  DEFAULTLUS ...
  DEFAULTAPPL TSO
  LINEMODEAPPL TSO
  ALLOWAPPL TSO* DISCONNECTABLE
  ALLOWAPPL *
EndVTAM
```

This shows how TN3270 clients are mapped to VTAM/TSO application access.

### 5. Application restrictions and USS mapping examples exist

The member contains examples or definitions related to:

```text
RESTRICTAPPL
USSTCP
IPGROUP
LUGROUP
PRTGROUP
MonitorGroup
```

Sensitive sample IP addresses, hostnames and user-like identifiers were sanitized in the published screenshots.

## Security interpretation

The lab confirms that TN3270 is configured on the traditional Telnet port 23 in the reviewed member. Secure-port and TLS-related examples exist in the member, but they are commented in the reviewed evidence.

Combined with previous labs, no runtime Policy Agent was observed and no active AT-TLS policy enforcement was evidenced at the time of review. Therefore, the documented state is a classic TN3270 service exposure baseline, not a proof of encrypted TN3270 access.

## Conclusion

This lab documents the TN3270 configuration path and establishes a security exposure baseline for interactive z/OS access. It connects the runtime listening service on port 23 with the actual TN3270 configuration member and identifies commented secure-port examples for future hardening analysis.
