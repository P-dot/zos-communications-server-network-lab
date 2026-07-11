# 01 — Sequence from Lab 01

## Lab 01 conclusion

The previous lab established the baseline:

```text
TCPIP   active
VTAM    active
TN3270  active
z/OS services listening internally
VIPA not configured
XCF single-system sysplex infrastructure observed
External network attachment not usable
```

## Lab 02 objective

This lab starts after that baseline. It does **not** try to fix the network attachment. Instead, it moves one layer deeper into configuration and operation:

```text
Where does VTAM read definitions from?
How does a VTAM TRLE relate to OSA/QDIO?
Are policy security components active?
Is Enterprise Extender active from VTAM's point of view?
```

## What makes this lab different

The new evidence is not another port-listening or reachability check. The new evidence is:

- VTAM started task JCL and `VTAMLST` concatenation;
- TRLE / OSA-QDIO resource state;
- security-related address spaces not active;
- direct Enterprise Extender display result.
