# 02 - Evidence analysis

## Evidence 1 - `NETSTAT DEVLINKS`: LCS ready, ETH link not active

Screenshot: `evidence/sanitized/01_netstat_devlinks_eth1_not_active.png`

Observed facts:

```text
DEVNAME: LOOPBACK   DEVSTATUS: READY   LNKSTATUS: READY
DEVNAME: LCS1       DEVSTATUS: READY
LNKNAME: ETH1       LNKSTATUS: NOT ACTIVE
DEVTYPE: LCS
```

Interpretation:

- z/OS TCP/IP is alive enough to report devices and links.
- The loopback link is healthy.
- The emulated LCS device exists and is recognized.
- The actual Ethernet link used by z/OS is not active.

Conclusion:

```text
This is not a TN3270 problem. It is a network-attachment problem at LCS/ETH1 level.
```

## Evidence 2 - `NETSTAT CONN`: services listening inside z/OS

Screenshot: `evidence/sanitized/02_netstat_conn_services_listen.png`

Observed listeners include:

```text
FTPD1   port 21   LISTEN
SSHD4   port 22   LISTEN
TN3270  port 23   LISTEN
HTTPD1  port 80   LISTEN
```

Interpretation:

- FTP, SSH, TN3270, and HTTP are visible inside z/OS.
- The service names are not necessarily the same as the started-task names originally guessed.
- `FTPD` and `SSHD` were not found because the active names were `FTPD1` and `SSHD4`.

Conclusion:

```text
The services exist internally. External reachability fails because the link is not active.
```

## Evidence 3 - `NETSTAT CONN,PORT=23`: TN3270 listener

Screenshot: `evidence/sanitized/03_netstat_conn_tn3270_port23.png`

Observed fact:

```text
TN3270  0.0.0.0..23  LISTEN
```

Interpretation:

- TN3270 is listening on the z/OS side.
- A failed connection from Windows does not prove TN3270 is down.
- It proves that the host cannot reach the z/OS stack externally.

## Evidence 4 - Windows connectivity test failed

Screenshot: `evidence/sanitized/04_windows_connectivity_test_redacted.png`

Observed sanitized outcome:

```text
ping <ZOS_IP>                          -> Destination host unreachable
Test-NetConnection <ZOS_IP> -Port 23   -> TcpTestSucceeded: False
```

Interpretation:

- The host cannot reach the z/OS IP.
- Since TN3270 is already listening inside z/OS, the failure is below the application layer.

## Evidence 5 - started-task name mismatch example

Screenshot: `evidence/sanitized/05_display_active_task_not_found_example.png`

Observed fact:

```text
SSHD NOT FOUND
```

Interpretation:

- This does not mean SSH is absent.
- Later `NETSTAT CONN` showed `SSHD4` listening on port 22.
- z/OS service names must be verified by actual listeners, not only guessed started-task names.

## Evidence 6 - XCF sysplex couple data sets

Screenshot: `evidence/sanitized/06_xcf_sysplex_couple_datasets.png`

Observed facts:

```text
SYSPLEX COUPLE DATA SETS
PRIMARY and ALTERNATE couple data sets exist
MAXSYSTEM 8
MAXGROUP  50
MAXMEMBER 123
GRS STAR MODE IS SUPPORTED
```

Interpretation:

- The system has real sysplex couple data set infrastructure.
- The couple data set can support multiple systems, but that does not mean multiple systems are active.

## Evidence 7 - WLM couple data sets

Screenshot: `evidence/sanitized/07_xcf_wlm_couple_datasets.png`

Observed facts:

```text
WLM COUPLE DATA SETS
WLM IN USE BY ALL SYSTEMS
```

Interpretation:

- Workload Manager has sysplex-aware couple data set support.
- In this lab, it is used by the single active system.

## Evidence 8 - XCF groups

Screenshot: `evidence/sanitized/08_xcf_groups_single_system.png`

Observed examples:

```text
SYSXCF
SYSWLM
SYSBPX
SYSJES
SYSIOS01
```

Interpretation:

- Several z/OS components are registered in XCF groups.
- Most groups show one member, consistent with a single-system sysplex lab.

## Evidence 9 - no VIPA configured

Screenshot: `evidence/sanitized/09_netstat_vipadcfg_no_vipa.png`

Observed fact:

```text
NETSTAT VIPADCFG
END OF THE REPORT
```

Interpretation:

- No `VIPADEFINE`, `VIPABACKUP`, `VIPADYNAMIC`, or `VIPADISTRIBUTE` configuration is visible.
- VIPA and Sysplex Distributor are study topics for a later lab, after basic external connectivity is stable.
