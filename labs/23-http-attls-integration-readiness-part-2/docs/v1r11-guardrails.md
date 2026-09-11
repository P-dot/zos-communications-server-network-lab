# z/OS V1R11 Guardrails for the Next Part

## Release-specific rule

This laboratory runs on **z/OS V1R11**. Modern examples can contain statements, protocol versions, cipher controls, defaults, or operational behavior that did not exist in V1R11.

Every future change to Policy Agent, AT-TLS, System SSL, RACF certificate access, or TCP/IP policy must therefore be classified as one of:

- explicitly documented for V1R11;
- demonstrated by this ADCD image;
- or experimental and reversible.

## AT-TLS capability in V1R11

IBM's V1R11 implementation material confirms that Communications Server already supported AT-TLS and Policy Agent, including policy selection by job/user, local port matching, server handshake roles, SAF key rings, and application-controlled behavior.

The same material describes TLS V1.1-related enhancements in V1R11. Do not assume modern TLS 1.2/1.3 examples are valid for this image without release-specific confirmation.

## Configuration-file topology

Both of the following architectures are valid IBM patterns:

### Compact / same-file image control

```text
TcpImage TCPIP FLUSH PURGE
TTLSConfig /etc/pagent/TCPIP_TTLS.policy
```

### Separate image configuration

```text
# /etc/pagent.conf
TcpImage TCPIP /etc/pagent/TCPIP.image FLUSH PURGE

# /etc/pagent/TCPIP.image
TTLSConfig /etc/pagent/TCPIP_TTLS.policy
```

IBM support information specifically lists the separate-image pattern for releases including **1.11**. The Part 2 failure therefore must not be attributed merely to the existence of `TCPIP.image`.

For this lab, the compact form is preferred during recovery because it matches the previously documented Lab 22 topology and reduces variables.

## Logging

IBM documents:

- default Policy Agent configuration file: `/etc/pagent.conf` unless overridden;
- default log path: `/tmp/pagent.log` unless overridden;
- `LogLevel 511` as maximum configuration tracing;
- `-d` as the next startup/debug mechanism for initialization failures;
- fallback to syslogd when startup options/log destination cannot be established.

The absence of `/tmp/pagent.log` after the Part 2 failure is therefore meaningful diagnostic evidence, but it does not by itself identify the failing subsystem.

## Runtime activation rule

`TCPCONFIG TTLS` is the final activation step, not the troubleshooting tool.

Keep the runtime stack on `NOTTLS` until Policy Agent is demonstrably healthy and the policy has been installed successfully.

## Security rule

Do not retain broad RACF permissions just because they made troubleshooting easier. Resolve the actual started-task/application identity first, then implement least privilege and remove provisional access.
