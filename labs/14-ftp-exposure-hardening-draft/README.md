# Lab 14 - FTP Exposure Hardening Draft

## Objective

This lab starts the controlled hardening phase for the z/OS Communications Server network security track.

The objective is to prepare a staged FTP exposure reduction draft without modifying the active TCP/IP profile and without changing the running TCP/IP stack.

## Context

Previous labs identified FTP as an exposed service:

- `FTPD1` was observed listening on TCP port 21.
- The active TCP/IP profile contained an `AUTOLOG` entry for `FTPD JOBNAME FTPD1`.
- No active Policy Agent / AT-TLS enforcement was observed during the runtime baseline.
- No FTPD-specific RACF certificate or keyring was observed in the certificate inventory.

Because FTP is a clear exposure candidate, this lab prepares a candidate profile member where FTPD autostart is disabled as a draft change.

## Scope

The active system configuration was not changed.

The active member was not edited:

```text
ADCD.Z111S.TCPPARMS(PROF1)
```

The staged candidate member was created and edited in the backup library:

```text
IBMUSER.NETSEC.TCPPARMS.BKUP(PROF1FTP)
```

## Evidence summary

| Evidence | Description |
|---|---|
| `01_prof1ftp_edit_autolog_section_overview.png` | Candidate profile member opened in edit mode around the AUTOLOG section. |
| `02_prof1ftp_ftpd_autolog_commented.png` | FTPD AUTOLOG entry commented in the staged candidate member. |
| `03_tcpparms_backup_member_list_prof1ftp_created.png` | Backup TCPPARMS library showing the new `PROF1FTP` member. |
| `04_runtime_ftp_port_21_still_listening.png` | Runtime FTP port 21 still listening, proving no active stack change was applied. |

## Staged change

Original active-style entry:

```text
FTPD JOBNAME FTPD1
```

Candidate hardening draft:

```text
; FTPD JOBNAME FTPD1
```

## Interpretation

The candidate profile member `PROF1FTP` contains a proposed FTP autostart reduction. If this candidate profile were ever applied in a future controlled change, FTPD would not be started from the `AUTOLOG` section.

However, no active change was performed in this lab. The runtime check still showed FTP port 21 listening, which confirms that the draft was not applied to the active TCP/IP stack.

## Safety controls

The following actions were intentionally not performed:

- No edit of `ADCD.Z111S.TCPPARMS(PROF1)`.
- No `VARY TCPIP,,OBEYFILE`.
- No FTPD stop command.
- No TCP/IP restart.
- No PROFILE replacement.
- No Windows networking changes.

## Rollback position

The original active profile remains intact. The backup library contains both the original backup member and the staged candidate member:

```text
IBMUSER.NETSEC.TCPPARMS.BKUP(PROF1)
IBMUSER.NETSEC.TCPPARMS.BKUP(PROF1FTP)
```

The safe rollback position is to continue using the original active profile and ignore the candidate member unless a future change plan explicitly approves it.

## Conclusion

This lab demonstrates the correct change-control approach for network hardening on z/OS: create a candidate copy, stage the intended change, document the expected impact, prove that no runtime change was applied, and preserve rollback capability before touching the active TCP/IP configuration.
