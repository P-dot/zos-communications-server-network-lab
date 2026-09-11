# Failure Analysis

## Primary symptom

Each controlled Policy Agent start reaches:

```text
EZZ8431I PAGENT STARTING
```

and then terminates almost immediately with:

```text
EZZ8434I PAGENT EXITING ABNORMALLY
```

No successful Policy Agent initialization-complete message was captured in Part 2.

## Why this is important

`EZZ8431I` proves that the started task reaches the Policy Agent program. Therefore, this is not evidence of a missing `PAGENT` executable.

`EZZ8434I` is a generic abnormal-exit message. IBM's documented operator response is to reproduce the problem using Policy Agent debug tracing (`-d`) or `LogLevel 511`, and then act on the detailed log information. The message by itself does not identify the failing policy statement.

## Evidence narrowing the fault domain

### 1. Main configuration file path is reachable from the shell

`/etc/pagent.conf` was displayed successfully after restoration. Therefore, the exact historical error "configuration file does not exist" is not supported by the current evidence.

### 2. The Lab 22 compact structure was restored

The active test was returned to:

```text
TcpImage TCPIP FLUSH PURGE
TTLSConfig /etc/pagent/TCPIP_TTLS.policy
```

PAGENT still terminated abnormally. Therefore, the temporary introduction of `/etc/pagent/TCPIP.image` was not sufficient to explain the current failure.

### 3. USS log redirection did not produce `/tmp/pagent.log`

With:

```text
PAGENT_LOG_FILE=/tmp/pagent.log
```

the failed start did not leave the expected file. IBM documentation notes that when Policy Agent cannot read start options or cannot establish its UNIX log destination, error messages can instead be sent to syslogd before abnormal exit. This moves "startup options / environment / log initialization" higher on the hypothesis list.

### 4. `LogLevel 511` did not resolve observability

A temporary maximum logging configuration was tested. PAGENT still exited before the expected USS log became available. The next diagnostic level should therefore be the documented `-d` startup trace together with syslogd inspection.

### 5. HTTPD1 RACF identity is unresolved

`LISTUSER HTTPD1` returned:

```text
ICH30001I UNABLE TO LOCATE USER ENTRY HTTPD1
```

This disproves the assumption that a standalone RACF USER entry named `HTTPD1` can simply be used for subsequent key-ring permissions. Effective started-task credentials must be resolved from actual start messages / STARTED class behavior before least-privilege access is finalized.

## Current fault statement

At close of Part 2, the most accurate statement is:

> Policy Agent on this z/OS V1R11 image starts the executable but fails during early initialization. The generic EZZ8434I is confirmed, but the exact internal cause has not yet been obtained. The failure cannot yet be attributed conclusively to the AT-TLS rule, the key ring, the HTTP identity, or the Policy Agent configuration layout.

## Items explicitly not claimed

This lab does **not** claim that:

- AT-TLS policy syntax has been validated;
- the key ring has been successfully consumed by AT-TLS;
- HTTP traffic is encrypted;
- the correct runtime application identity has been identified;
- PAGENT is stable;
- `TCPCONFIG TTLS` is safe to enable.
