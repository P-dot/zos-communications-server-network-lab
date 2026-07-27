# Sanitized Findings - Lab 10

## Observed

- SMF address space was observed active.
- `/D SMF,O` identified `SMFPRM00` as the active SMF parameter member.
- `SMFPRM00` contains baseline SMF recording configuration, including MAN data set definitions and SYS/SUBSYS rules.
- `SYSLOGD` was not found active.
- `TRMD` was not found active.

## Interpretation

- The system has visible SMF infrastructure.
- The captured `/D SMF` output indicates that `SYS1.MAN` recording was not being used at the time of the display.
- No runtime evidence of SYSLOGD/TRMD-based IDS event reporting was observed.
- zERT is not expected in this ADCD z/OS 1.11 environment because zERT Discovery was introduced in later z/OS releases.

## Sanitization

- No IP addresses are included in this lab.
- Original DOCX file should not be published.
- Internal timestamps, system identifiers and dataset names are retained only where they are part of the educational ADCD baseline.
