# Lab 20 — External Network Connectivity and LCS/ETH1 Investigation

## Status
**COMPLETED — DIAGNOSIS / PARTIAL CONNECTIVITY**

## Objective
Investigate the external networking path of an emulated z/OS Communications Server environment and isolate why host-to-z/OS connectivity could not be fully established.

## Validated
- TCP/IP profile processing
- DEVICE LCS1 / LINK ETH1 initialization
- LCS1 READY state
- Hercules LCS device availability
- Hercules TAP backend initialization
- Internal TN3270 listener availability

## External reachability
Host-to-z/OS reachability was not fully established.

The remaining gap was isolated to the emulator/host networking integration layer rather than the core z/OS TCP/IP profile.

## Security
Real IP addresses, MAC addresses, gateways, adapter identifiers, network prefixes and other host-specific values are intentionally omitted.
