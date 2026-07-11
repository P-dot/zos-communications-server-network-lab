# 04 — Security policy runtime baseline

## Question

Are the common policy/security address spaces active at runtime?

## Commands

```text
/D A,PAGENT
/D A,IKED
/D A,NSSD
```

## Evidence

Screenshots:

```text
evidence/sanitized/03_security_pagent_not_found.png
evidence/sanitized/04_security_iked_not_found.png
evidence/sanitized/05_security_nssd_not_found.png
```

Observed result:

```text
PAGENT NOT FOUND
IKED   NOT FOUND
NSSD   NOT FOUND
```

## Interpretation

No active address spaces with those names were observed at runtime.

This is meaningful because the security course module describes policy-based security disciplines such as AT-TLS, IP Security and IDS, with Policy Agent processing and installing policies into the TCP/IP stack.

A cautious conclusion is:

```text
No runtime evidence of policy-driven AT-TLS/IPSec/IDS was observed through PAGENT at the time of capture.
No runtime evidence of IKE negotiation was observed through IKED at the time of capture.
No active NSSD address space was observed under that job name.
```

## What this does not prove

This does not prove that there is no security on the system. It does not prove that no SAF/SERVAUTH controls exist. It does not prove that no application-level security is present.

It only records a runtime baseline from read-only display commands.

## Safety

No security policy was enabled, disabled or changed.
No RACF command was used in this lab.
