# Lab 18 - TN3270 Safe Hardening Planning

## Purpose

This lab documents a safe TN3270 hardening planning exercise. TN3270 is the primary interactive access path for 3270/SDSF/TSO sessions in this lab environment, so it was not stopped or cancelled.

The objective was to create a candidate configuration member for future secure-access planning while preserving runtime access and avoiding any permanent TCP/IP change.

## Scope

Reviewed components:

- TN3270 runtime address space
- TCP port 23 listener
- Backup TCP/IP configuration library
- Candidate TN3270 security planning member
- SecurePort / TTLSPort / Keyring examples in the copied member
- BeginVTAM mapping section

## Actions performed

1. Verified TN3270 was active.
2. Verified TCP port 23 was listening.
3. Created a candidate copy of the TN3270 configuration member named `TN3270SEC`.
4. Reviewed secure-port, keyring, and BeginVTAM examples in the candidate member.
5. Added a short planning note to the candidate member:

```text
; HARDENING DRAFT ONLY
; DO NOT OBEYFILE
; TN3270 STOP NOT TESTED
```

6. Verified TN3270 remained active.
7. Verified TCP port 23 remained listening.

## Findings

| Area | Finding | Security relevance |
|---|---|---|
| Runtime | TN3270 was active before and after the planning exercise. | The interactive access path was preserved. |
| Port exposure | TCP port 23 remained in LISTEN state. | No runtime reduction was applied in this lab. |
| Configuration control | A candidate member `TN3270SEC` was created in the backup library. | Planning was isolated from the active configuration. |
| Secure access planning | SecurePort, TTLSPort, Keyring and ClientAuth examples were reviewed. | These are future planning points, not active changes. |
| Change safety | No OBEYFILE command was issued. | The active TCP/IP stack was not reconfigured. |

## Result

TN3270 was treated as a critical access service. A safe hardening planning artifact was prepared, but no runtime shutdown and no active configuration change were performed.

## Safety statement

No `/P TN3270` command was issued. No `/C TN3270` command was issued. No `VARY TCPIP,,OBEYFILE` command was issued. No active `ADCD.Z111S.TCPPARMS(TN3270)` member was modified.
