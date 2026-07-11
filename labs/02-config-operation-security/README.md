# Lab 02 — z/OS Communications Server Configuration, Operation, Security and Enterprise Extender

This lab is a continuation of **Lab 01 — z/OS Communications Server Network Evidence Lab**.

Lab 01 proved the basic Communications Server runtime and diagnosed a network attachment boundary: TCP/IP, VTAM and TN3270 were active internally, services were listening, VIPA was not configured, and the external emulated link was not usable.

Lab 02 deliberately avoids repeating that same story. It adds new findings from the next course modules:

1. the active VTAM configuration search path was discovered from the running VTAM started task JCL;
2. VTAM/TCP/IP interdependency was mapped through a real TRLE / OSA-QDIO resource;
3. policy-based security runtime components were checked in read-only mode;
4. Enterprise Extender was checked directly from VTAM;
5. all evidence was captured using display-only commands.

## New findings compared with Lab 01

| Area | Lab 01 already covered | Lab 02 adds |
|---|---|---|
| Runtime | TCPIP, VTAM, TN3270 active | Only used as continuity, not the main finding |
| TCP/IP operation | `NETSTAT` HOME, DEVLINKS, ROUTE, CONN, PORTL | Relationship to configuration/operation course module |
| VTAM configuration | Basic VTAM runtime commands | Actual `VTAMLST` DD concatenation from running VTAM JCL |
| Network attachment | LCS/ETH1 boundary | Separate OSA/QDIO TRLE exists but is inactive |
| VIPA / Sysplex | XCF and no VIPA | Not repeated here |
| Security | Not the main topic | `PAGENT`, `IKED`, `NSSD` checked and not active |
| Enterprise Extender | UDP port check only | Direct `/D NET,EE` result: XCA major node not active |

## Evidence included

All screenshots in `evidence/sanitized/` are from this second lab sequence and are different from the Lab 01 screenshots.

```text
01_vtam_started_task_vtamlst_concatenation.png
02_vtam_trle_osatrl1e_qdio_inactive.png
03_security_pagent_not_found.png
04_security_iked_not_found.png
05_security_nssd_not_found.png
06_enterprise_extender_xca_not_active.png
```

## Safety rule

This lab is read-only. It does not activate resources, change TCP/IP profiles, vary VTAM nodes, start policy agents, enable traces, create dumps, or modify the host network.

Explicitly avoided:

```text
VARY TCPIP,,OBEYFILE
VARY NET,...
MODIFY VTAM,...
TRACE activation
DUMP commands
RACF changes
TCP/IP profile changes
VTAMLST edits
host network adapter changes
```
