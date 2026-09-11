# Lab 23 — Part 2: Policy Agent and AT-TLS Controlled Integration Troubleshooting

## Objective

Continue the HTTP AT-TLS integration work started in Lab 23 Part 1 on **z/OS V1R11**, while preserving service availability and collecting enough evidence to identify why Policy Agent (`PAGENT`) terminates during initialization.

This part deliberately stops **before enabling AT-TLS in the TCP/IP stack**. The purpose is to close the troubleshooting checkpoint cleanly, document what is known, what is not yet proven, and the safest paths for Part 3.

## Scope

This part covered:

- verification of the retained RACF key ring and certificate from Lab 33;
- review and extension of RACF FACILITY access used during the AT-TLS investigation;
- construction of an initial HTTP AT-TLS policy for `HTTPD1` on local port 80;
- comparison of two supported Policy Agent configuration layouts;
- restoration of the previously known Lab 22 `pagent.conf` layout;
- repeated controlled starts of `PAGENT` with **runtime TTLS left disabled**;
- attempt to redirect Policy Agent logging to `/tmp/pagent.log`;
- attempt to increase Policy Agent diagnostic logging with `LogLevel 511`;
- confirmation that `PAGENT` still terminates with `EZZ8434I` before producing the expected USS log;
- preservation of a safe rollback state.

## Final status

**PARTIAL / CONTROLLED STOP — investigation checkpoint reached; AT-TLS not enabled.**

The lab is intentionally closed here because the available evidence does not yet prove the exact internal cause of the `PAGENT` abnormal exit. Continuing by trial-and-error would increase the risk of damaging a working z/OS V1R11 network environment.

### What is proven

- The `PAGENT` executable is installed and is reached successfully: `EZZ8431I PAGENT STARTING` is issued.
- The started task then terminates almost immediately with `EZZ8434I PAGENT EXITING ABNORMALLY`.
- `/etc/pagent.conf` exists and was restored to the same compact form used in Lab 22:

```text
TcpImage TCPIP FLUSH PURGE
TTLSConfig /etc/pagent/TCPIP_TTLS.policy
```

- The alternative image-file form (`TcpImage ... /etc/pagent/TCPIP.image ...`) is a valid IBM configuration pattern and was **not** proven to be the root cause.
- Setting `PAGENT_LOG_FILE=/tmp/pagent.log` did not result in creation of `/tmp/pagent.log` during the failed start.
- Adding `LogLevel 511` also did not produce the expected USS Policy Agent log before termination.
- `LISTUSER HTTPD1` returned `ICH30001I UNABLE TO LOCATE USER ENTRY HTTPD1`; therefore, the effective RACF identity used by the HTTP started task is still unresolved and must not be guessed.
- Runtime TCP/IP remains on the safe **NOTTLS** baseline. No new `TCPCONFIG TTLS` activation was performed in this part.

### What is not proven

The current evidence does **not** prove that the failure is caused by:

- the `TTLSRule` syntax;
- the key ring reference;
- the HTTP application identity;
- the FACILITY permissions added during the investigation;
- the `TcpImage` layout;
- or a missing/incorrect certificate selection.

The abnormal exit occurs early enough that the next investigation must first obtain Policy Agent's detailed initialization diagnostics.

## Attempted AT-TLS policy

The current experimental policy is preserved under `config/TCPIP_TTLS.policy.attempted` for analysis only. It must **not** be treated as validated V1R11 production syntax.

## Safe baseline at close

```text
TCP/IP runtime     : NOTTLS
Persistent profile : no TTLS enablement added by this part
PAGENT             : stopped / exits abnormally when started
HTTPD1             : existing HTTP service configuration not intentionally changed
Certificate/ring   : retained from Lab 33
AT-TLS policy      : experimental; not installed into an active TTLS stack
```

## Result

This part successfully converted an unsafe "keep trying until PAGENT starts" situation into a bounded engineering problem with preserved evidence, rollback, known hypotheses, and a V1R11-specific next-action plan.

The next part should start with **diagnostic initialization of PAGENT (`-d` / IBM-documented trace path), syslogd verification, and controlled policy isolation**, not with `TCPCONFIG TTLS`.

See:

- `docs/failure-analysis.md`
- `docs/possible-solutions.md`
- `docs/v1r11-guardrails.md`
- `commands/lab23-part2-commands.txt`
- `evidence/manifest.md`
