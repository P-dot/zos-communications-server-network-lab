# Sanitized Findings - Lab 15

## Scope

This lab reviewed FTP runtime exposure control in a local z/OS Communications Server lab environment.

## Findings

### FTP before the drill

`FTPD1` was active and TCP port 21 was listening.

### FTP after runtime stop

The FTP shutdown was initiated. Afterward, `FTPD1` was not found and TCP port 21 returned zero records.

### FTP restoration

A later TCP port 21 check showed the FTP listener restored.

## Risk interpretation

FTP is a classic network service and should be explicitly justified, monitored and protected. If FTP is not required, disabling automatic startup or replacing it with a secured alternative may reduce exposure.

## Control status

This lab performed a temporary runtime drill. It did not apply any permanent hardening change to the active TCP/IP profile.
