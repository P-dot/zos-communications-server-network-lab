# Lab 10 - z/OS Network Security Logging and SMF Readiness Review

## Objective

This lab reviews the logging and audit-readiness posture of the z/OS network security environment in read-only mode.

The objective is to determine whether visible runtime and configuration evidence exists for:

- SMF runtime availability
- SMF recording configuration
- SMFPRMxx parameters relevant to network/security audit records
- SYSLOGD runtime status
- TRMD runtime status
- IDS/zERT logging readiness context

No logging, SMF, IDS, zERT, TCP/IP or started task configuration was modified.

## Scope

Reviewed evidence:

- `/D A,SMF`
- `/D SMF`
- `/D SMF,O`
- `ADCD.Z111S.PARMLIB(SMFPRM00)` in Browse mode
- `/D A,SYSLOGD`
- `/D A,TRMD`

## Findings

### 1. SMF address space observed active

The SMF address space was observed active through `/D A,SMF`.

Security relevance:

SMF is the central z/OS facility used by many components to record system, security, workload and network-related events. A network security monitoring design normally depends on SMF availability.

### 2. SMF MAN recording status reviewed

The `/D SMF` display showed a message indicating that `SYS1.MAN` recording was not being used at the time of the display.

Security relevance:

This is an important operational observation. It means the lab should not assume that MAN data set recording was actively being used from the display alone.

### 3. Active SMF parameters point to SMFPRM00

The `/D SMF,O` output identified the active member as `SMFPRM00`.

Security relevance:

This confirms the PARMLIB member that should be reviewed to understand the active SMF policy/configuration baseline.

### 4. SMFPRM00 contains active SMF recording configuration

`ADCD.Z111S.PARMLIB(SMFPRM00)` was reviewed in Browse mode. The member contains SMF recording-related configuration including MAN data set names, recording behavior, status interval options, exits and SYS/SUBSYS statements.

Observed examples:

- `ACTIVE SMF RECORDING` comment block
- `DSNAME(SYS1.MAN1, SYS1.MAN2, SYS1.MAN3)`
- `NOPROMPT`
- `REC(PERM)`
- `MAXDORM(3000)`
- `STATUS(010000)`
- `JWT(0400)`
- `SID(SYS1)`
- `SYS(NOTYPE(14:19,62:69),...)`
- `SUBSYS(STC,...)`

Security relevance:

The member provides the SMF baseline for audit recording. The captured `SYS(NOTYPE(...))` statement excludes selected ranges of SMF record types but does not visibly exclude type 119 in the reviewed evidence.

### 5. SYSLOGD was not observed active

`/D A,SYSLOGD` returned `SYSLOGD NOT FOUND`.

Security relevance:

z/OS Communications Server IDS can report to syslogd. With SYSLOGD not observed active, there is no runtime evidence in this lab of syslog-based IDS event recording.

### 6. TRMD was not observed active

`/D A,TRMD` returned `TRMD NOT FOUND`.

Security relevance:

TRMD is relevant to IDS event/statistics handling and reporting. With TRMD not observed active, there is no runtime evidence in this lab of IDS reporting infrastructure through TRMD.

### 7. zERT context

zERT was reviewed conceptually as a modern z/OS Communications Server encryption auditing capability. The lab environment is an older ADCD z/OS 1.11 system, while zERT Discovery was introduced in z/OS V2R3. Therefore, zERT is not expected to be available in this environment.

## Conclusion

SMF was observed as an active address space and its active parameter member was identified as `SMFPRM00`. The SMFPRM00 member contains baseline SMF recording configuration, including MAN data sets and SYS/SUBSYS recording rules.

However, SYSLOGD and TRMD were not observed active. Therefore, no runtime evidence of IDS syslog/TRMD reporting infrastructure was observed during this lab. zERT is documented as a modern capability but is not expected in this ADCD z/OS 1.11 environment.

## Safety statement

This lab was performed using read-only display and browse actions only.

No SMF configuration was changed.  
No PARMLIB member was edited.  
No SYSLOGD or TRMD address space was started.  
No IDS or zERT function was activated.  
No TCP/IP profile changes were made.
