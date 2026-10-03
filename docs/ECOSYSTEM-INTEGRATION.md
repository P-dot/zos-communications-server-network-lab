# z/OS Communications Server — Ecosystem Integration

## Purpose

This document defines how `zos-communications-server-network-lab` integrates with the wider IBM z/OS Engineering Portfolio under **Architecture V2 / Engineering Control**.

The repository owns the **networking interpretation** of Communications Server behavior. It connects TCP/IP, VTAM, TN3270, network-facing USS services, RACF/SAF dependencies, Policy Agent, AT-TLS and observability without absorbing the responsibilities of the repositories that own security, USS, batch or application engineering.

The guiding rule is:

> **Integrate domains through evidence and explicit handoffs; do not duplicate another repository's implementation.**

---

## 1. Domain ownership

### Communications Server owns

- TCP/IP runtime and profile interpretation;
- VTAM/TN3270 networking context;
- listener and service-exposure analysis;
- FTP/HTTP/SSH network behavior;
- network attachment and reachability diagnosis;
- LCS/ETH1 investigation;
- network-facing started-task correlation;
- Policy Agent networking role;
- AT-TLS policy and transport behavior;
- transport-security activation and validation;
- network-side rollback;
- network observability requirements.

### Communications Server does not own

- general RACF administration;
- generic USS administration;
- JES2/spool engineering;
- scheduler implementation;
- application code;
- generic SMF subsystem engineering;
- enterprise PKI design;
- host/emulator networking as if it were native z/OS configuration.

When another domain is required, this repository records the dependency and links to the owning repository.

---

## 2. Evidence states

Cross-repository documentation uses explicit states.

| State | Definition |
|---|---|
| **VALIDATED LOCALLY** | Demonstrated by evidence in this repository |
| **VALIDATED IN TARGET REPOSITORY** | Demonstrated by the repository that owns the capability |
| **READINESS** | Prerequisites/configuration assessed; implementation not claimed |
| **PARTIAL / CONTROLLED STOP** | Progress demonstrated but final state deliberately not claimed |
| **BLOCKER DOCUMENTED** | Failure/dependency boundary isolated and preserved |
| **PLANNED** | Future integration without sufficient evidence |

The distinction matters particularly for transport security:

```text
certificate exists
       ≠
service can consume certificate
       ≠
TTLS policy accepted
       ≠
TLS handshake succeeds
       ≠
application traffic proven encrypted
```

---

## 3. Current evidence progression

### Foundation — Labs 02–13

The early sequence establishes:

- Communications Server configuration;
- TCP/IP/VTAM context;
- network security baseline;
- exposed services;
- authorization dependencies;
- certificate/key-ring inventory;
- logging/SMF readiness;
- USS service correlation;
- external reachability investigation;
- change-control and rollback discipline.

These labs create the baseline required before transport hardening.

### Runtime control — Labs 14–19

The second sequence moves from observation toward controlled operation:

- FTP hardening design;
- FTP runtime exposure control;
- HTTP runtime exposure control;
- SSH runtime exposure control;
- TN3270 hardening planning;
- network started-task identity baseline.

The important operational distinction is that TN3270 is an access dependency and therefore requires stronger rollback discipline.

### Connectivity and transport security — Labs 20–23

| Evidence | State | Meaning |
|---|---|---|
| Lab 20 — LCS/ETH1 | Completed diagnosis / partial connectivity | z/OS-side progress demonstrated; full external path not claimed |
| Lab 21 — PAGENT/AT-TLS readiness | Readiness complete | prerequisites assessed; system unchanged |
| Lab 22 — TTLS enablement | PASS milestone | TCP/IP reached TTLS policy-processing layer |
| Lab 23 Part 1 — HTTP readiness | PASS checkpoint | HTTP target and identity/security questions characterized |
| Lab 23 Part 2 — PAGENT troubleshooting | PARTIAL / CONTROLLED STOP | abnormal exit preserved; runtime returned/remained safe NOTTLS |

