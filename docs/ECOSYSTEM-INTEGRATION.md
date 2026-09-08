# z/OS Communications Server — Ecosystem Integration

## Purpose

This document defines the role of `zos-communications-server-network-lab` inside the wider z/OS Engineering Laboratory.

The repository is the dedicated **networking, communications, network-security observation, runtime-control and transport-hardening track** for the ecosystem.

Its scope includes Communications Server configuration and runtime behavior, TCP/IP, VTAM, TN3270, exposed TCP services, UNIX-side service configuration, RACF-linked network security controls, certificate/keyring readiness, SMF/network logging readiness, external connectivity troubleshooting, started-task identity review, Policy Agent and AT-TLS readiness, and controlled enablement work.

This document intentionally distinguishes four different states:

```text
VALIDATED
INVESTIGATED
PARTIALLY IMPLEMENTED
PLANNED
```

A technology is not described as fully implemented merely because its configuration artifacts, samples or prerequisites exist.

---

# 1. Position in the wider z/OS laboratory

The repository sits between base z/OS infrastructure, RACF/SAF security, USS, network services and observability.

```text
                    z/OS Engineering Laboratory
                               |
                               v
                    Communications Server
                               |
          +--------------------+--------------------+
          |                    |                    |
          v                    v                    v
        TCP/IP                VTAM                TN3270
          |
          +-----------+--------+----------+
                      |                   |
                      v                   v
                TCP services          USS services
             FTP / HTTP / SSH       sshd / files
                      |
                      v
                   RACF / SAF
          identities / certificates / policy
                      |
                      v
                   SMF / audit
                      |
                      v
             network security evidence
```

The repository does not replace the RACF, USS or central z/OS engineering repositories. It consumes those domains where needed and owns the networking interpretation.

---

# 2. Repository responsibilities

The repository is responsible for documenting and validating:

- Communications Server runtime state;
- TCP/IP profile configuration;
- VTAM and TN3270 networking context;
- exposed TCP services;
- FTP, HTTP and SSH runtime exposure;
- z/OS UNIX-side network-service configuration;
- network-security authorization context;
- RACF certificate/keyring readiness for network encryption;
- network logging and SMF readiness;
- network started-task identity mapping;
- external connectivity diagnosis;
- emulator-to-z/OS network attachment investigation;
- change-control and rollback planning for network changes;
- Policy Agent discovery and readiness;
- AT-TLS prerequisite analysis;
- controlled AT-TLS enablement milestones.

The repository is not responsible for:

- general RACF administration;
- general USS administration;
- general SMF engineering;
- general JES2 engineering;
- production firewall administration;
- production PKI design;
- production network architecture;
- claiming enterprise high availability from an emulator lab.

---

# 3. Current lab progression

The current repository contains Labs 02 through 22.

## Phase A — Communications Server and network-security baseline

| Lab | Area | Role |
|---|---|---|
| Lab 02 | Configuration, Operation, Security and Enterprise Extender | Communications Server foundation |
| Lab 03 | Network Security Baseline | Initial network-security posture |
| Lab 04 | TCP/IP Profile Security Review | TCP/IP configuration inspection |
| Lab 05 | Network Security Authorization Review | Authorization-related review |
| Lab 06 | Network Security Policy Infrastructure Discovery | Policy infrastructure discovery |
| Lab 07 | TN3270 Service Security Exposure Review | Interactive-access exposure |
| Lab 08 | Exposed TCP Services Configuration Review | Service exposure inventory |
| Lab 09 | RACF Certificate and Keyring Inventory | TLS/AT-TLS certificate readiness |
| Lab 10 | Network Security Logging and SMF Readiness | Audit/logging readiness |
| Lab 11 | z/OS UNIX Network Service Configuration Review | USS-side service correlation |
| Lab 12 | External Reachability Validation Attempt | End-to-end reachability attempt |
| Lab 13 | Network Hardening Change Control and Rollback Baseline | Safe-change preparation |

This phase is primarily diagnostic and baseline-oriented.

---

## Phase B — controlled service exposure and hardening

