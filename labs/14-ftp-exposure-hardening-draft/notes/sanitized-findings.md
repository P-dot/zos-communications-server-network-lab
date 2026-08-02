# Sanitized Findings - Lab 14

## Finding 1 - FTP autostart draft prepared

A candidate TCP/IP profile member was created in the backup library:

```text
IBMUSER.NETSEC.TCPPARMS.BKUP(PROF1FTP)
```

The FTPD AUTOLOG entry was commented in the candidate member:

```text
; FTPD JOBNAME FTPD1
```

## Finding 2 - Active TCP/IP profile not modified

The active profile member was not edited:

```text
ADCD.Z111S.TCPPARMS(PROF1)
```

## Finding 3 - No runtime change applied

A runtime NETSTAT check showed FTP port 21 still listening. This confirms that the staged candidate member was not applied to the active TCP/IP stack.

## Finding 4 - Change control posture

The lab created a draft hardening change while preserving rollback capability and avoiding active network disruption.