Empty working directories are not portfolio evidence and are excluded from the published capability state.

---

## 4. Core z/OS integration

Repository:

`P-dot/zos-adcd-hercules-engineering-lab`

Core z/OS owns the platform context on which networking runs:

```text
z/OS
  |
  +--> address spaces
  +--> PARMLIB / PROCLIB
  +--> console / system operation
  +--> storage and system services
  |
  +--> Communications Server
```

Communications Server consumes that platform and owns the networking-specific interpretation.

A networking failure should not automatically be treated as a TCP/IP configuration failure. The investigation must identify whether the boundary is:

```text
application
transport policy
TCP/IP
VTAM
device/link
emulator
host network
```

Lab 20 is the principal example of this layered diagnosis.

---

## 5. RACF / SAF integration

Repository:

`P-dot/mainframe-racf-security-evidence`

RACF owns:

- identity;
- effective authority;
- general-resource profiles;
- STARTED-class security interpretation;
- SERVAUTH authorization;
- FACILITY authority;
- certificate/key-ring lifecycle;
- least-privilege validation.

Communications Server owns the networking question:

> Which network component or service requires that identity or authorization?

The integration can therefore be represented as:

```text
network service / component
          ↓
execution identity
          ↓
SAF request / certificate requirement
          ↓
RACF policy
          ↓
effective authorization
          ↓
network runtime effect
```

A RACF profile existing does not by itself prove the network behavior. Likewise, a listening network service does not prove that its RACF security model is correct.

---

## 6. Cryptographic handoff from RACF

The current portfolio has a concrete security-to-network sequence.

RACF evidence establishes:

```text
Lab 31
authorization baseline
    ↓
Lab 32
controlled cryptographic delegation
    ↓
Lab 33
certificate / key-ring lifecycle
    ↓
LAB33CERT + LAB33RING retained
```

Communications Server consumes that handoff:

```text
Lab 23 Part 1
HTTPD1 target discovery
+ STARTED-class investigation
+ key-ring consumption question
        ↓
Lab 23 Part 2
retained ring/certificate reviewed
+ initial policy work
+ PAGENT controlled troubleshooting
        ↓
PARTIAL / CONTROLLED STOP
```

The following are **not yet promoted to validated capability**:

```text
stable PAGENT operation for target policy
validated HTTP TTLSRule
validated execution-context access to retained key ring
successful HTTP TLS handshake
encrypted end-to-end HTTP traffic
```

This is a genuine I2-style cross-repository integration path even though its final transport outcome remains incomplete: the handoff itself is explicit, evidenced and bounded.

---

## 7. USS integration

Repository:

`P-dot/UNIX_System_Services-`

Communications Server may depend on USS for:

- daemon execution;
- `/etc` configuration;
- Policy Agent configuration files;
- logging paths;
- file ownership and permissions;
- shell-side diagnostics.

USS owns generic POSIX administration.

Communications Server owns what those objects mean for a network service.

Example:

```text
/etc/pagent.conf
      |
      +--> USS: file/path/permission semantics
      |
      +--> Communications Server: Policy Agent configuration meaning
```

Similarly:

```text
sshd_config
      |
      +--> USS: file/process context
      |
      +--> Communications Server: exposed SSH service behavior
```

This separation prevents the network repository from becoming a second USS course.

---

## 8. Policy Agent / AT-TLS integration model

The target architecture is:

```text
application service
        |
        v
      TCP/IP
        |
        v
   AT-TLS policy
        |
        +--> Policy Agent
        |
        +--> traffic selectors
        |
        +--> System SSL
                 |
                 v
          RACF certificate/key ring
```

Each layer needs independent evidence.

### Lab 21

Readiness only.

### Lab 22

The TCP/IP stack reached the TTLS policy-processing layer and emitted:

```text
EZZ4249I TCPIP INSTALLED TTLS POLICY HAS NO RULES
```

That is a meaningful runtime milestone but not proof of encrypted service traffic.

