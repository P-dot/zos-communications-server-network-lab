# z/OS Communications Server Network Engineering Lab

Hands-on IBM z/OS Communications Server engineering focused on **TCP/IP, VTAM, TN3270, network-facing services, transport security, runtime diagnosis, controlled change and cross-domain security integration**.

This repository is the **networking and transport-security domain** of the wider IBM z/OS Engineering Portfolio. It records reproducible laboratory evidence from a controlled ADCD / Hercules environment and deliberately separates validated behavior from readiness findings, partial implementation and planned work.

> **Scope:** educational and engineering laboratory. Evidence from this environment is not presented as production network architecture, enterprise PKI, high availability, or completed encrypted-service deployment unless a lab explicitly demonstrates it.

## Quick navigation

| Destination | Purpose |
|---|---|
| [Portfolio](https://github.com/P-dot/P-dot) | Main z/OS engineering portfolio |
| [Ecosystem integration](docs/ECOSYSTEM-INTEGRATION.md) | Domain ownership and cross-repository boundaries |
| [Architecture V2](https://github.com/P-dot/zos-adcd-hercules-engineering-lab/tree/main/docs/architecture/v2) | Portfolio architecture and lifecycle |
| [Engineering Control](https://github.com/P-dot/zos-adcd-hercules-engineering-lab/tree/main/docs/engineering-control) | Baseline, change, recovery and maturity controls |
| [RACF / SAF Security](https://github.com/P-dot/mainframe-racf-security-evidence) | Identity, authorization, certificates and key rings |
| [USS](https://github.com/P-dot/UNIX_System_Services-) | OMVS / POSIX runtime engineering |
| [Core z/OS](https://github.com/P-dot/zos-adcd-hercules-engineering-lab) | System-level engineering |
| [Workload Automation](https://github.com/P-dot/zos-batch-scheduler) | Batch dependency and scheduling domain |

---

## Repository role

This repository answers the networking-side questions:

> **What service is exposed, how does traffic reach it, which Communications Server component controls it, what security dependency protects it, what changed at runtime, and what evidence proves the result?**

It owns:

- Communications Server runtime and configuration interpretation;
- TCP/IP profile analysis;
- VTAM and TN3270 network context;
- listener and service-exposure analysis;
- FTP, HTTP and SSH network behavior;
- network-facing USS service correlation;
- LCS / ETH1 connectivity investigation;
- network started-task identity correlation;
- Policy Agent and AT-TLS engineering;
- transport-security readiness and controlled activation;
- network-side rollback and validation;
- network observability dependencies.

It does **not** duplicate:

- general RACF administration and effective-authority engineering;
- generic USS administration;
- JES2/spool engineering;
- general SMF engineering;
- scheduler implementation;
- application-development repositories.

Those capabilities are linked through explicit cross-repository handoffs.

---

## Engineering method

The repository follows the portfolio evidence lifecycle:

```text
BUILD → EXECUTE → OBSERVE → DIAGNOSE → CORRECT → VALIDATE → DOCUMENT
```

For network changes, the operational form is:

```text
Discover
   ↓
Baseline
   ↓
Observe runtime state
   ↓
Correlate configuration
   ↓
Identify exposure / dependency
   ↓
Prepare rollback
   ↓
Apply minimum justified change
   ↓
Validate runtime effect
   ↓
Restore or preserve safe state
   ↓
Document evidence and remaining gaps
```

A failed or partial implementation can be valid engineering evidence when the failure boundary is demonstrated and the system is left in a known safe state.

---

## Evidence-state vocabulary

| State | Meaning |
|---|---|
| **VALIDATED LOCALLY** | Demonstrated by evidence in this repository |
| **VALIDATED IN TARGET REPOSITORY** | Demonstrated by another portfolio domain and consumed here as a dependency |
| **PARTIAL / CONTROLLED STOP** | Useful engineering progress was validated, but the intended end state was deliberately not claimed |
| **READINESS** | Prerequisites or architecture were assessed without claiming implementation |
| **BLOCKER DOCUMENTED** | A boundary or dependency was isolated and preserved as evidence |
| **PLANNED** | Intended future work without sufficient evidence yet |

This vocabulary prevents configuration presence from being confused with working runtime behavior.

---

# Lab index

## 1. Communications Server and security baseline

| Lab | Focus | Evidence state |
|---|---|---|
| [02](labs/02-config-operation-security/) | Configuration, operation, security and Enterprise Extender | Validated locally |
| [03](labs/03-network-security-baseline/) | Network security baseline | Validated locally |
| [04](labs/04-tcpip-profile-security-review/) | TCP/IP profile security review | Validated locally |
| [05](labs/05-network-security-authorization-review/) | Network authorization review | Validated locally |
| [06](labs/06-network-security-policy-infrastructure-discovery/) | Policy infrastructure discovery | Readiness / discovery |
| [07](labs/07-tn3270-service-security-exposure-review/) | TN3270 exposure review | Validated locally |
| [08](labs/08-exposed-tcp-services-configuration-review/) | Exposed TCP services | Validated locally |
| [09](labs/09-racf-certificate-keyring-inventory/) | RACF certificate / key-ring inventory | Readiness |
| [10](labs/10-network-security-logging-smf-readiness-review/) | Logging and SMF readiness | Readiness |
| [11](labs/11-zos-unix-network-service-configuration-review/) | USS network-service correlation | Validated locally |
| [12](labs/12-external-reachability-validation-attempt/) | External reachability attempt | Investigation |
| [13](labs/13-network-hardening-change-control-rollback-baseline/) | Change control and rollback baseline | Validated locally |

## 2. Runtime service control

| Lab | Focus | Evidence state |
|---|---|---|
| [14](labs/14-ftp-exposure-hardening-draft/) | FTP hardening design | Readiness / design |
| [15](labs/15-ftp-runtime-exposure-control-drill/) | FTP runtime exposure control | Validated locally |
| [16](labs/16-http-runtime-exposure-control-drill/) | HTTP runtime exposure control | Validated locally |
| [17](labs/17-ssh-runtime-exposure-control-drill/) | SSH runtime exposure control | Validated locally |
| [18](labs/18-tn3270-safe-hardening-planning/) | TN3270 safe-hardening planning | Readiness / design |
| [19](labs/19-network-started-task-identity-baseline/) | Network started-task identity | Validated locally |

## 3. Connectivity and transport security

| Lab | Focus | Evidence state |
|---|---|---|
| [20](labs/20-external-network-connectivity-lcs-eth1-investigation/) | LCS / ETH1 external connectivity | **Completed diagnosis / partial connectivity** |
| [21](labs/21-policy-agent-attls-readiness-assessment/) | Policy Agent / AT-TLS readiness | **Readiness complete; system unchanged** |
| [22](labs/22-controlled-policy-agent-attls-implementation/) | Controlled TTLS enablement | **PASS — enablement milestone** |
| [23 · Part 1](labs/23-http-attls-integration-readiness-part-1/) | HTTP AT-TLS readiness and identity resolution | **PASS — readiness checkpoint** |
| [23 · Part 2](labs/23-http-attls-integration-readiness-part-2/) | Policy Agent / AT-TLS troubleshooting | **PARTIAL / CONTROLLED STOP** |

> Empty Lab 24 working directories are intentionally excluded from the published lab index. A directory is not treated as portfolio evidence until it contains documented, reviewable work.

---

# Selected engineering milestones

## Lab 20 — separate stack health from external reachability

Lab 20 establishes a critical diagnostic distinction:

```text
TCP/IP active
+ service listening
+ LCS initialized
        ≠
external path proven
```

The work validates Communications Server and LCS-side progress while preserving the unresolved emulator/host attachment boundary instead of incorrectly describing the complete external path as working.

This is an example of **BLOCKER DOCUMENTED** engineering: isolate the layer that works, isolate the layer that does not, and avoid changing unrelated components.

---

## Lab 21 — AT-TLS readiness without pretending implementation

The Policy Agent executable and relevant prerequisites were inspected, while missing runtime/security dependencies were identified.

The system was intentionally left unchanged.

```text
software present
      ↓
prerequisites inspected
      ↓
gaps identified
      ↓
implementation deferred
```

That is readiness evidence, not encrypted-transport evidence.

---

## Lab 22 — reach the TTLS policy-processing layer

Lab 22 advances beyond readiness and performs a controlled stack-level enablement milestone.

Evidence includes:

```text
TCPCONFIG TTLS
        ↓
TCP/IP accepts TTLS enablement
        ↓
EZZ4249I TCPIP INSTALLED TTLS POLICY HAS NO RULES
```

This proves that the stack reached AT-TLS policy processing.

It does **not** prove:

```text
validated service-specific TTLSRule
+ correct target-service certificate/key ring
+ stable final Policy Agent operation
+ successful TLS handshake
+ encrypted end-to-end application traffic
```

The narrower claim is the correct one.

---

## Lab 23 Part 1 — connect RACF cryptographic evidence to HTTP transport design

Lab 23 Part 1 begins the first explicit cross-repository cryptographic handoff.

The RACF security repository retained:

```text
H7USER
  └── LAB33RING
        └── LAB33CERT
```

The Communications Server side then characterizes `HTTPD1`, its configuration, STARTED-class behavior and the unresolved effective-identity/key-ring consumption path.

No AT-TLS activation, HTTPD1 change, certificate/key-ring modification or TCP/IP profile change is claimed.

Result:

**PASS — HTTP AT-TLS readiness checkpoint completed.**

---

## Lab 23 Part 2 — controlled stop is part of the evidence

Part 2 continues the HTTP AT-TLS integration but encounters a Policy Agent initialization failure:

```text
EZZ8431I PAGENT STARTING
        ↓
EZZ8434I PAGENT EXITING ABNORMALLY
```

The evidence does not establish the exact internal cause.

Therefore the lab does not guess.

At close:

```text
TCP/IP runtime     : NOTTLS
PAGENT             : stopped / abnormal exit
HTTPD1             : existing service preserved
certificate/ring   : retained RACF artifacts
AT-TLS policy      : experimental / not active
```

Result:

**PARTIAL / CONTROLLED STOP**

The next engineering action is diagnosis of Policy Agent initialization and controlled policy isolation—not blind reactivation of `TCPCONFIG TTLS`.

---

# Cross-repository architecture

```text
                         PORTFOLIO
                             |
        +--------------------+--------------------+
        |                    |                    |
        v                    v                    v
     Core z/OS             RACF / SAF             USS
        |                    |                    |
        +----------+---------+----------+---------+
                   |                    |
                   v                    v
             Communications Server / TCP/IP
                   |
          +--------+---------+
          |        |         |
          v        v         v
        VTAM     TN3270   TCP services
                           FTP / HTTP / SSH
                                  |
                                  v
                          Policy Agent / AT-TLS
                                  |
                                  v
                         transport validation
```

The domain boundary is intentional.

### RACF / SAF owns

```text
identity
effective authorization
STARTED-class security interpretation
SERVAUTH
FACILITY authority
certificate / key-ring lifecycle
least privilege
```

### Communications Server owns

```text
network service
TCP/IP runtime
network configuration
Policy Agent
TTLS policy
transport behavior
handshake / encrypted-path validation
network-side diagnosis
```

### USS owns

```text
OMVS environment
POSIX files and permissions
generic process/runtime administration
```

Communications Server consumes USS evidence when a network daemon or Policy Agent depends on it.

---

# RACF → Communications Server cryptographic handoff

The portfolio now has a concrete cross-domain sequence:

```text
RACF Lab 31
authorization baseline
      ↓
RACF Lab 32
controlled cryptographic delegation
      ↓
RACF Lab 33
certificate + key-ring lifecycle
      ↓
LAB33CERT / LAB33RING retained
      ↓
Communications Lab 23.1
HTTP target + identity/readiness analysis
      ↓
Communications Lab 23.2
Policy Agent troubleshooting
      ↓
NEXT
diagnose PAGENT
      ↓
validated TTLSRule
      ↓
validated certificate/key-ring consumption
      ↓
TLS handshake
      ↓
encrypted traffic evidence
```

The lower portion remains future work until evidence proves it.

---

# TN3270 and access-path safety

TN3270 is not treated like an ordinary experimental service.

It is a critical interactive access path into the laboratory.

```text
FTP / HTTP / SSH
      ↓
controlled service drills possible

TN3270
      ↓
access dependency
      ↓
stronger rollback requirement
      ↓
transport changes require additional caution
```

This is why planning and evidence precede aggressive modification.

---

# Network observability

The repository records what can actually be demonstrated in the current environment.

SMF is available as an important system evidence source, but a complete modern network-security telemetry chain has not been demonstrated.

In particular, modern capabilities must not be retroactively claimed for the older z/OS V1R11 laboratory merely because current IBM platforms support them.

The repository therefore distinguishes:

```text
historical/current-platform reference
              ≠
validated capability in this environment
```

---

# Publication security

Public network evidence requires stricter sanitization than ordinary application output.

Before publication, remove or obscure as appropriate:

- credentials and authentication material;
- private keys and secrets;
- private/internal IP addresses;
- MAC addresses;
- host adapter names and identifiers;
- terminal/session identifiers;
- certificate serials when unnecessary;
- infrastructure details that expose the host environment;
- unrelated personal or system-sensitive information.

Evidence should remain technically useful after sanitization.

---

# Architecture V2 alignment

This repository participates in the portfolio lifecycle:

```text
Discover
  ↓
Baseline
  ↓
Configure
  ↓
Operate
  ↓
Observe
  ↓
Diagnose
  ↓
Recover
  ↓
Improve
  ↓
Automate
  ↓
Integrate
```

Current strengths are concentrated in:

```text
Discover
Baseline
Operate
Observe
Diagnose
Recover / rollback planning
Cross-domain integration
```

Transport-security work is moving from readiness toward controlled integration, but the repository does not claim the final encrypted-service state prematurely.

---

# Production-track relevance

The evidence supports several portfolio production tracks.

| Production track | Contribution |
|---|---|
| Secure Network Service | TCP/IP, service exposure, identity, transport-security path |
| Problem Determination | Layer-by-layer connectivity and Policy Agent diagnosis |
| Operations Automation | Network dependencies exposed to future automation |
| End-to-End Production Cycle | RACF → network identity → service → transport evidence |
| Secure Batch Application | FTP/JES and network trust boundaries when validated in published labs |

Cross-domain tracks should link to the repository that owns each part rather than duplicating implementation.

---

# Current capability state

## Validated / demonstrated

- Communications Server configuration and runtime inspection;
- TCP/IP profile review;
- VTAM/TN3270 context;
- exposed-service analysis;
- FTP/HTTP/SSH runtime control drills;
- USS/network-service correlation;
- network started-task identity investigation;
- LCS/ETH1 diagnosis with partial-connectivity boundary;
- Policy Agent / AT-TLS readiness analysis;
- TTLS stack-level enablement milestone;
- HTTP AT-TLS readiness and identity-resolution checkpoint;
- bounded Policy Agent failure analysis with safe NOTTLS close;
- rollback-oriented network change discipline.

## Not yet claimed as complete

- stable target-service Policy Agent operation;
- validated service-specific `TTLSRule`;
- validated target-service consumption of the retained RACF key ring;
- successful target-service TLS handshake;
- encrypted end-to-end application traffic;
- production PKI;
- production high availability;
- modern zERT evidence in this V1R11 environment.

---

# Next engineering milestone

The immediate continuation from Lab 23 Part 2 is diagnostic, not activation-first:

```text
PAGENT diagnostic initialization
        ↓
logging / syslog path verification
        ↓
policy isolation
        ↓
identify abnormal-exit boundary
        ↓
stable Policy Agent baseline
        ↓
minimum validated HTTP TTLSRule
        ↓
RACF key-ring consumption
        ↓
controlled TTLS activation
        ↓
TLS handshake validation
        ↓
encrypted traffic evidence
```

Only after those stages are demonstrated should the repository claim a completed service-specific AT-TLS implementation.

---

## Portfolio position

```text
IBM z/OS Engineering Portfolio
        |
        +--> Systems & Operations
        +--> Workload Automation
        +--> Security & Compliance
        +--> Application Development
        +--> Diagnostics & Recovery
        +--> Data & Storage
        |
        +--> Network & USS
                 |
                 +--> Communications Server
                 |      TCP/IP
                 |      VTAM / TN3270
                 |      service exposure
                 |      Policy Agent
                 |      AT-TLS
                 |
                 +--> USS
```

**Repository role:** provide the networking-side evidence needed to understand, operate, diagnose and progressively secure z/OS communications without confusing configuration, readiness, partial implementation and validated runtime behavior.
