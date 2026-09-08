# z/OS Communications Server Network Lab

Hands-on IBM z/OS Communications Server engineering laboratory focused on TCP/IP, VTAM, TN3270, network-facing services, security controls, runtime diagnosis, transport-security readiness, and controlled hardening.

This repository documents work performed in a controlled z/OS ADCD / Hercules environment. It has evolved from basic network-evidence collection into a broader Communications Server engineering track covering service exposure, RACF-linked network security, SMF readiness, z/OS UNIX service configuration, external connectivity troubleshooting, started-task identity analysis, Policy Agent readiness, and controlled AT-TLS enablement.

> **Scope:** educational and engineering laboratory. This repository does not claim production network architecture, production PKI, enterprise high availability, or production-grade encrypted service deployment unless explicitly demonstrated by a lab.

---

## Repository mission

The goal is not simply to prove that TCP/IP is started.

The repository follows a repeatable engineering process:

```text
Discover
  |
  v
Baseline
  |
  v
Observe runtime state
  |
  v
Correlate configuration
  |
  v
Identify exposure or dependency
  |
  v
Design narrow change
  |
  v
Prepare rollback
  |
  v
Validate runtime effect
  |
  v
Document evidence
```

The central questions are:

> **What network service is active, how is it configured, what security boundary protects it, what depends on it, and how can a change be validated safely?**

---

# Current status

The repository currently contains Labs **02 through 22**.

The track now covers:

- Communications Server configuration and operation
- TCP/IP profile review
- VTAM and TN3270 runtime context
- exposed TCP service inventory
- FTP, HTTP and SSH runtime exposure
- RACF certificate and keyring readiness
- network authorization context
- z/OS UNIX-side service configuration
- SMF and logging readiness
- external reachability investigation
- change control and rollback planning
- started-task identity baseline
- Hercules LCS / ETH1 troubleshooting
- Policy Agent readiness
- controlled AT-TLS enablement

The repository therefore represents a **Communications Server and network-security engineering track**, not only an initial LCS/ETH1 troubleshooting exercise.

---

# Lab navigation

## Foundation and security baseline

| Lab | Topic | Focus |
|---|---|---|
| [Lab 02](labs/02-config-operation-security/) | Configuration, Operation, Security and Enterprise Extender | Communications Server foundation |
| [Lab 03](labs/03-network-security-baseline/) | Network Security Baseline | Initial security posture |
| [Lab 04](labs/04-tcpip-profile-security-review/) | TCP/IP Profile Security Review | TCP/IP configuration inspection |
| [Lab 05](labs/05-network-security-authorization-review/) | Network Security Authorization Review | Authorization-related controls |
| [Lab 06](labs/06-network-security-policy-infrastructure-discovery/) | Policy Infrastructure Discovery | Security-policy readiness |
| [Lab 07](labs/07-tn3270-service-security-exposure-review/) | TN3270 Exposure Review | Interactive-access exposure |
| [Lab 08](labs/08-exposed-tcp-services-configuration-review/) | Exposed TCP Services Review | Service inventory and configuration |
| [Lab 09](labs/09-racf-certificate-keyring-inventory/) | RACF Certificate / Keyring Inventory | TLS and AT-TLS readiness |
| [Lab 10](labs/10-network-security-logging-smf-readiness-review/) | Logging and SMF Readiness | Audit / telemetry readiness |
| [Lab 11](labs/11-zos-unix-network-service-configuration-review/) | z/OS UNIX Network Services | USS-side service correlation |
| [Lab 12](labs/12-external-reachability-validation-attempt/) | External Reachability Attempt | End-to-end connectivity attempt |
| [Lab 13](labs/13-network-hardening-change-control-rollback-baseline/) | Hardening Change Control | Safe change and rollback baseline |

---

## Runtime service-control and hardening

