# Commands

Commands prepared for external reachability validation:

```powershell
$ZOS="<ZOS_IP>"
Test-NetConnection $ZOS -Port 21
Test-NetConnection $ZOS -Port 22
Test-NetConnection $ZOS -Port 23
Test-NetConnection $ZOS -Port 80
Test-NetConnection $ZOS -Port 443
```

Observed issue:

```text
WARNING: Name resolution of <ZOS_IP> failed
PingSucceeded : False
```

Interpretation:

The placeholder was not replaced with the real z/OS IP address, so the result is not a valid service reachability test.