### Lab 23 Part 1

HTTPD1 becomes the selected non-critical integration target. Its implementation, configuration and security-identity questions are characterized without activation.

### Lab 23 Part 2

Policy Agent reaches startup but exits abnormally:

```text
EZZ8431I PAGENT STARTING
EZZ8434I PAGENT EXITING ABNORMALLY
```

The exact cause is not asserted because the evidence does not establish it.

The safe close is:

```text
TCP/IP runtime     : NOTTLS
PAGENT             : stopped
HTTPD1             : preserved
AT-TLS policy      : experimental / inactive
certificate/ring   : retained
```

This is the current transport-security boundary.

---

## 9. HTTP integration boundary

HTTP is deliberately preferable to TN3270 for the first service-specific AT-TLS experiment because TN3270 is the primary interactive access path into the laboratory.

The intended sequence is:

```text
HTTP baseline
     ↓
effective identity resolution
     ↓
RACF key-ring access
     ↓
PAGENT stable initialization
     ↓
minimal TTLSRule
     ↓
controlled TTLS activation
     ↓
TLS handshake
     ↓
encrypted traffic evidence
```

Native HTTP SSL directives may exist in application configuration, but the current integration design is aimed at transparent AT-TLS below the application layer.

Therefore:

```text
SSL-capable application configuration
               ≠
AT-TLS implementation
```

---

## 10. TN3270 boundary

TN3270 is both a network service and an operational dependency.

It therefore requires:

- baseline listener evidence;
- client/access dependency awareness;
- rollback path before transport changes;
- alternative access considerations;
- careful separation of authentication behavior from transport protection.

The repository should not use TN3270 as the first uncontrolled TLS experiment.

Any future TN3270 transport-security lab must distinguish:

```text
authentication
authorization
TN3270 protocol behavior
transport encryption
client compatibility
```

These are separate evidence questions.

---

## 11. FTP / JES boundary

FTP-to-JES is a cross-domain trust boundary.

The networking side can own:

- FTP listener/service context;
- transport path;
- FTP configuration;
- network exposure;
- transport protection.

The security side can own:

- identity;
- authentication;
- authorization;
- RACF/SAF controls.

The JES side can own:

- submitted workload;
- JES execution/spool behavior;
- job lifecycle.

Target architecture:

```text
client
   ↓
FTP service
   ↓
authentication / RACF
   ↓
JES interface
   ↓
job submission
   ↓
JES2 execution / spool
```

A future/published FTP-JES track should link these domains instead of duplicating them.

At the current V2 documentation checkpoint, empty Lab 24 working directories are not counted as published local evidence.

---

## 12. SMF and observability

Communications Server consumes system observability to prove network behavior.

Potential evidence sources include:

- console messages;
- NETSTAT;
- TCP/IP job output;
- Policy Agent messages;
- SMF;
- syslog;
- packet capture where appropriate and safely sanitized.

General SMF engineering belongs to the core system domain.

The current environment has evidence of SMF readiness, but not a complete modern network-security telemetry pipeline.

Modern capabilities such as zERT must not be described as validated in the current z/OS V1R11 laboratory when they are unavailable there.

---

## 13. Workload automation integration

Repository:

`P-dot/zos-batch-scheduler`

The scheduler owns:

```text
when a workload runs
dependencies
conditions/resources
restart/rerun logic
```

Communications Server owns:

```text
whether the required network path/service exists
network runtime state
transport dependency
```

Future production-track integration may look like:

```text
scheduler
    ↓
JCL / JES2
    ↓
network-dependent batch workload
    ↓
Communications Server
    ↓
remote service
```

Network availability and scheduler dependency logic should be evidenced independently before being combined.

---

## 14. JCL / JES2 integration

JCL/JES repositories own batch execution mechanics.

Communications Server owns network transport.

For FTP/JES-style flows:

```text
network client
     ↓
FTP / Communications Server
     ↓
security boundary
     ↓
JES interface
     ↓
JCL / JES2
```

