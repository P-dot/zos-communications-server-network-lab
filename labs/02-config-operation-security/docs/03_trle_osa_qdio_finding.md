# 03 — VTAM TRLE / OSA-QDIO finding

## Question

Does the system expose OSA/QDIO-related VTAM transport infrastructure?

## Command

```text
/D NET,ID=OSATRL1E
```

## Evidence

Screenshot:

```text
evidence/sanitized/02_vtam_trle_osatrl1e_qdio_inactive.png
```

Key fields observed:

```text
NAME = OSATRL1E, TYPE = TRLE
TRL MAJOR NODE = OSATRL1
MPCLEVEL = QDIO
STATUS = NEVACQ
DESIRED STATE = INACT
TYPE = CLOSED
```

## Interpretation

`OSATRL1E` is a VTAM Transport Resource List Entry associated with OSA/QDIO infrastructure.

However, it is not active:

```text
NEVACQ / INACT / CLOSED
```

This is a different finding from Lab 01. Lab 01 focused on the LCS/ETH1 network attachment state. Lab 02 identifies a separate VTAM-defined OSA/QDIO transport resource and proves that it exists but is inactive.

## Conceptual mapping

The course explains that TCP/IP and VTAM definitions can depend on each other:

```text
VTAM defines a transport resource as a TRLE.
TCP/IP defines the IP interface.
TCP/IP can refer to the VTAM TRLE by PORTNAME.
```

## Safety

No TRLE was varied or activated.