| Lab | Area | Role |
|---|---|---|
| Lab 14 | FTP Exposure Hardening Draft | Hardening design |
| Lab 15 | FTP Runtime Exposure Control Drill | Runtime FTP control |
| Lab 16 | HTTP Runtime Exposure Control Drill | Runtime HTTP control |
| Lab 17 | SSH Runtime Exposure Control Drill | Runtime SSH control |
| Lab 18 | TN3270 Safe Hardening Planning | Critical-access-path hardening planning |
| Lab 19 | Network Started Task Identity Baseline | Service identity/security baseline |

The design principle for this phase is:

```text
observe service
   |
   v
understand dependency
   |
   v
prepare rollback
   |
   v
apply narrow runtime control
   |
   v
validate effect
   |
   v
restore safe state
```

TN3270 is treated more cautiously than non-critical services because it is the primary interactive access path into the lab system.

---

## Phase C — external connectivity and transport-security evolution

| Lab | Area | Status |
|---|---|---|
| Lab 20 | External Network Connectivity and LCS/ETH1 Investigation | Completed diagnosis / partial connectivity |
| Lab 21 | Policy Agent / AT-TLS Readiness Assessment | Completed read-only readiness assessment |
| Lab 22 | Controlled Policy Agent & AT-TLS Enablement Milestone | Controlled runtime milestone reached |

This is the most important current evolution of the repository.

---

# 4. Lab 20 — external connectivity boundary

Lab 20 established a useful diagnostic separation between the internal z/OS networking stack and the emulator/host attachment layer.

Validated items include:

```text
TCP/IP profile processing
DEVICE LCS1 / LINK ETH1 initialization
LCS1 READY
Hercules LCS device availability
Hercules TAP backend initialization
internal TN3270 listener availability
```

External host-to-z/OS reachability was **not fully established**.

The resulting architecture is therefore:

```text
z/OS TCP/IP stack
      |
      | internally functional
      v
LCS1 / ETH1
      |
      | emulator / host integration gap
      v
external host network
```

This result must not be described as full external connectivity.

The lab's value is diagnostic: it isolates the remaining problem to the emulator/host networking integration layer rather than incorrectly attributing it to TN3270 or the basic TCP/IP started task.

---

# 5. Lab 21 — Policy Agent / AT-TLS readiness

Lab 21 is explicitly a **read-only readiness assessment**.

Validated findings include:

- Policy Agent executable present at `/usr/lpp/tcpip/sbin/pagent`;
- IBM Policy Agent and RACF sample material located;
- RACF `BPX.DAEMON` profile present;
- no `PAGENT` RACF user observed;
- no `STARTED PAGENT.*` mapping observed;
- no matching `SERVAUTH EZB.PAGENT.*` profile observed;
- PAGENT not active;
- no system changes performed.

The correct interpretation is:

```text
Policy Agent software exists
        |
        v
supporting sample material exists
        |
        v
security/runtime prerequisites incomplete
        |
        v
implementation deferred
```

This lab did **not** implement Policy Agent or AT-TLS.

---

# 6. Lab 22 — controlled AT-TLS enablement milestone

Lab 22 advances the environment beyond readiness assessment, but intentionally stops before complete service encryption.

The validated milestone includes:

- Policy Agent executable startup evidence;
- dedicated environment data set preparation;
- a PAGENT started-task procedure adapted to use `STDENV`;
- `/etc/pagent.conf` created;
- the active TCP/IP profile identified;
- a rollback copy preserved;
- persistent `TCPCONFIG ... TTLS` enablement added;
- minimal dynamic OBEY input prepared;
- TCP/IP processed the TTLS enablement without stack restart;
- runtime message:

```text
EZZ4249I TCPIP INSTALLED TTLS POLICY HAS NO RULES
```

The milestone therefore proves:

```text
TCP/IP
  |
  +--> TTLS processing enabled
  |
  +--> policy layer reached
  |
  +--> no service-specific TTLS rules installed
```

It does **not** prove:

```text
certificate/keyring provisioning complete
service-specific TTLSRule installed
Policy Agent stable with final rule set
TLS handshake validated
encrypted application traffic validated end to end
```

The repository must preserve this distinction.

---

# 7. AT-TLS architecture at the current checkpoint

The current intended chain is:

