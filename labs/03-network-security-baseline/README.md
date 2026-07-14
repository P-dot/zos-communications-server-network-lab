# Lab 03 - z/OS Network Security Baseline

## Objective

Document a read-only network security baseline for z/OS Communications Server after TCP/IP connectivity was configured successfully.

The goal is to identify TCP/IP stack readiness, local IP/routing/interface state, listening services, runtime status of policy/security components, IPSec/IKE indicators, Enterprise Extender indicators, and the conceptual fit of AT-TLS, IPSec, IDS and zERT.

## Safety statement

All commands used in this lab were read-only display commands.

No TCP/IP profile changes were made.  
No `VARY TCPIP,,OBEYFILE` command was issued.  
No Policy Agent, IKED, TRMD or SYSLOGD address spaces were started.  
No IPSec, AT-TLS or IDS policy was activated.  
No packet traces, dumps or defensive filters were enabled.  
No RACF/SERVAUTH changes were made.

## Commands used

```text
/D TCPIP,,NETSTAT
/D TCPIP,,NETSTAT,ROUTE
/D TCPIP,,NETSTAT,DEVLINKS
/D TCPIP,,NETSTAT,PORTL
/D TCPIP,,NETSTAT,CONN
/D TCPIP,,NETSTAT,CONN,PORT=21
/D TCPIP,,NETSTAT,CONN,PORT=22
/D TCPIP,,NETSTAT,CONN,PORT=23
/D TCPIP,,NETSTAT,CONN,PORT=80
/D TCPIP,,NETSTAT,CONN,PORT=443
/D A,PAGENT
/D A,IKED
/D A,NSSD
/D A,TRMD
/D A,SYSLOGD
/D TCPIP,,NETSTAT,CONN,PORT=500
/D TCPIP,,NETSTAT,CONN,PORT=4500
/D TCPIP,,NETSTAT,CONN,PORT=12000
/D TCPIP,,NETSTAT,CONN,PORT=12001
/D TCPIP,,NETSTAT,CONN,PORT=12002
/D TCPIP,,NETSTAT,CONN,PORT=12003
/D TCPIP,,NETSTAT,CONN,PORT=12004
/D A,VTAM
/D NET,EE
```

## Runtime findings

### TCP/IP stack and routing

The TCP/IP stack responded to NETSTAT commands.

The route table showed:

- a default route through the local gateway
- a loopback route
- a local subnet route through the active network interface
- a host route for the local z/OS IP address

Sensitive addressing details must be sanitized before public publication.

### Network interface state

The interface evidence showed:

- `LOOPBACK` in `READY` state
- an LCS-backed Ethernet link associated with `ETH1`
- `ETH1` in `READY` state

Local IP addresses, gateways, subnet details and device numbers should be masked before publication.

### Listening services

The socket evidence showed the following listening services:

| Port | Observed jobname | Protocol | State | Security note |
|---:|---|---|---|---|
| 21 | FTPD1 | TCP | LISTEN | FTP is traditionally cleartext unless protected externally |
| 22 | SSHD4 | TCP | LISTEN | SSH service observed |
| 23 | TN3270 | TCP | LISTEN | TN3270 is traditionally cleartext unless protected by TLS/AT-TLS |
| 80 | HTTPD1 | TCP | LISTEN | HTTP service observed |
| 443 | Not observed | TCP | No records | No HTTPS listener observed in this check |
| 500 | Not observed | UDP/TCP check | No records | No IKE listener observed |
| 4500 | Not observed | UDP/TCP check | No records | No IKE NAT-T listener observed |
| 12000-12004 | Not observed | UDP/TCP check | No records | No Enterprise Extender port listeners observed |

### Policy and security components

The following address spaces were checked:

| Component | Runtime result | Interpretation |
|---|---|---|
| PAGENT | NOT FOUND | No runtime evidence of Policy Agent enforcing AT-TLS/IPSec/IDS policy |
| IKED | NOT FOUND | No runtime evidence of dynamic IPSec/IKE negotiation |
| NSSD | NOT FOUND | No runtime evidence of Network Security Services Daemon |
| TRMD | NOT FOUND | No runtime evidence of IDS traffic regulation/reporting daemon |
| SYSLOGD | NOT FOUND | No runtime syslog daemon observed under that jobname |

### AT-TLS

AT-TLS provides stack-based TLS protection for TCP applications through System SSL and policy. Since `PAGENT` was not active in the observed runtime state, no evidence of active AT-TLS policy enforcement was observed.

This does not prove that AT-TLS configuration members do not exist. It only documents runtime state at the time of the check.

### IPSec and IKE

IPSec protects traffic at the IP layer with AH and/or ESP. Dynamic IPSec Security Associations are negotiated by IKED.

No active `IKED` address space was observed, and no connection records were observed for the IKE ports checked in this lab. Therefore, no runtime evidence of dynamic IPSec negotiation was observed.

### IDS

z/OS Communications Server IDS can detect scans, attacks and traffic regulation events. IDS policy enforcement depends on Policy Agent and related reporting components such as TRMD and SYSLOGD.

`PAGENT`, `TRMD` and `SYSLOGD` were not active in the observed runtime state, so no evidence of active IDS policy enforcement/reporting was observed.

### Enterprise Extender

Enterprise Extender was checked because it uses UDP ports 12000-12004 and can be protected by IPSec.

`D NET,EE` reported:

```text
IST2045I ENTERPRISE EXTENDER XCA MAJOR NODE NOT ACTIVE
```

No active Enterprise Extender runtime was observed.

### zERT

zERT was reviewed conceptually as a modern z/OS Communications Server encryption auditing capability. The lab environment is an older ADCD z/OS 1.11 system, while zERT Discovery was introduced in z/OS V2R3. Therefore, zERT is documented as a modern capability but is not expected to be available in this environment.

## Security interpretation

This lab establishes a safe baseline of the network security posture:

- TCP/IP routing and interface configuration are operational.
- Several network services are listening.
- Core policy-driven security components were not active at the time of observation.
- No dynamic IPSec/IKE runtime was observed.
- No Enterprise Extender runtime was observed.
- zERT is not expected due to system release level.

## Publication guidance

Before uploading screenshots to GitHub, mask local z/OS IP address, host IP address, default gateway, subnet details, device numbers, hostnames, local Windows paths and any user IDs that are not generic lab IDs.

Recommended placeholders:

```text
<ZOS_IP>
<HOST_IP>
<DEFAULT_GATEWAY>
<LOCAL_SUBNET>
<LOOPBACK>
<INTERFACE>
<DEVICE_NUMBER>
<JOBNAME>
```
