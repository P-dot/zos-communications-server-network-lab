# References

## Local / project sources

1. IBM Redbook — **z/OS Version 1 Release 11 Implementation** (`sg247729.pdf`).
   - Confirms V1R11 Communications Server policy infrastructure / AT-TLS capability.
   - Documents AT-TLS concepts including policy selection by Jobname/Username, LocalPortRange, server handshake roles, SAF key rings, and ApplicationControlled behavior.

2. Lab 22 repository evidence.
   - Established the previously used compact Policy Agent configuration:
     `TcpImage TCPIP FLUSH PURGE` followed by `TTLSConfig ...`.
   - Lab 22 was an AT-TLS enablement milestone only; stable PAGENT with a final service policy remained pending.

3. Lab 33 RACF evidence.
   - Retained `LAB33CERT` and `LAB33RING` for later Communications Server integration.

## IBM web documentation consulted

- IBM message documentation: **EZZ8434I PAGENT EXITING ABNORMALLY**
  https://www.ibm.com/docs/en/zos/3.1.0?topic=messages-ezz8434i

- IBM: **Initialization problems** (Policy Agent)
  https://www.ibm.com/docs/en/zos/3.2.0?topic=dpap-initialization-problems

- IBM: **Policy Agent configuration / logging guidance**
  https://www.ibm.com/docs/en/zos/3.2.0?topic=agent-step-1-configure-general-information

- IBM support: **EZZ8434I CODE 1 when starting PAGENT**
  https://www.ibm.com/support/pages/ezz8434i-code-1-when-starting-pagent

- IBM support: **pasearch -t results in message "no policies retrieved"**
  (applies to z/OS Communications Server 1.10, 1.11, 1.12, 1.13, 2.x)
  https://www.ibm.com/support/pages/pasearch-t-results-message-no-policies-retrieved

## Evidence policy

The web references describe documented product behavior. They do not prove the exact cause of this system's failure. The lab therefore records `EZZ8434I` as an unresolved early-initialization failure and defers root-cause attribution until debug/syslog evidence is captured.
