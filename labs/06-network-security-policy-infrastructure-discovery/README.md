# Lab 06 - z/OS Network Security Policy Infrastructure Discovery

## Objective

This lab reviews the presence of z/OS Communications Server network security policy infrastructure artifacts in read-only mode.

The goal is to determine whether the system contains configuration members or started task procedures related to Policy Agent, AT-TLS, IPSec/IKE, IDS, TRMD or SYSLOGD without activating any component or changing TCP/IP configuration.

## Source evidence

The evidence was collected from ISPF Browse views of:

- `ADCD.Z111S.TCPPARMS`
- `ADCD.Z111S.PROCLIB`

The uploaded evidence document showed a TCPPARMS member list and multiple PROCLIB member-list pages. User IDs in screenshots were redacted before publication.

## Safety statement

All activity was read-only.

No TCP/IP profile was edited.
No PROCLIB member was edited.
No Policy Agent, IKED, TRMD or SYSLOGD address space was started.
No AT-TLS, IPSec or IDS policy was activated.
No `VARY TCPIP,,OBEYFILE` command was issued.
No `ipsec` command was used.

## Findings

### TCPPARMS member inventory

The `ADCD.Z111S.TCPPARMS` library showed the following observed members:

| Member | Meaning in this lab |
|---|---|
| `PROFILE` | TCP/IP profile-related member |
| `PROF1` | Active TCP/IP profile reviewed in Lab 04 |
| `PROF2` | Alternate or secondary TCP/IP profile-related member |
| `TCPDATA` | TCP/IP resolver / TCPDATA configuration member |
| `TN3270` | TN3270-related configuration member |

No `PAGENT`, `TTLS`, `IPSEC`, `IDS`, `IKED`, `TRMD` or `SYSLOGD` policy member was observed in the captured `TCPPARMS` member list.

### PROCLIB member inventory

The `ADCD.Z111S.PROCLIB` library showed several network or Communications Server-related started task procedures, including:

| Observed PROC/member | Relevance |
|---|---|
| `FTPD` | FTP server procedure |
| `HTTPD1` | HTTP server procedure |
| `NFS` / `NFSC` | Network File System-related procedures |
| `PORTMAP` | Portmap service |
| `SSHD` | SSH daemon procedure |
| `TCPIP` | TCP/IP stack started task procedure |
| `TN3270` | TN3270 server procedure |
| `VTAM` | VTAM Communications Server procedure |
| `HZSPROC` | Health Checker-related procedure observed in the library |

No `PAGENT`, `IKED`, `TRMD` or `SYSLOGD` procedure was observed in the captured PROCLIB views.

## Interpretation

The system contains the expected baseline TCP/IP and network service infrastructure for the ADCD z/OS lab environment. The observed TCPPARMS and PROCLIB artifacts support the runtime evidence collected in previous labs: TCP/IP, VTAM, TN3270, FTPD, SSHD and HTTPD-related components exist in the environment.

However, the captured libraries did not show obvious policy infrastructure members or procedures for Policy Agent, AT-TLS, IPSec/IKE, IDS, TRMD or SYSLOGD. This aligns with the runtime checks from Lab 03, where `PAGENT`, `IKED`, `TRMD` and `SYSLOGD` were not observed active.

This is an observation based on the captured evidence only. It does not prove that such artifacts are absent from every possible library on the system.

## Security relevance

Policy-based network security features such as AT-TLS, IPSec and IDS typically depend on policy infrastructure and supporting started tasks. A read-only inventory of configuration libraries and PROCLIB members helps separate:

- services that are configured and available,
- services that are running,
- policy infrastructure that exists but is inactive,
- and policy infrastructure that is not visible in the reviewed libraries.

## Conclusion

This lab documents the configuration artifact layer of the z/OS Communications Server security baseline. Together with the previous labs, it completes the first-pass network security discovery sequence:

- Lab 03: runtime network security baseline
- Lab 04: TCP/IP profile security review
- Lab 05: RACF SERVAUTH authorization review
- Lab 06: policy infrastructure and PROCLIB discovery
