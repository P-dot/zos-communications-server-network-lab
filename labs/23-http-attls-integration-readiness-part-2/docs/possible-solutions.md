# Possible Solutions and Next Investigation Paths

These are controlled hypotheses for the next part. They are deliberately ordered to obtain evidence before changing more system state.

## 1. Start Policy Agent with IBM-documented debug tracing

IBM's response for `EZZ8434I` is to reproduce the problem with the Policy Agent `-d` trace option (or `LogLevel 511`). `LogLevel 511` has already been attempted, so the next step is to determine the **correct V1R11 started-task syntax for `-d` / `-d 1`** and capture the resulting messages.

Do not guess how to combine this option with the existing Language Environment `ENVAR("_CEE_ENVFILE=DD:STDENV")` parameter. Confirm the V1R11 procedure syntax first.

## 2. Verify syslogd and inspect the Policy Agent messages there

IBM documents that if Policy Agent cannot read startup options or cannot open its UNIX log destination, it can write diagnostics to the syslog daemon and then terminate.

Because `/tmp/pagent.log` was not created, syslogd becomes a priority diagnostic path.

Future checks should determine:

- whether syslogd is active;
- where local daemon messages are routed;
- whether PAGENT emits a `SYSERR` or `OBJERR` immediately before `EZZ8434I`.

## 3. Isolate startup configuration from AT-TLS policy parsing

After diagnostics are available, test one layer at a time using backups:

1. Known-good Policy Agent environment only.
2. Main `pagent.conf` only.
3. Add the TCP/IP image association.
4. Add `TTLSConfig` pointing to a minimal V1R11-compatible policy.
5. Add the HTTP rule selectors.
6. Add the TLS environment and key ring.
7. Add explicit certificate selection if required.

This sequence will identify the exact statement that introduces the failure instead of changing several layers simultaneously.

## 4. Revalidate every policy keyword against V1R11 documentation

The conceptual AT-TLS constructs used in this lab existed in the V1R11 era (`Jobname`/`Username`, `LocalPortRange`, `HandshakeRole`, `TTLSKeyRingParms`, and `ApplicationControlled`). Nevertheless, the exact policy grammar, allowed values, and nesting must be checked against the V1R11 IP Configuration Reference before reuse.

Do not copy modern z/OS policy examples blindly into V1R11.

## 5. Resolve the effective HTTPD1 security identity

The started procedure is `HTTPD1`, but there is no RACF USER entry named `HTTPD1` in the captured evidence.

Part 3 should resolve the actual credentials by using concrete runtime evidence such as the started-task assignment messages (`IEF695I` or equivalent), STARTED class mapping, and the existing HTTP server procedure. Only then should key-ring access be changed.

## 6. Review provisional RACF FACILITY changes

During Part 2, access was added for `TCPIP` to:

- `IRR.DIGTCERT.LISTRING` with UPDATE;
- `IRR.DIGTCERT.GENCERT` with CONTROL (after defining the profile because it did not previously exist).

These permissions must be treated as **provisional investigation state**, not as the final least-privilege design. If Part 3 proves that the AT-TLS operation uses another identity for the required R_datalib operation, remove unnecessary access from `TCPIP`.

## 7. Make certificate selection explicit if required

The retained `LAB33CERT` was previously recorded as non-default on `LAB33RING`. If System SSL cannot infer the correct server certificate, a V1R11-supported explicit certificate-label policy parameter may be required.

This is a handshake/configuration issue and should only be addressed **after PAGENT can parse and install policy successfully**.

## 8. Protect startup availability before enabling TTLS

The post-Lab-22 incident demonstrated the operational risk of enabling TTLS while the stack is still waiting for usable PAGENT policy.

Before future `TCPCONFIG TTLS` activation, review the V1R11 `SERVAUTH` / `EZB.INITSTACK.<sysname>.<tcpname>` design so that essential services are not unexpectedly blocked during policy initialization.

## 9. Consider maintenance/APAR level only after configuration is proven

z/OS V1R11 is an old release. If a minimal policy that exactly matches IBM V1R11 documentation still fails with valid startup diagnostics, check the Communications Server maintenance/APAR level before assuming unsupported syntax or product corruption.

This is intentionally a late-stage path: configuration evidence should be exhausted first.

## Success gate for Part 3

Do **not** enable runtime TTLS until all of the following are true:

```text
PAGENT starts and remains active
PAGENT initialization completes
TTLS policy is parsed without error
Policy is installed for stack TCPIP
Effective HTTP identity is known
Key ring/certificate access is justified
Rollback remains available
```