```text
TCP/IP profile
     |
     | TCPCONFIG TTLS
     v
TCP/IP stack
     |
     v
AT-TLS policy layer
     ^
     |
Policy Agent
     ^
     |
PAGENT environment / STDENV
     ^
     |
/etc/pagent.conf
     |
     v
TTLS policy file
     |
     v
service-specific TTLS rules   <-- not yet completed
     |
     v
RACF certificate / keyring    <-- not yet completed for target service
     |
     v
encrypted service validation  <-- future phase
```

This is currently a **transport-security enablement path**, not yet a completed encrypted-service implementation.

---

# 8. RACF integration boundary

Communications Server depends heavily on RACF/SAF, but this repository does not replace the RACF security repository.

The relationship is:

```text
Communications Server
       |
       +--> started-task identity
       |
       +--> RACF certificates / keyrings
       |
       +--> SAF authorization
       |
       +--> SERVAUTH
       |
       +--> BPX.DAEMON / UNIX identity context
       |
       v
mainframe-racf-security-evidence
```

The Communications Server repository owns the question:

> What network capability requires this identity, profile, certificate or SAF control?

The RACF repository owns the question:

> How is that identity or resource protected and what effective authority exists?

---

# 9. Certificate and keyring readiness

Lab 09 established a read-only RACF certificate/keyring inventory relevant to networking.

Observed results included:

- RACF CERTAUTH material exists;
- no personal certificate/keyring material was observed for several reviewed network service IDs;
- one reviewed web-service identity was not defined to RACF;
- no certificate modifications were performed.

The important distinction is:

```text
CA trust material exists
        !=
service TLS identity provisioned
```

Therefore the repository can legitimately describe certificate **readiness assessment**, but not completed service TLS provisioning at that checkpoint.

---

# 10. SMF and network logging integration

Lab 10 established a network-security logging readiness baseline.

Validated observations include:

- SMF address space active;
- active SMF parameter member identified;
- SMF recording configuration reviewed;
- SYSLOGD not observed active;
- TRMD not observed active;
- no active IDS/syslog/TRMD reporting chain demonstrated;
- zERT documented as unavailable for this older z/OS V1R11 environment.

The architecture is therefore:

```text
Communications Server events
        |
        v
SMF capability
        |
        +--> baseline present
        |
        +--> network-security event pipeline not fully demonstrated
```

zERT must not be presented as implemented in this environment.

For this repository, zERT belongs in the category:

```text
modern reference capability
not available in current V1R11 lab
```

---

# 11. USS integration boundary

Lab 11 correlates Communications Server exposure with z/OS UNIX configuration.

Observed evidence includes:

- `/etc/ssh/sshd_config`;
- SSH protocol 2 configuration;
- `PermitRootLogin no`;
- password and public-key authentication configuration;
- SSH host-key references;
- SFTP subsystem configuration;
- SSH, HTTP and FTP process evidence;
- no active SYSLOG daemon observed in the captured evidence.

The cross-repository boundary is:

```text
Communications Server
       |
       v
network-facing service
       |
       v
USS process / configuration file
       |
       v
UNIX identity / permissions
       |
       v
RACF / SAF
```

The USS repository owns generic OMVS/filesystem/process administration.

This repository owns how those UNIX artifacts support or expose z/OS network services.

---

# 12. TN3270 as a protected operational dependency

TN3270 is not simply another network listener in this lab.

It is a critical operational dependency because it provides the interactive 3270 access path used to administer and validate much of the environment.

Therefore:

```text
FTP / HTTP / SSH
   |
   +--> suitable for controlled runtime exposure drills

TN3270
   |
   +--> requires stronger rollback planning
   +--> should not be the first AT-TLS test target
```

This explains why Lab 18 is framed as safe hardening planning rather than aggressive runtime experimentation.

---

# 13. Started-task identity

Lab 19 introduces the service-identity layer into the network architecture.

Relevant architecture:

```text
TCPIP / FTPD / HTTPD / SSHD / PAGENT
              |
              v
        started task / process
              |
              v
          security identity
              |
              v
            RACF
              |
              v
        effective authority
```

Future cross-repository validation should correlate network runtime identity with RACF least-privilege controls.

---

# 14. External connectivity and emulator boundary

The repository must explicitly separate these layers:

```text
application service
      |
TCP/IP listener
      |
TCP/IP stack
      |
VTAM / device / link definition
      |
LCS / emulated adapter
      |
Hercules backend
      |
host operating system
      |
external network
```

