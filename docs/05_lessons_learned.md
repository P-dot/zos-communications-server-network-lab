# 05 - Lessons learned

## 1. Separate layers before changing anything

The evidence showed that `TCPIP`, `VTAM`, `TN3270`, and multiple services were active internally. The external failure was therefore not an application-layer failure.

## 2. A listener is not the same as reachability

`TN3270` listening on port 23 proves that z/OS is ready internally. It does not prove that the host can route traffic to z/OS.

## 3. LCS/ETH1 was the real boundary

`LCS1 READY` plus `ETH1 NOT ACTIVE` means the emulated device exists, but the external link is not usable.

## 4. Do not modify the main Wi-Fi adapter without a rollback plan

The safer design is to use a dedicated virtual adapter, a tunnel/TAP-style interface, or a controlled emulator configuration with a backup.

## 5. XCF/Sysplex infrastructure can exist even with one active system

The ADCD environment showed sysplex and WLM couple data sets, but the evidence did not prove a multi-system Parallel Sysplex.

## 6. VIPA comes later

VIPA depends on stable TCP/IP and link connectivity. In this lab `NETSTAT VIPADCFG` showed no VIPA configuration.