The network repository should not reproduce general JCL or spool-management labs.

---

## 15. Application-domain integration

COBOL, Db2 and CICS repositories own application semantics.

Communications Server may eventually provide transport for:

- online transactions;
- remote application access;
- Db2 connectivity;
- HTTP/API front ends;
- file transfer;
- application telemetry.

The evidence rule remains:

```text
application works locally
          ≠
network integration validated
```

and:

```text
network path exists
          ≠
application behavior validated
```

Both domains must contribute evidence for an integrated claim.

---

## 16. Change and rollback discipline

Network changes can remove the operator's own access path.

Every material change should therefore answer:

```text
What is the baseline?
What exact object changes?
What dependency can be lost?
How is rollback performed?
How is the runtime effect observed?
What proves recovery?
```

For critical access paths, the rollback plan is part of the implementation—not an optional note added afterwards.

Lab 22 demonstrates preservation of a pre-change profile state. Lab 23 Part 2 demonstrates the complementary principle: stop the experiment when the failure boundary is not sufficiently understood and preserve a safe runtime.

---

## 17. Publication-security boundary

Network evidence can reveal infrastructure even when no password is visible.

Public artifacts must be reviewed for:

- private/internal IP addresses;
- MAC addresses;
- adapter/interface identifiers tied to the host;
- credentials;
- secrets;
- private keys;
- certificate details that need not be public;
- terminal/session identifiers;
- host-specific routing and infrastructure data;
- unrelated personal information.

Sanitization must preserve the engineering story:

```text
raw evidence
     ↓
security review
     ↓
sanitized evidence
     ↓
public documentation
```

---

## 18. Architecture V2 lifecycle mapping

The portfolio lifecycle is:

```text
Discover → Baseline → Configure → Operate → Observe
→ Diagnose → Recover → Improve → Automate → Integrate
```

Communications Server maps naturally across it.

| Lifecycle stage | Repository evidence |
|---|---|
| Discover | service inventory, configuration discovery |
| Baseline | TCP/IP, VTAM, listeners, security posture |
| Configure | profile/policy preparation |
| Operate | runtime service-control drills |
| Observe | NETSTAT, console, task/process evidence |
| Diagnose | LCS/ETH1 and PAGENT troubleshooting |
| Recover | rollback preparation / safe-state restoration |
| Improve | hardening and transport-security design |
| Automate | future operational automation |
| Integrate | RACF, USS, JES2 and application handoffs |

---

## 19. Maturity interpretation

Architecture V2 maturity:

```text
M0 Exploratory
M1 Foundational
M2 Operational
M3 Resilient
M4 Automated
M5 Integrated
```

The repository contains evidence at different maturity levels rather than one blanket repository score.

Examples:

- baseline discovery is foundational;
- controlled service operations are operational;
- rollback-oriented changes move toward resilience;
- cross-repository RACF/HTTP/AT-TLS work demonstrates integration behavior;
- automation and complete encrypted-service validation remain areas for further maturity.

No single maturity label should conceal those differences.

---

## 20. Integration levels

Architecture V2 integration:

```text
I0 Standalone
I1 Cross-component
I2 Cross-repository
I3 Production-like
```

Examples:

- TCP/IP ↔ VTAM ↔ service runtime: cross-component;
- Communications Server ↔ USS: cross-repository;
- Communications Server ↔ RACF Labs 31–33 ↔ HTTP AT-TLS Lab 23: cross-repository;
- complete production-like encrypted service with operational telemetry and recovery: not yet claimed.

---

## 21. Production tracks

### Secure Network Service

```text
service
  ↓
network exposure
  ↓
identity / RACF
  ↓
transport policy
  ↓
runtime validation
  ↓
observability
```

Current evidence covers substantial portions but not the final service-specific encrypted path.

### Problem Determination

```text
symptom
  ↓
identify layer
  ↓
collect runtime evidence
  ↓
isolate boundary
  ↓
change only justified component
  ↓
validate or preserve blocker
```