A failure at the bottom of this chain must not automatically be interpreted as failure of the z/OS service itself.

Lab 20 is the canonical example of this diagnostic discipline.

---

# 15. Integration with the central z/OS engineering repository

The central repository owns system-level infrastructure such as:

- startup and system services;
- storage;
- JES2;
- SMF;
- diagnostics;
- backup and recovery;
- WLM/SRM;
- system evolution.

Communications Server consumes those capabilities.

Relevant relationship:

```text
central z/OS engineering
          |
          v
 system services / SMF / storage
          |
          v
 Communications Server
          |
          v
 network-facing workloads
```

The Communications Server repo should link back to the central architecture instead of duplicating system-engineering documentation.

---

# 16. Integration with RACF

Primary chain:

```text
RACF / SAF
    |
    v
network service identity
    |
    v
SERVAUTH / certificate / keyring / UNIX authorization
    |
    v
Communications Server
    |
    v
network service
```

Potential future integration branch:

```text
integration/racf-network-smf
```

This should validate a narrow security control and its observable network/audit effect.

---

# 17. Integration with USS

Primary chain:

```text
USS
 |
 +--> /etc configuration
 |
 +--> network daemon
 |
 +--> permissions / ownership
 |
 +--> RACF-backed identity
 |
 v
Communications Server exposure
```

Potential future integration branch:

```text
integration/uss-racf-tcpip
```

---

# 18. Integration with SMF

Primary chain:

```text
network activity
      |
      v
Communications Server
      |
      v
SMF / logging capability
      |
      v
security evidence
```

The current repository validates readiness context, not a complete modern network telemetry pipeline.

---

# 19. Integration with scheduler and batch workloads

Network connectivity may eventually support batch-oriented transfers or remote service dependencies.

The architecture should remain:

```text
Scheduler
   |
   v
JCL / JES2 workload
   |
   v
network dependency
   |
   v
Communications Server
```

The scheduler decides when workload runs.

JCL describes the workload.

JES2 executes it.

Communications Server provides the network path.

These roles must remain separate.

---

# 20. Integration with application repositories

Future application chains may include:

```text
CICS / COBOL / Db2
        |
        v
network-facing transaction or service dependency
        |
        v
Communications Server
```

No such full production-style cross-repository chain should be described as validated until implemented with evidence.

---

# 21. Validated capability matrix

| Capability | Current state |
|---|---|
| TCP/IP runtime/configuration inspection | Validated |
| VTAM/TN3270 runtime context | Validated |
| TCP service exposure inventory | Validated |
| FTP runtime exposure control | Lab track present |
| HTTP runtime exposure control | Lab track present |
| SSH runtime exposure control | Lab track present |
| TN3270 hardening planning | Validated as planning track |
| RACF certificate/keyring inventory | Validated read-only |
| SMF/network logging readiness | Validated baseline |
| USS-side service review | Validated read-only |
| External host-to-z/OS reachability | Partial / not fully established |
| LCS/ETH1 diagnosis | Validated diagnostic milestone |
| Policy Agent executable/readiness | Validated |
| Policy Agent production-style operation | Not yet demonstrated |
| TTLS enablement in TCP/IP stack | Validated milestone |
| Service-specific TTLSRule | Not yet implemented at Lab 22 close |
| RACF certificate/keyring for target AT-TLS service | Not yet implemented at Lab 22 close |
| End-to-end encrypted service traffic | Not yet validated |
| zERT | Not available in current z/OS V1R11 environment |

---

# 22. Engineering methodology

The repository follows the ecosystem-wide methodology:

```text
Build
  ->
Execute
  ->
Observe
  ->
Diagnose
  ->
Correct
  ->
Validate
  ->
Document
```

For network security changes, extend it to:

```text
Baseline
  ->
Identify exposure
  ->
Understand dependencies
  ->
Prepare rollback
  ->
Apply minimal change
  ->
Observe runtime effect
  ->
Validate
  ->
Rollback if required
  ->
Document
```

---

# 23. Evidence discipline

A networking lab should preserve enough evidence to answer:

```text
What was configured?
What was active?
What was listening?
What changed?
What message proved the change?
What remained unimplemented?
What was the rollback path?
```

Valid evidence can include:

