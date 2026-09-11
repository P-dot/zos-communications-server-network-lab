# Evidence Manifest

The `screenshots/` directory contains **41 images** extracted from the cumulative evidence document supplied for Lab 23 Part 2.

The images preserve the chronological troubleshooting record, including:

- RACF `LISTUSER`, `RLIST`, and `RACDCERT` checks;
- `IRR.DIGTCERT.LISTRING` and `IRR.DIGTCERT.GENCERT` investigation;
- FACILITY profile definition/permission updates and RACLIST refresh;
- Policy Agent configuration changes in USS;
- creation/display of the experimental `TCPIP_TTLS.policy`;
- console evidence of `EZZ8431I PAGENT STARTING` followed by `EZZ8434I PAGENT EXITING ABNORMALLY`;
- restoration of the Lab 22 compact `/etc/pagent.conf` form;
- `LISTUSER HTTPD1` failure showing that no RACF USER entry named `HTTPD1` exists;
- diagnostic `PAGENT_LOG_FILE=/tmp/pagent.log` attempt;
- absence of `/tmp/pagent.log` after the failed start;
- `LogLevel 511` diagnostic attempt.

## Handling note

Before publishing this package, visually inspect the screenshots for any host IP addresses, MAC addresses, or other environment-specific identifiers. This lab line intentionally avoids publishing sensitive host/network addressing.
