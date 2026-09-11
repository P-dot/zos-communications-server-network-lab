# Lab 23 - Part 1: HTTP AT-TLS Integration Readiness and Identity Resolution

## Objective

Establish a controlled, evidence-based starting point for RACF-backed AT-TLS protection of the existing HTTPD1 service on z/OS V1R11, without enabling AT-TLS or changing the running service.

This first part closes at the discovery/readiness boundary. It identifies the HTTP server implementation and configuration, confirms its existing SSL-capable directives, correlates the service with RACF STARTED-class behavior, and records the unresolved identity/key-ring consumption question that must be solved before Policy Agent activation.

## Architectural context

RACF Lab 33 retained the synthetic cryptographic handoff artifacts `LAB33CERT` and `LAB33RING` under `H7USER`. Communications Server now owns the next stages: Policy Agent, TTLSRule design, AT-TLS activation, transport validation and later observability.

```text
RACF Lab 33
LAB33CERT + LAB33RING
        |
        v
Communications Server Lab 23
Part 1 - readiness / identity resolution  <-- this checkpoint
        |
        v
Part 2 - key-ring access + TTLS policy
        |
        v
controlled AT-TLS activation
        |
        v
TLS validation / observability
```

## Validated findings

### HTTPD1 implementation

The active procedure is `ADCD.Z111S.PROCLIB(HTTPD1)`. It starts `PGM=IMWHTTPD` and references:

- `/web/httpd1/httpd.conf`
- `/web/httpd1/httpd.envvars`

The server remains the existing HTTP application; no PROC change was made.

### HTTP configuration review

The configuration review showed SSL-related directives documented in the HTTP server configuration, including `SSLMode`, `SSLPort`, `SSLKey`, `SSLClientAuth`, `SSLCipherSpec` and `SSLServerCert`. The captured configuration shows `SSLMode off` and an SSL port value of 443.

For this integration track, native HTTP SSL is intentionally not enabled. The design target is transparent AT-TLS protection below the application layer.

### RACF STARTED-class resolution

`LISTUSER WEBSRV1` returned `ICH30001I UNABLE TO LOCATE USER ENTRY WEBSRV1`. Therefore the runtime label previously observed as WEBSRV1 must not be treated as proof of an existing RACF USER profile.

`SEARCH CLASS(STARTED) MASK(HTTPD)` located the generic profile `HTTPD1.**`. `RLIST STARTED HTTPD1.** ALL` showed:

```text
USER  =MEMBER
GROUP =MEMBER
TRUSTED=NO
PRIVILEGED=NO
TRACE=NO
```

This establishes that HTTPD1 is covered by a STARTED-class profile using member-derived identity semantics. The evidence captured in this part does not establish a RACF `WEBSRV1` user entry.

### Startup evidence

SDSF/SYSLOG review located HTTPD1 startup activity, including `$HASP373 HTTPD1 STARTED` and `IEF403I HTTPD1 - STARTED`. The captured startup region did not provide evidence sufficient to assert an `IEF695I` assignment of HTTPD1 to RACF USER `WEBSRV1`.

## Safety and change control

Part 1 is a discovery/readiness checkpoint. No AT-TLS activation was performed. No certificate or key ring was created or modified. No HTTPD1 configuration was changed. No TCP/IP profile was changed. No OBEYFILE was issued for TTLS activation. No Policy Agent activation was performed.

The safe baseline from the previous work remains the required starting state: AT-TLS must not be re-enabled until a valid policy and cryptographic-access path are ready.

## Result

**PASS - Part 1 readiness checkpoint completed.**

The HTTP target is sufficiently characterized to continue, but end-to-end TLS is **not** claimed. The next part must resolve access from the AT-TLS/System SSL execution context to the retained RACF key ring and certificate, then build and validate the minimum TTLS policy before `TCPCONFIG TTLS` is enabled again.

## Next part

Part 2 should begin with read-only confirmation of the retained `H7USER/LAB33RING` -> `LAB33CERT` association and z/OS V1R11-specific key-ring authorization semantics. Only after that should the lab create the Policy Agent/TTLS configuration and perform controlled activation.

## Evidence

The screenshots supplied during execution are preserved under `evidence/screenshots/`. Before public publication, review all images for host names, IP addresses, MAC addresses or other environment-specific data and redact where necessary.

## References

- IBM z/OS V1R11 Communications Server IP Configuration Guide / Policy Agent and AT-TLS documentation.
- IBM z/OS Security Server RACF documentation for STARTED class and RACDCERT/key-ring authorization.
- Portfolio: `mainframe-racf-security-evidence`, Labs 31-33.
- Portfolio: `zos-communications-server-network-lab`, Labs 08, 16, 19 and 22.
