# 01 - Lab overview

This lab documents a practical investigation of z/OS Communications Server networking in an ADCD/Hercules-style environment.

## Scope

The lab is intentionally defensive and educational. It does not publish real private IP addresses, usernames, machine names, local paths, or shared-folder names.

## Components studied

- `TCPIP`: z/OS TCP/IP stack.
- `VTAM`: SNA/3270 communications component.
- `TN3270`: 3270 access through z/OS TCP/IP.
- `FTPD1`, `SSHD4`, `HTTPD1`: network services visible through `NETSTAT CONN`.
- `LCS1` / `ETH1`: emulated network link used by z/OS.
- `XCF`: sysplex coordination infrastructure.
- `VIPA`: checked but not configured.

## Lab status

The internal z/OS network stack is healthy, but the external emulated link is not active.

```text
TCPIP  = OK
VTAM   = OK
TN3270 = OK
Services listening = OK
ETH1   = NOT ACTIVE
VIPA   = Not configured
XCF    = Active, single-system sysplex evidence found
```