Labs 20 and 23 Part 2 are strong examples.

### End-to-End Production Cycle

Communications Server provides the network layer that can connect security, batch and application domains in future integrated scenarios.

---

## 22. Current capability matrix

| Capability | Current state |
|---|---|
| TCP/IP configuration/runtime inspection | VALIDATED LOCALLY |
| VTAM/TN3270 network context | VALIDATED LOCALLY |
| Listener/service exposure analysis | VALIDATED LOCALLY |
| FTP runtime control | VALIDATED LOCALLY |
| HTTP runtime control | VALIDATED LOCALLY |
| SSH runtime control | VALIDATED LOCALLY |
| USS/network-service correlation | VALIDATED LOCALLY |
| Started-task network identity investigation | VALIDATED LOCALLY |
| LCS/ETH1 diagnosis | PARTIAL CONNECTIVITY / BLOCKER DOCUMENTED |
| RACF certificate/key-ring inventory | READINESS locally |
| RACF Lab 33 retained cryptographic artifacts | VALIDATED IN TARGET REPOSITORY |
| Policy Agent / AT-TLS prerequisite assessment | READINESS |
| TCP/IP TTLS policy-processing milestone | VALIDATED LOCALLY |
| HTTP AT-TLS target characterization | VALIDATED LOCALLY |
| PAGENT startup failure isolation | PARTIAL / CONTROLLED STOP |
| Stable target-service PAGENT operation | NOT YET VALIDATED |
| Service-specific TTLSRule | NOT YET VALIDATED |
| Target-service key-ring consumption | NOT YET VALIDATED |
| TLS handshake | NOT YET VALIDATED |
| End-to-end encrypted application traffic | NOT YET VALIDATED |
| zERT in current V1R11 environment | NOT AVAILABLE / NOT CLAIMED |

---

## 23. Learning journey vs runtime architecture

The learning order is intentionally simpler than the runtime dependency graph.

### Learning journey

```text
TSO/ISPF
   ↓
JCL/JES2
   ↓
workload automation
   ↓
USS
   ↓
RACF
   ↓
Communications Server
```

### Runtime architecture

```text
              RACF / SAF
             /          \
            v            v
         USS          TCP/IP
          |          /     \
          v         v       v
       daemons     VTAM   services
                     \      /
                      v    v
                      TN3270

       Policy Agent / AT-TLS
                 |
                 v
             System SSL
                 |
                 v
          RACF key rings
```

The portfolio should preserve both views. One teaches; the other explains the system.

---

## 24. Navigation and handoff rules

A reader should be able to move:

```text
Portfolio
   ↓
Domain README
   ↓
Lab
   ↓
Evidence
   ↓
Owning adjacent domain
   ↓
Integration track
   ↓
Portfolio
```

Cross-repository links should answer a specific question.

Examples:

- Need effective authorization? → RACF repository.
- Need POSIX ownership/permissions? → USS repository.
- Need JES job lifecycle? → JCL/JES/core domain.
- Need scheduler dependency logic? → workload automation repository.
- Need TCP/IP/AT-TLS behavior? → this repository.

---

## 25. Current integration frontier

The immediate engineering frontier is not “turn TLS on”.

It is:

```text
diagnose PAGENT initialization
        ↓
establish stable Policy Agent baseline
        ↓
validate minimum HTTP TTLSRule
        ↓
prove RACF key-ring consumption
        ↓
controlled TTLS activation
        ↓
validate TLS handshake
        ↓
validate encrypted HTTP traffic
        ↓
add operational observation / rollback evidence
```

Only then does the HTTP AT-TLS path become a completed encrypted-service capability.

---

## 26. Engineering rule

For every cross-domain network claim:

> **Identify the owning repository, identify the exact evidence state, link the handoff, preserve the rollback boundary, and never promote readiness or configuration presence into a runtime capability without proof.**

That rule keeps the portfolio technically credible as it grows.
