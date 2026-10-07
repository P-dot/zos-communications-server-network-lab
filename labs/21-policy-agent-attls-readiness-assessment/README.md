# Lab 21 — Policy Agent / AT-TLS Readiness Assessment

## Status
**COMPLETED — READ-ONLY DISCOVERY / READINESS ASSESSMENT**

## Objective
Assess Policy Agent and AT-TLS readiness in the current z/OS V1R11 Communications Server environment as a practical precursor to modern network-encryption visibility, without changing the running system.

## Findings
- Policy Agent executable verified: `/usr/lpp/tcpip/sbin/pagent`
- IBM `EZAPAGSP` sample located
- IBM `EZARACF` sample located
- RACF `BPX.DAEMON` profile present
- RACF user `PAGENT` not defined
- `STARTED PAGENT.*` not defined
- `SERVAUTH EZB.PAGENT.*` not found
- PAGENT not active
- No configuration changes performed

## Engineering decision
Implementation is intentionally deferred to a separate controlled-change lab. No RACF users/profiles, started tasks, TCP/IP statements, or USS policy files were created or modified.

## Final assessment
**Readiness assessment complete. System unchanged. Controlled PAGENT/AT-TLS implementation deferred.**


---
### Continue learning

**Previous:** [20-external-network-connectivity-lcs-eth1-investigation](../20-external-network-connectivity-lcs-eth1-investigation/)  
**Course:** [Course home](../../README.md)  
**Next:** [22-controlled-policy-agent-attls-implementation](../22-controlled-policy-agent-attls-implementation/)  
**Academy:** [z/OS Engineering Academy](https://github.com/P-dot/P-dot/blob/main/docs/ACADEMY.md) · [Curriculum](https://github.com/P-dot/P-dot/blob/main/docs/CURRICULUM.md)