- sanitized screenshots;
- console messages;
- NETSTAT results;
- TCP/IP profile excerpts;
- started-task context;
- USS configuration excerpts;
- RACF display output;
- SMF readiness evidence;
- Hercules-side diagnostic output after redaction;
- before/after configuration states;
- rollback copies;
- troubleshooting history.

Failed commands may be retained when they explain how the accepted syntax or platform limitation was discovered.

---

# 24. Publication-security discipline

Networking evidence is especially sensitive.

Do not publish unnecessary:

- real IP addresses;
- MAC addresses;
- gateways;
- network prefixes;
- host adapter names or identifiers;
- TAP/tunnel host details;
- hostnames;
- Windows usernames;
- local filesystem paths;
- terminal/session identifiers;
- certificate serial numbers;
- distinguished names;
- private key material;
- credentials;
- tokens or secrets.

Use placeholders where necessary, for example:

```text
<ZOS_IP>
<HOST_IP>
<HOST_LCS_IP>
<HOSTNAME>
<WINDOWS_USER>
<LOCAL_PATH>
```

The repository's existing redaction policy remains authoritative for publication.

---

# 25. Repository hygiene

The ecosystem-integration branch should contain only documentation related to ecosystem architecture.

Unrelated local artifacts must not be included accidentally.

At the time of this normalization work, locally untracked ZIP files existed under the Lab 15 and Lab 16 directories. They are outside the scope of this documentation change and should be handled separately.

An empty or anomalous local `labs/labs` directory was also observed. It should not be mixed into this documentation branch.

---

# 26. Branch strategy

Use short-lived branches.

Recommended patterns:

```text
docs/communications-ecosystem-integration-v1
docs/communications-root-readme-v2
integration/racf-network-smf
integration/uss-racf-tcpip
integration/network-attls-test-service
fix/<network-specific-slug>
lab/<number>-<slug>
```

Lifecycle:

```text
branch
  ->
work
  ->
validation
  ->
publication-security review
  ->
PR
  ->
main
  ->
delete branch
```

---

# 27. Next transport-security milestone

The logical next AT-TLS engineering phase is:

```text
choose non-critical test service
        |
        v
prepare RACF certificate/keyring
        |
        v
define service-specific TTLSRule
        |
        v
start Policy Agent under controlled conditions
        |
        v
confirm policy installation
        |
        v
validate TLS handshake
        |
        v
validate encrypted application traffic
        |
        v
collect evidence
        |
        v
rollback / persistence validation
```

TN3270 should not be the first target because it is the critical interactive access path for the lab.

---

# 28. Long-term target architecture

The mature network-security path should eventually look like:

```text
RACF identity / keyring
          |
          v
Policy Agent
          |
          v
AT-TLS policy
          |
          v
TCP/IP stack
          |
          v
selected network service
          |
          v
encrypted connection
          |
          v
SMF / logging evidence
          |
          v
security validation
```

This target remains partly planned.

The current repository has reached the point where the TCP/IP stack can process TTLS policy state, but the end-to-end encrypted-service chain remains the next major milestone.

---

# 29. Master architecture

This repository is part of the broader z/OS Engineering Laboratory.

Master repository:

https://github.com/P-dot/zos-adcd-hercules-engineering-lab

The central architecture should treat this repository as the owner of:

```text
Communications Server
TCP/IP
VTAM
TN3270
network-facing services
network exposure diagnostics
transport-security readiness
controlled AT-TLS evolution
```

while RACF, USS, SMF and other repositories retain ownership of their own domains.

---

# 30. Repository role summary

`zos-communications-server-network-lab` is the **network communications and transport-security engineering component** of the wider z/OS lab ecosystem.

Its current progression is:

```text
network discovery
      ->
security baseline
      ->
service exposure review
      ->
RACF / certificate readiness
      ->
SMF / logging readiness
      ->
USS service correlation
      ->
runtime exposure control
      ->
started-task identity
      ->
external connectivity diagnosis
      ->
Policy Agent readiness
      ->
controlled TTLS enablement
      ->
future service-specific encrypted validation
```

The repository should therefore be presented not as a single LCS/ETH1 troubleshooting exercise, but as an evolving Communications Server engineering track with explicit boundaries between what has been observed, what has been controlled, what has been partially enabled, and what remains to be implemented.
