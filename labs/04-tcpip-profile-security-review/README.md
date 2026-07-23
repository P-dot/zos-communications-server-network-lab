# Lab 04 - z/OS TCP/IP Profile Security Review

## Objective

This lab documents a read-only review of the active TCP/IP profile used by the z/OS Communications Server TCP/IP started task.

The goal is to connect the runtime evidence collected in Lab 03 with the actual TCP/IP configuration source used by the system.

## Safety statement

All work in this lab was performed in read-only mode.

No TCP/IP profile changes were made.  
No `VARY TCPIP,,OBEYFILE` command was issued.  
No Policy Agent, IKED, TRMD, AT-TLS, IPSec or IDS policy was started or activated.  
No packet traces, dumps or defensive filters were enabled.

## Evidence source

The TCP/IP started task output was reviewed from SDSF. The active procedure shows:

```text
PROFILE DD  DSN=ADCD.Z111S.TCPPARMS(PROF1)
SYSTCPD DD  DSN=ADCD.Z111S.TCPPARMS(TCPDATA)
```

Therefore, the active TCP/IP profile reviewed in this lab is:

```text
ADCD.Z111S.TCPPARMS(PROF1)
```

## Finding 1 - TCP/IP profile source identified

The TCP/IP started task JCL identifies the profile data set and member used by the running stack.

Evidence:

```text
evidence/screenshots/00_tcpip_started_task_profile_dd.png
```

This proves that the subsequent profile review is based on the actual configuration source used by the active TCP/IP address space.

## Finding 2 - Network device and link definition

The profile contains an LCS network device and Ethernet link definition:

```text
DEVICE LCS1 LCS E20 AUTORESTART
LINK ETH1 ETHERNET 0 LCS1
```

Interpretation:

- `LCS1` is the network device definition used by the stack.
- `ETH1` is the Ethernet link associated with that device.
- `AUTORESTART` indicates that TCP/IP can attempt recovery of the device when appropriate.

Evidence:

```text
evidence/screenshots/01_profile_device_link_home_routes_sanitized.png
```

## Finding 3 - Local IP and static routing defined in the profile

The profile contains a `HOME` section and a `BEGINRoutes` section.

Sensitive addressing information was sanitized before publication:

```text
HOME
  <ZOS_IP> ETH1

BEGINRoutes
  ROUTE <LOCAL_SUBNET> <MASK> = ETH1
  ROUTE DEFAULT <DEFAULT_GATEWAY> ETH1
ENDRoutes
```

Interpretation:

- `HOME` defines the local IP address assigned to the TCP/IP stack.
- `BEGINRoutes` defines static routes.
- The default route sends traffic toward the local gateway through `ETH1`.

This aligns with the Lab 03 runtime evidence from `NETSTAT HOME` and `NETSTAT ROUTE`.

## Finding 4 - Baseline hardening statements

The profile contains baseline hardening options:

```text
IPCONFIG NODATAGRAMFWD
UDPCONFIG RESTRICTLOWPORTS
TCPCONFIG RESTRICTLOWPORTS
```

Interpretation:

- `NODATAGRAMFWD` indicates that the stack is not configured for general IP forwarding.
- `RESTRICTLOWPORTS` restricts use of privileged low ports.
- The configuration is consistent with a host-oriented TCP/IP stack rather than a routing/gateway role.

Evidence:

```text
evidence/screenshots/02_profile_hardening_nodatagramfwd_restrictlowports.png
```

## Finding 5 - AUTOLOG starts FTPD

The profile contains an `AUTOLOG` section that starts the FTP server:

```text
AUTOLOG 5
  FTPD JOBNAME FTPD1    ; FTP Server
ENDAUTOLOG
```

Interpretation:

- FTPD is configured for automatic startup from the TCP/IP profile.
- The job name used is `FTPD1`.
- This matches Lab 03 runtime evidence where FTPD1 was observed listening on TCP port 21.

Evidence:

```text
evidence/screenshots/03_profile_autolog_ftpd.png
```

## Finding 6 - PORT reservations

The profile contains a `PORT` section with reservations for classic z/OS network services.

Examples observed include:

```text
20 TCP OMVS      NOAUTOLOG   ; FTP Server
21 TCP OMVS                  ; FTP Server
23 TCP TN3270                ; Telnet Server
25 TCP SMTP                  ; SMTP Server
53 TCP/UDP NAMESRV           ; Domain Name Server
80 TCP OMVS                  ; OE WEB SERVER
111 TCP/UDP PORTMAP          ; Portmap Server
443 TCP OMVS                 ; Secure Server
514 UDP OMVS                 ; OE syslog server
515 TCP LPSERVE              ; LPD Server
750 TCP/UDP MVSKERB          ; Kerberos
1415 TCP CSQ1CHIN            ; MQ TCP Listener
3000 TCP CICSTCP             ; CICS Socket
9080 TCP BBODMGR             ; HTTP port
9090 TCP BBODMGR             ; HTTP port
```

Interpretation:

The `PORT` section is the static profile configuration for port reservations. It should be compared with:

- `NETSTAT PORTL` for ports currently loaded by the stack.
- `NETSTAT CONN` for services actually listening or connected at runtime.

Evidence:

```text
evidence/screenshots/04_profile_port_section_initial_reservations.png
evidence/screenshots/05_profile_port_section_reserved_services.png
```

## Finding 7 - No visible policy-based security references in reviewed screenshots

In the reviewed profile screenshots, no visible references were observed for:

```text
PAGENT
TTLS / AT-TLS
IPSEC
IDS
IKED
TRMD
```

This does not prove that such configuration does not exist elsewhere in the system. It only documents that no such references were visible in the provided profile evidence.

## Security interpretation

This lab strengthens the baseline established in Lab 03:

- Lab 03 documented runtime network posture.
- Lab 04 identifies the TCP/IP profile source behind that runtime posture.
- The profile confirms interface, local addressing, static routing, basic hardening, automatic FTP startup and port reservations.

## Sanitization

The following values were sanitized before publication:

- Local z/OS IP address
- Local subnet
- Default gateway
- Other route values not required for public evidence

The original DOCX evidence should not be committed to GitHub because it contains unsanitized network information.
