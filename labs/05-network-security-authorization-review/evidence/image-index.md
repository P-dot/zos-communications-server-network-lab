# Lab 05 Evidence Image Index

| File | Evidence |
|---|---|
| `01_search_servauth_ezb_no_entries.png` | General `SEARCH CLASS(SERVAUTH) MASK(EZB)` returned no matching entries. |
| `02_search_servauth_netstat_no_entries.png` | `SEARCH CLASS(SERVAUTH) MASK(EZB.NETSTAT)` returned no matching entries. |
| `03_search_servauth_pagent_no_entries.png` | `SEARCH CLASS(SERVAUTH) MASK(EZB.PAGENT)` returned no matching entries. |
| `04_search_servauth_stackaccess_no_entries.png` | `SEARCH CLASS(SERVAUTH) MASK(EZB.STACKACCESS)` returned no matching entries. |
| `05_search_servauth_portaccess_no_entries.png` | `SEARCH CLASS(SERVAUTH) MASK(PORTACCESS)` returned no matching entries. |

## Note

The `PORTACCESS` evidence should be complemented in a future pass with the exact Communications Server profile mask:

```text
SEARCH CLASS(SERVAUTH) MASK(EZB.PORTACCESS)
```
