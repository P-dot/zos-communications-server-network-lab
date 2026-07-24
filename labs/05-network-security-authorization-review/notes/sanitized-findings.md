# Sanitized Findings

## Observed results

The reviewed RACF SERVAUTH search commands returned no matching entries for the queried masks:

- `EZB`
- `EZB.NETSTAT`
- `EZB.PAGENT`
- `EZB.STACKACCESS`
- `PORTACCESS`

The repeated RACF message was:

```text
ICH31005I NO ENTRIES MEET SEARCH CRITERIA
```

## Lab conclusion

No explicit SERVAUTH profiles were observed for the reviewed Communications Server network security resource masks in the captured evidence.

## Publication note

No IP addresses, gateways, host routes, or TCP/IP profile contents are exposed in this lab evidence.
