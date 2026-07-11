# Course mapping — Configuration, Operation and Security

## Configuration and Operation

The course module explains:

- TCP/IP configuration is primarily stored in the TCP/IP profile.
- The TCP/IP profile location should be found from the TCP/IP started PROC, typically through `//PROFILE DD`.
- TCP/IP operation is observed through `NETSTAT`.
- VTAM configuration is located through `VTAMLST` in the VTAM start PROC.
- VTAM start options and configuration lists are commonly represented by `ATCSTRxx` and `ATCCONxx`.
- VTAM operation is observed through `DISPLAY NET` commands.
- VTAM and TCP/IP may be interdependent through TRLE / PORTNAME definitions.
- Enterprise Extender information can be displayed through `/D NET,EE`.

## Security

The security module explains:

- Policy Agent can process/install policies for disciplines such as AT-TLS, IP Security and IDS.
- AT-TLS provides transparent TLS for TCP applications.
- IPSec protects traffic at the IP layer.
- IDS detects attacks and can take defensive action.
- SAF/SERVAUTH can protect TCP/IP resources.

## Lab 02 mapped findings

| Course concept | Lab 02 evidence |
|---|---|
| `VTAMLST` DD | Found in running VTAM JCL |
| TRLE / OSA-QDIO | `OSATRL1E`, QDIO, inactive |
| TCP/IP HOME | ETH1 identity confirmed with IP redacted |
| Policy Agent | `PAGENT NOT FOUND` |
| IKE/IPSec runtime check | `IKED NOT FOUND` |
| Enterprise Extender | `IST2045I ... XCA MAJOR NODE NOT ACTIVE` |
