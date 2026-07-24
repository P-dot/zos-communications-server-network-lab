# Lab 05 - z/OS Network Security Authorization Review

## Objective

This lab documents a read-only RACF/SERVAUTH authorization review for z/OS Communications Server network security resources.

The goal is to check whether RACF SERVAUTH profiles exist for selected TCP/IP and policy-based networking resources, including Communications Server resources (`EZB`), NETSTAT, Policy Agent, stack access, and port access.

## Scope

This lab focuses on RACF SERVAUTH discovery only. No RACF changes were made.

Reviewed resource areas:

- `EZB` Communications Server resources
- `EZB.NETSTAT` resources
- `EZB.PAGENT` resources
- `EZB.STACKACCESS` resources
- `PORTACCESS` / port authorization search evidence

## Safety statement

All commands used in this lab were read-only RACF search commands.

No RACF profiles were created, changed, deleted, or permitted.
No TCP/IP configuration was changed.
No Policy Agent, IKED, TRMD, or network security component was started.
No SERVAUTH profile was modified.

## Commands executed

```text
SEARCH CLASS(SERVAUTH) MASK(EZB)
SEARCH CLASS(SERVAUTH) MASK(EZB.NETSTAT)
SEARCH CLASS(SERVAUTH) MASK(EZB.PAGENT)
SEARCH CLASS(SERVAUTH) MASK(EZB.STACKACCESS)
SEARCH CLASS(SERVAUTH) MASK(PORTACCESS)
```

## Findings

### General EZB SERVAUTH search

`SEARCH CLASS(SERVAUTH) MASK(EZB)` returned:

```text
ICH31005I NO ENTRIES MEET SEARCH CRITERIA
```

This means no SERVAUTH profiles matching the general `EZB` mask were observed in the reviewed RACF search output.

### NETSTAT authorization search

`SEARCH CLASS(SERVAUTH) MASK(EZB.NETSTAT)` returned no entries.

This means no specific `EZB.NETSTAT` SERVAUTH profiles were observed in the reviewed evidence.

### Policy Agent authorization search

`SEARCH CLASS(SERVAUTH) MASK(EZB.PAGENT)` returned no entries.

This means no specific `EZB.PAGENT` SERVAUTH profiles were observed in the reviewed evidence.

### Stack access authorization search

`SEARCH CLASS(SERVAUTH) MASK(EZB.STACKACCESS)` returned no entries.

This means no specific `EZB.STACKACCESS` SERVAUTH profiles were observed in the reviewed evidence.

### Port access authorization search

`SEARCH CLASS(SERVAUTH) MASK(PORTACCESS)` returned no entries.

This provides evidence that no profiles matching the submitted `PORTACCESS` mask were observed.

For a stricter follow-up review, the exact Communications Server naming pattern should also be checked with:

```text
SEARCH CLASS(SERVAUTH) MASK(EZB.PORTACCESS)
```

## Interpretation

No RACF SERVAUTH profiles were observed for the reviewed Communications Server security resource masks in the captured evidence.

This suggests that, for the queried masks, the ADCD lab system does not show explicit RACF SERVAUTH hardening profiles for NETSTAT, Policy Agent, stack access, or port access in the reviewed output.

This is a baseline observation only. It does not modify the system and does not prove that no related controls exist elsewhere. It only documents the observed results of the submitted RACF SEARCH commands.

## Evidence

Screenshots are stored in:

```text
evidence/screenshots/
```

See:

```text
evidence/image-index.md
notes/sanitized-findings.md
notes/commands.md
```

## Security relevance

SERVAUTH is important because z/OS Communications Server can use RACF resources to restrict access to TCP/IP stack services, network management functions, Policy Agent information, and port binding authority.

This lab establishes a read-only baseline before any future hardening proposal.