| Lab | Topic | Focus |
|---|---|---|
| [Lab 14](labs/14-ftp-exposure-hardening-draft/) | FTP Exposure Hardening Draft | Hardening design |
| [Lab 15](labs/15-ftp-runtime-exposure-control-drill/) | FTP Runtime Exposure Control | Controlled FTP runtime change |
| [Lab 16](labs/16-http-runtime-exposure-control-drill/) | HTTP Runtime Exposure Control | Controlled HTTP runtime change |
| [Lab 17](labs/17-ssh-runtime-exposure-control-drill/) | SSH Runtime Exposure Control | Controlled SSH runtime change |
| [Lab 18](labs/18-tn3270-safe-hardening-planning/) | TN3270 Safe Hardening Planning | Critical access-path planning |
| [Lab 19](labs/19-network-started-task-identity-baseline/) | Network Started Task Identity Baseline | Service identity and RACF boundary |

---

## External connectivity and transport security

| Lab | Topic | Focus |
|---|---|---|
| [Lab 20](labs/20-external-network-connectivity-lcs-eth1-investigation/) | External Connectivity and LCS/ETH1 Investigation | Emulator/network attachment diagnosis |
| [Lab 21](labs/21-policy-agent-attls-readiness-assessment/) | Policy Agent / AT-TLS Readiness Assessment | Read-only transport-security readiness |
| [Lab 22](labs/22-controlled-policy-agent-attls-implementation/) | Controlled Policy Agent & AT-TLS Enablement Milestone | TTLS stack enablement checkpoint |

---

# Selected engineering milestones

## Network stack vs external network path

A recurring principle in this repository is:

```text
service listening
      !=
external reachability
```

The environment may have:

```text
TCP/IP active
VTAM active
TN3270 listening
FTP / SSH / HTTP processes active
```

while an external connectivity problem still exists below the service layer.

Lab 20 is the clearest example.

Validated there:

```text
TCP/IP profile processing
DEVICE LCS1 / LINK ETH1 initialization
LCS1 READY
Hercules LCS device availability
Hercules TAP backend initialization
internal TN3270 listener availability
```

But host-to-z/OS reachability was not fully established.

The remaining gap was isolated to the emulator/host integration layer rather than the core z/OS TCP/IP stack.

---

## TN3270 is a critical dependency

TN3270 is treated differently from other exposed services because it is the primary interactive access path into the lab environment.

That changes the engineering decision:

```text
FTP / HTTP / SSH
        |
        +--> suitable for controlled runtime drills

TN3270
        |
        +--> requires stronger rollback planning
        +--> should not be the first experimental TLS target
```

This is why Lab 18 emphasizes safe hardening planning rather than aggressive runtime modification.

---

## RACF certificate and keyring readiness

Lab 09 reviews RACF certificate and keyring inventory relevant to network encryption.

The observed environment contains RACF CERTAUTH material, but no service-owned certificate/keyring material was observed for several reviewed network service identities.

Important distinction:

```text
CA trust material exists
        !=
service TLS identity provisioned
```

The lab is therefore a **readiness inventory**, not proof of completed TLS deployment.

---

## SMF and network-security logging readiness

Lab 10 reviews the logging and audit-readiness baseline.

Validated observations include:

- SMF address space active;
- active SMF parameter member identified;
- SMF recording configuration reviewed;
- SYSLOGD not observed active;
- TRMD not observed active;
- no complete IDS/syslog/TRMD event path demonstrated.

The environment is z/OS V1R11. Modern zERT functionality is documented for architectural context, but it is **not available as a validated capability in this lab environment**.

---

## z/OS UNIX network-service correlation

Lab 11 extends the analysis from MVS-level configuration into USS.

Observed evidence includes:

- `/etc/ssh/sshd_config`;
- SSH protocol 2;
- `PermitRootLogin no`;
- password authentication;
- public-key authentication;
- SSH host-key references;
- SFTP subsystem configuration;
- SSH, HTTP and FTP process evidence;
- no active syslog daemon observed in captured evidence.

This establishes the cross-layer model:

```text
network-facing service
        |
        v
USS process / configuration
        |
        v
UNIX identity / permissions
        |
        v
RACF / SAF
```

---

## Network started-task identity

Lab 19 introduces explicit service identity analysis.

