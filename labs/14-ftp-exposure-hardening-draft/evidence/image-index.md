# Evidence Image Index - Lab 14

## 01 - PROF1FTP AUTOLOG overview

File: `screenshots/01_prof1ftp_edit_autolog_section_overview.png`

Shows `IBMUSER.NETSEC.TCPPARMS.BKUP(PROF1FTP)` opened in edit mode around the `AUTOLOG` section.

## 02 - FTPD AUTOLOG commented

File: `screenshots/02_prof1ftp_ftpd_autolog_commented.png`

Shows the FTPD autolog entry commented as a staged hardening draft:

```text
; FTPD JOBNAME FTPD1
```

## 03 - PROF1FTP member created

File: `screenshots/03_tcpparms_backup_member_list_prof1ftp_created.png`

Shows `PROF1FTP` present in the backup TCPPARMS library.

## 04 - Runtime FTP unchanged

File: `screenshots/04_runtime_ftp_port_21_still_listening.png`

Shows FTP port 21 still listening at runtime, confirming that the candidate profile was not applied.
