# Lab 12 - External Reachability Validation Attempt

## Objective

This lab documents an external reachability validation attempt from a Windows host against selected z/OS TCP service ports identified in previous labs.

The intended ports were:

- TCP 21 - FTP
- TCP 22 - SSH
- TCP 23 - TN3270
- TCP 80 - HTTP
- TCP 443 - HTTPS

## Scope

This was a read-only external validation attempt. No scanning tool, vulnerability scanner, brute-force test, login attempt or service modification was performed.

## Evidence reviewed

The PowerShell commands used `Test-NetConnection` against the variable `$ZOS` for ports 21, 22, 23, 80 and 443.

The captured evidence shows that `$ZOS` still contained the literal placeholder `<ZOS_IP>`. Windows attempted to resolve `<ZOS_IP>` as a name and returned a name resolution warning.

## Finding

The external reachability test procedure was prepared, but the captured execution did not validate real z/OS network reachability because the placeholder `<ZOS_IP>` was not replaced with the actual z/OS IP address before running the commands.

## Professional interpretation

This evidence must not be interpreted as proof that FTP, SSH, TN3270, HTTP or HTTPS are unreachable from Windows.

The correct interpretation is:

- the test command structure was prepared;
- the placeholder value was not replaced;
- the result is a procedural validation gap, not a network connectivity finding;
- a valid reachability result requires re-running the same commands with the real z/OS IP address and sanitizing the published output.

## Relationship with previous labs

Previous internal z/OS evidence showed:

- FTP listening on TCP 21;
- SSH listening on TCP 22;
- TN3270 listening on TCP 23;
- HTTP listening on TCP 80;
- no HTTPS listener observed on TCP 443.

This lab adds the external validation procedure, but not a conclusive external reachability result.

## Safety statement

No changes were made to z/OS, Windows network configuration, TCP/IP profiles, RACF, certificates, services or firewall settings.

## Next audit action

Repeat the same PowerShell commands with the actual z/OS IP address in the local lab environment, then sanitize the result before publication.

```powershell
$ZOS="<REAL_ZOS_IP>"
Test-NetConnection $ZOS -Port 21
Test-NetConnection $ZOS -Port 22
Test-NetConnection $ZOS -Port 23
Test-NetConnection $ZOS -Port 80
Test-NetConnection $ZOS -Port 443
```