The relevant relationship is:

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
```

The Communications Server repository owns the networking interpretation.

The RACF repository owns effective authorization and security-profile interpretation.

---

# Policy Agent and AT-TLS progression

## Lab 21 — readiness assessment

Lab 21 is intentionally read-only.

Validated findings include:

- Policy Agent executable exists;
- IBM sample material exists;
- `BPX.DAEMON` profile present;
- no `PAGENT` RACF user observed;
- no `STARTED PAGENT.*` mapping observed;
- no matching `SERVAUTH EZB.PAGENT.*` profile observed;
- PAGENT not active;
- no system changes performed.

Correct interpretation:

```text
software present
     |
     v
prerequisites inspected
     |
     v
runtime/security gaps identified
     |
     v
implementation deferred
```

---

## Lab 22 — controlled TTLS enablement milestone

Lab 22 moves from readiness into controlled runtime enablement.

The lab establishes:

- Policy Agent executable startup evidence;
- dedicated environment data set preparation;
- PAGENT procedure adaptation through `STDENV`;
- `/etc/pagent.conf` preparation;
- active TCP/IP profile identification;
- rollback copy preservation;
- persistent TTLS enablement in the TCP/IP profile;
- minimal dynamic OBEY input;
- dynamic TTLS enablement without restarting TCP/IP;
- runtime message:

```text
EZZ4249I TCPIP INSTALLED TTLS POLICY HAS NO RULES
```

This is the key current checkpoint.

It proves that the stack reached the AT-TLS policy-processing layer.

It does **not** prove:

```text
service-specific TTLSRule installed
target-service certificate/keyring provisioned
stable final Policy Agent rule operation
TLS handshake validated
encrypted end-to-end application traffic validated
```

The correct current state is:

```text
AT-TLS readiness
      ->
TTLS stack enablement
      ->
policy layer reached
      ->
no service-specific rule yet
```

---

# Current architecture

```text
                    Communications Server
                           |
          +----------------+----------------+
          |                |                |
          v                v                v
        TCP/IP            VTAM            TN3270
          |
          +---------+------+----------+
                    |                 |
                    v                 v
              TCP services         USS services
            FTP / HTTP / SSH      process / config
                    |
                    v
                 RACF / SAF
        identity / cert / keyring
                    |
                    v
                 Policy Agent
                    |
                    v
                   AT-TLS
                    |
                    v
                 SMF / audit
```

Some elements are fully validated, others are readiness or partial-enablement milestones.

See [`docs/ECOSYSTEM-INTEGRATION.md`](docs/ECOSYSTEM-INTEGRATION.md) for the detailed capability matrix and cross-repository boundaries.

---

# Ecosystem integration

This repository is part of the broader **z/OS Engineering Laboratory**.

Master repository:

https://github.com/P-dot/zos-adcd-hercules-engineering-lab

The central engineering methodology is:

```text
Build -> Execute -> Observe -> Diagnose -> Correct -> Validate -> Document
```

For network-security work, this repository extends it with:

```text
Baseline
 -> identify exposure
 -> understand dependency
 -> prepare rollback
 -> apply minimal change
 -> validate runtime effect
 -> restore safe state where required
 -> document evidence
```

---

# Cross-repository boundaries

## RACF / SAF

RACF integration includes:

```text
started-task identity
SERVAUTH
BPX.DAEMON
certificate inventory
keyrings
effective authorization
```

General RACF administration and least-privilege validation belong to:

`P-dot/mainframe-racf-security-evidence`

---

## USS

USS integration includes:

```text
network daemon
/etc configuration
process visibility
UNIX ownership / permissions
```

Generic USS administration belongs to the dedicated USS repository.

---

## SMF

This repository consumes SMF as a logging and security-evidence dependency.

General SMF engineering remains part of the central z/OS engineering repository.

---

## Scheduler and batch workloads

Future batch/network integrations may follow:

```text
Scheduler
   |
   v
JCL / JES2
   |
   v
network-dependent workload
   |
   v
