# Lab 15 - FTP Runtime Exposure Control Drill

## Objective

This lab performs a controlled runtime FTP exposure reduction drill on a z/OS Communications Server lab system.

The goal is to prove that the FTP listener can be reduced at runtime by stopping the FTP started task and then restored again, without changing the active TCP/IP profile, without issuing `VARY TCPIP,,OBEYFILE`, and without modifying permanent network configuration.

## Context

Previous labs established the following baseline:

- FTP was observed listening on TCP port 21.
- `FTPD1` was the runtime jobname associated with the FTP listener.
- A staged hardening draft had already been prepared in a backup TCP/IP profile member.
- The active TCP/IP profile was not modified.

## Safety statement

This lab affects only the runtime FTP service in the local lab environment.

No TCP/IP profile was edited.
No `VARY TCPIP,,OBEYFILE` command was issued.
No port definitions were changed.
No RACF, certificate, keyring, PAGENT, IKED or AT-TLS configuration was changed.
No Windows host network configuration was changed.

## Procedure

1. Display the FTP started task before the runtime change.
2. Confirm TCP port 21 is listening.
3. Stop the FTP runtime service.
4. Confirm the FTP started task is no longer active.
5. Confirm TCP port 21 no longer has a listener.
6. Restore the FTP service.
7. Confirm TCP port 21 is listening again.

## Evidence summary

| Step | Evidence | Result |
|---|---|---|
| Before stop | `D A,FTPD1` | `FTPD1` active |
| Before stop | `NETSTAT CONN,PORT=21` | TCP port 21 listening |
| Runtime control | FTP shutdown command | FTP server shutdown in progress |
| After stop | `D A,FTPD1` | `FTPD1 NOT FOUND` |
| After stop | `NETSTAT CONN,PORT=21` | `0 OF 0 RECORDS DISPLAYED` |
| Recheck | `NETSTAT CONN,PORT=21` | No listener observed |
| Recheck | `D A,FTPD1` | `FTPD1 NOT FOUND` |
| Rollback validation | `NETSTAT CONN,PORT=21` | FTP listener restored |

## Findings

### Finding 1 - FTP listener was active before the drill

`FTPD1` was observed as an active address space and TCP port 21 was observed in `LISTEN` state.

### Finding 2 - Runtime FTP exposure was reduced

After stopping FTP, `FTPD1` was no longer found and TCP port 21 returned no active records.

### Finding 3 - Runtime rollback was validated

A later `NETSTAT CONN,PORT=21` check showed TCP port 21 listening again, proving that the service was restored.

### Finding 4 - No permanent network configuration change was applied

The drill did not modify the active TCP/IP profile or apply a candidate profile through `OBEYFILE`.

## Security relevance

FTP is a classic exposed TCP service. In environments where FTP is not required or where encrypted alternatives are preferred, reducing or controlling FTP exposure is a common hardening objective.

This lab demonstrates the operational control of FTP exposure at runtime while preserving rollback capability.

## Conclusion

The FTP runtime exposure drill was completed successfully. FTP was observed active, stopped, verified as no longer listening, and later restored. The exercise was controlled, reversible, and did not change permanent TCP/IP configuration.
