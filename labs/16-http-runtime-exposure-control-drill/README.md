# Lab 16 - HTTP Runtime Exposure Control Drill

## Objective

This lab performs a controlled runtime exposure reduction drill for the HTTP service in the z/OS Communications Server lab environment.

The goal is to verify that HTTPD1 can be stopped at runtime, that the TCP port 80 listener disappears, and that the service can be restored afterwards. The lab also checks TCP port 443 as a reference point for HTTPS exposure.

## Scope

Reviewed and controlled runtime elements:

- HTTPD1 started task
- TCP port 80 HTTP listener
- TCP port 443 HTTPS reference check
- Runtime stop and restart validation

Out of scope:

- Permanent TCP/IP profile changes
- HTTPD1 PROC changes
- HTTP configuration file changes
- HTTPS enablement
- Certificate/keyring changes
- AT-TLS or Policy Agent activation

## Safety statement

This lab controlled only the runtime state of HTTPD1. No permanent configuration member was edited, no OBEYFILE command was issued, and no TCP/IP profile was changed.

Rollback was validated by restarting HTTPD1 and confirming that TCP port 80 returned to LISTEN state.

## Evidence summary

| Step | Evidence | Result |
|---|---|---|
| Before stop | HTTPD1 address space display | HTTPD1 active |
| Before stop | NETSTAT CONN,PORT=80 | HTTPD1 listening on TCP 80 |
| Reference check | NETSTAT CONN,PORT=443 | No records displayed |
| Runtime control | Stop HTTPD1 | Stop/control action issued; service state changed |
| After stop | HTTPD1 address space display | HTTPD1 not found |
| After stop | NETSTAT CONN,PORT=80 | No records displayed |
| Rollback | Restart HTTPD1 | HTTPD1 active again |
| Rollback | NETSTAT CONN,PORT=80 | HTTPD1 listening again on TCP 80 |

## Findings

### Finding 1 - HTTPD1 was exposed on TCP port 80

HTTPD1 was observed as an active address space and `NETSTAT CONN,PORT=80` showed the service listening on TCP port 80.

Security relevance: TCP port 80 represents clear-text HTTP service exposure unless protected by another mechanism in front of it.

### Finding 2 - HTTPS on TCP port 443 was not observed

`NETSTAT CONN,PORT=443` returned no records in the captured evidence.

Security relevance: no active HTTPS listener was observed during this drill.

### Finding 3 - Runtime exposure was reduced by stopping HTTPD1

After the HTTPD1 runtime stop action, the HTTPD1 address space was no longer found and TCP port 80 returned no records.

Security relevance: service exposure can be reduced operationally without changing permanent TCP/IP configuration.

### Finding 4 - Rollback was validated

HTTPD1 was restored and TCP port 80 returned to LISTEN state.

Security relevance: the operation was reversible and controlled.

## Conclusion

The lab demonstrates controlled runtime reduction of HTTP exposure and successful rollback. HTTPD1 was active and listening on TCP port 80, was stopped so that the listener disappeared, and was later restored so that TCP port 80 returned to LISTEN state.

No permanent network configuration change was applied.
