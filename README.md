# z/OS Communications Server Network Evidence Lab

Educational lab documenting the network evidence gathered from an ADCD z/OS environment running on an emulator.

> Privacy note: all portfolio material uses placeholders such as `<ZOS_IP>`, `<HOST_IP>`, `<HOST_LCS_IP>`, `<WINDOWS_USER>`, `<HOSTNAME>`, and `<LOCAL_PATH>`. Raw outputs and unredacted screenshots are intentionally excluded.

## Objective

Build a recruiter-friendly and technically accurate lab showing how to verify z/OS Communications Server, TCP/IP, VTAM, TN3270, basic services, LCS/ETH link state, VIPA absence, and XCF/Sysplex infrastructure.

## What this lab proves

| Area | Evidence | Interpretation |
|---|---|---|
| Communications Server | `TCPIP`, `VTAM`, `TN3270` active | The z/OS networking subsystem is loaded internally. |
| TCP/IP HOME | `<ZOS_IP>` assigned to `ETH1` | z/OS has a configured IP address on the LCS link. |
| TCP/IP listeners | `FTPD1`, `SSHD4`, `TN3270`, `HTTPD1` in `LISTEN` | Services are listening inside z/OS. |
| Link state | `LCS1 READY`, `ETH1 NOT ACTIVE` | The problem is the emulated external link, not the TCP/IP started task. |
| Windows reachability | `TcpTestSucceeded: False` to port `23` | The host cannot reach z/OS externally while `ETH1` is not active. |
| VIPA | `NETSTAT VIPADCFG` returns end of report | No VIPA is configured in this lab. |
| XCF/Sysplex | `ADCDPL`, XCF groups, couple data sets | The system has single-system sysplex infrastructure. |

## Repository structure

```text
.
├── README.md
├── docs/
│   ├── 01_lab_overview.md
│   ├── 02_evidence_analysis.md
│   ├── 03_redaction_policy.md
│   ├── 04_commands_used.md
│   └── 05_lessons_learned.md
├── evidence/
│   ├── sanitized/
│   └── raw/              # ignored; do not commit raw data
├── scripts/
│   ├── collect_readonly_windows_network.ps1
│   └── sanitize_text.ps1
└── .gitignore
```

## Sanitized screenshots

The screenshots in `evidence/sanitized/` are safe for GitHub. They preserve the learning value but hide private addressing, usernames, hostnames, and local paths where needed.

## Key takeaway

The environment shows a common mainframe-networking diagnostic pattern:

```text
TCPIP started task     OK
VTAM                   OK
TN3270 listener         OK
z/OS services           OK
External link ETH1      NOT ACTIVE
Host-to-z/OS reachability failed
```

So the educational conclusion is: **do not troubleshoot TN3270 first when TN3270 is already listening. Troubleshoot the emulated network attachment: LCS/ETH1/OSA/tunnel/adapter.**

---

## Part of the z/OS Engineering Laboratory

This repository is a specialized component of the broader **z/OS Engineering Laboratory** built on z/OS ADCD 1.11 / Hercules.

### Master architecture

https://github.com/P-dot/zos-adcd-hercules-engineering-lab

### Engineering methodology

```text
Build -> Execute -> Observe -> Diagnose -> Correct -> Validate -> Document
```