Communications Server
```

Scheduler controls workload timing and dependency logic.

Communications Server provides the network path.

---

# Evidence philosophy

A network lab should answer:

```text
What was configured?
What was active?
What was listening?
What changed?
What message proved the change?
What remained unresolved?
What was the rollback path?
```

Evidence may include:

- console output;
- NETSTAT results;
- TCP/IP profile excerpts;
- started-task context;
- sanitized screenshots;
- USS configuration excerpts;
- RACF display output;
- SMF readiness evidence;
- emulator-side diagnostic output after redaction;
- before/after states;
- rollback copies;
- troubleshooting notes.

A failed attempt can be valid evidence when it demonstrates accepted syntax discovery, release-specific behavior or an emulator limitation.

---

# Privacy and publication security

This is a public repository.

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

Use placeholders where required:

```text
<ZOS_IP>
<HOST_IP>
<HOST_LCS_IP>
<HOSTNAME>
<WINDOWS_USER>
<LOCAL_PATH>
```

Raw evidence should remain outside Git where necessary.

The existing repository redaction policy remains authoritative:

[`docs/03_redaction_policy.md`](docs/03_redaction_policy.md)

---

# Repository structure

```text
.
├── README.md
├── docs/
│   ├── 01_lab_overview.md
│   ├── 02_evidence_analysis.md
│   ├── 03_redaction_policy.md
│   ├── 04_commands_used.md
│   ├── 05_lessons_learned.md
│   └── ECOSYSTEM-INTEGRATION.md
├── labs/
│   ├── 02-config-operation-security/
│   ├── ...
│   └── 22-controlled-policy-agent-attls-implementation/
├── evidence/
│   ├── sanitized/
│   └── raw/              # keep unredacted material out of Git
├── notes/
└── scripts/
```

---

# Lab environment

The work is based on a controlled personal mainframe environment using:

- IBM z/OS ADCD V1R11;
- Hercules;
- TCP/IP;
- VTAM;
- TN3270;
- RACF;
- z/OS UNIX / OMVS;
- SDSF / operator commands;
- native Communications Server facilities available in the environment.

Behavior is release- and installation-dependent.

The repository documents the observed lab state rather than assuming that every production z/OS environment behaves identically.

---

# Engineering principles

1. **Observe before changing.**
2. **Separate service health from external reachability.**
3. **Correlate runtime state with configuration.**
4. **Understand the security identity behind each service.**
5. **Treat TN3270 as a critical operational dependency.**
6. **Use narrow runtime changes.**
7. **Prepare rollback before modification.**
8. **Do not claim encryption before validating encrypted traffic.**
9. **Preserve failed attempts when they teach a real operational lesson.**
10. **Redact host/network-specific data before publication.**
11. **Keep RACF, USS, SMF and networking ownership boundaries clear.**
12. **Distinguish validated, partial and planned capabilities.**

---

# Current maturity

The repository has progressed from:

```text
TCPIP started
VTAM active
TN3270 listener
NETSTAT evidence
```

to:

```text
network security baseline
TCP/IP profile review
service exposure analysis
RACF certificate/keyring inventory
SMF readiness
USS service correlation
```

then into:

```text
FTP / HTTP / SSH runtime exposure control
TN3270 hardening planning
started-task identity analysis
external LCS/ETH1 diagnosis
```

and now:

```text
Policy Agent readiness
AT-TLS prerequisite analysis
controlled TTLS stack enablement
policy-processing milestone
```

The next major maturity step is a **non-critical service-specific AT-TLS implementation with validated encrypted end-to-end traffic**.

---

# Next major milestone

The logical continuation from Lab 22 is:

```text
choose non-critical service
        |
        v
prepare RACF certificate/keyring
        |
        v
create service-specific TTLSRule
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
validate rollback / persistence
```

TN3270 should not be the first target.

---

# Repository role

`zos-communications-server-network-lab` is the **network communications, service-exposure and transport-security engineering component** of the wider z/OS Engineering Laboratory.

Its evolution is:

```text
network discovery
   ->
security baseline
   ->
service exposure
   ->
RACF / certificate readiness
   ->
SMF / USS correlation
   ->
runtime control
   ->
identity analysis
   ->
external connectivity diagnosis
   ->
Policy Agent readiness
   ->
controlled TTLS enablement
   ->
future encrypted-service validation
```

This repository should therefore be read as a progressive Communications Server engineering portfolio, with clear separation between what has been observed, what has been safely controlled, what has been partially enabled, and what still remains to be validated.
