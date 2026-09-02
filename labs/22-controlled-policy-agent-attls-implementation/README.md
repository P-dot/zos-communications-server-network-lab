# Lab 22 — Controlled Policy Agent & AT-TLS Enablement Milestone

## Objective

Advance the z/OS V1R11 Communications Server security baseline from AT-TLS readiness into a **controlled runtime enablement milestone**, without restarting the TCP/IP stack and without yet enforcing TLS on a production-like service.

This checkpoint deliberately stops before certificate/keyring creation and before installation of a service-specific AT-TLS rule.

## Environment

- IBM z/OS V1R11 ADCD / Hercules lab
- TCP/IP started task: `TCPIP`
- TCP/IP parameter library: `ADCD.Z111S.TCPPARMS`
- Policy Agent started-task procedure: `USER.PROCLIB(PAGENT)`
- Policy Agent environment: `USER.PAGENT.ENV(PAGENT)`
- Policy Agent main configuration: `/etc/pagent.conf`

## Milestone achieved

The lab reached the following controlled state:

1. Policy Agent executable availability had already been proven by `EZZ8431I PAGENT STARTING`.
2. A dedicated VB environment data set was created for Policy Agent.
3. `USER.PROCLIB(PAGENT)` was adapted to use the environment member through `STDENV`.
4. `/etc/pagent.conf` was created and prepared to reference an AT-TLS policy.
5. The active TCP/IP profile was identified as `ADCD.Z111S.TCPPARMS(PROF1)`.
6. A rollback copy, `PROF1B22`, was preserved before the persistent change.
7. The persistent profile was changed from `TCPCONFIG RESTRICTLOWPORTS` to `TCPCONFIG RESTRICTLOWPORTS TTLS`.
8. A minimal OBEY input containing only `TCPCONFIG TTLS` was prepared.
9. The running TCP/IP stack processed the dynamic change without a stack restart.
10. Runtime evidence reported `EZZ4249I TCPIP INSTALLED TTLS POLICY HAS NO RULES`.

The final message is the key checkpoint: the stack has reached the AT-TLS policy layer, but no service-specific AT-TLS rules have yet been installed. This is an intentional boundary for this lab checkpoint.

## Architecture at close

```text
ADCD.Z111S.TCPPARMS(PROF1)
  TCPCONFIG RESTRICTLOWPORTS TTLS
                 |
                 | persistent configuration
                 v
            TCP/IP stack
                 ^
                 | dynamic enablement
                 |
USER.OBEY
  TCPCONFIG TTLS

USER.PROCLIB(PAGENT)
        |
        v
USER.PAGENT.ENV(PAGENT)
        |
        v
/etc/pagent.conf
        |
        +--> TTLSConfig /etc/pagent/TCPIP_TTLS.policy
                         |
                         +--> policy rules NOT created yet
```

## Safety and change control

- TCP/IP was **not restarted**.
- TN3270 was **not stopped or modified**.
- No service-specific TLS rule was activated.
- No RACF certificate or keyring was created in this checkpoint.
- `PROF1B22` preserves the pre-change TCP/IP profile state for rollback.
- The OBEY input was intentionally minimal so that unrelated TCP/IP profile statements were not reprocessed.

## Troubleshooting captured

The lab also records an important operational lesson: several command forms were rejected while determining the syntax accepted by this V1R11 environment. These failed attempts did not apply the runtime change. The final evidence is based on the subsequent TCP/IP message showing the TTLS policy layer installed with no rules.

## Evidence

See `evidence/screenshots/`:

- `01-pagent-environment-member.png` — Policy Agent environment member.
- `02-tcpip-started-procedure.png` — TCP/IP started procedure context.
- `03-tcpip-profile-dd-context.png` — profile-related DD/context in the TCP/IP PROC.
- `04-ttlson-member.png` — first minimal `TCPCONFIG TTLS` member.
- `05-prof1-ttls-persistent-change.png` — persistent `PROF1` change.
- `06-obeyfile-syntax-troubleshooting.png` — rejected OBEYFILE syntax evidence.
- `07-user-obey-minimal-member.png` — short minimal OBEY data set.
- `08-runtime-ttls-no-rules-message.png` — runtime milestone: `EZZ4249I ... TTLS POLICY HAS NO RULES`.

## Result

**PASS — controlled AT-TLS enablement milestone reached.**

The result is intentionally narrower than “AT-TLS fully implemented”. At close, the TCP/IP stack is prepared for AT-TLS policy processing, while certificate/keyring provisioning, a concrete `TTLSRule`, Policy Agent stable operation with that rule, and an encrypted end-to-end service validation remain for the next phase.

## Next phase

Continue from this checkpoint by selecting a non-critical test service, creating or assigning the required RACF certificate/keyring material, building the first service-specific AT-TLS policy, starting Policy Agent under controlled conditions, and validating both policy installation and encrypted traffic. TN3270 should not be the first target because it is the critical interactive access path in this lab environment.

## References

- IBM z/OS Communications Server: IP Configuration Guide / IP Configuration Reference (z/OS V1R11 family).
- IBM Policy Agent and AT-TLS configuration documentation.
- Portfolio Lab 09 — RACF Certificate and Keyring Inventory for Network Security.
- Portfolio Lab 18 — TN3270 Safe Hardening Planning.
