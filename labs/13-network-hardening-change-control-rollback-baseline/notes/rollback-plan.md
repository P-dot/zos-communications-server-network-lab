# Rollback Plan

## Purpose

This rollback plan documents how future network hardening changes can be backed out using the backup libraries created in this lab.

## TCPPARMS rollback targets

| Original member | Backup member |
|---|---|
| `ADCD.Z111S.TCPPARMS(PROF1)` | `IBMUSER.NETSEC.TCPPARMS.BKUP(PROF1)` |
| `ADCD.Z111S.TCPPARMS(TN3270)` | `IBMUSER.NETSEC.TCPPARMS.BKUP(TN3270)` |
| `ADCD.Z111S.TCPPARMS(TCPDATA)` | `IBMUSER.NETSEC.TCPPARMS.BKUP(TCPDATA)` |

## PROCLIB rollback targets

| Original member | Backup member |
|---|---|
| `ADCD.Z111S.PROCLIB(TCPIP)` | `IBMUSER.NETSEC.PROCLIB.BKUP(TCPIP)` |
| `ADCD.Z111S.PROCLIB(TN3270)` | `IBMUSER.NETSEC.PROCLIB.BKUP(TN3270)` |
| `ADCD.Z111S.PROCLIB(FTPD)` | `IBMUSER.NETSEC.PROCLIB.BKUP(FTPD)` |
| `ADCD.Z111S.PROCLIB(SSHD)` | `IBMUSER.NETSEC.PROCLIB.BKUP(SSHD)` |
| `ADCD.Z111S.PROCLIB(HTTPD1)` | `IBMUSER.NETSEC.PROCLIB.BKUP(HTTPD1)` |

## Rollback control rule

A rollback should only be performed after identifying the exact changed member, confirming the backup member exists, and documenting the reason for restoration.

This lab did not perform any rollback. It only created and verified the rollback baseline.
