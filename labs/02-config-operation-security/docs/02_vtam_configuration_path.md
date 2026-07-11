# 02 — VTAM configuration path from running JCL

## Question

Where does this running VTAM instance read its definitions from?

## Evidence

Screenshot:

```text
evidence/sanitized/01_vtam_started_task_vtamlst_concatenation.png
```

The active VTAM started task JCL shows the `VTAMLST` DD concatenation:

```text
USER.VTAMLST
ADCD.Z111S.VTAMLST
SYS1.VTAMLST
```

## Interpretation

This proves that browsing `SYS1.VTAMLST` alone is not sufficient in this ADCD environment.

VTAM searches the concatenation in order. Therefore the correct method is:

```text
1. inspect the running VTAM started task JCL;
2. find the `VTAMLST` DD;
3. browse the libraries in that concatenation;
4. search for `ATCSTRxx`, `ATCCONxx`, TRLE and major node definitions.
```

## Why this matters

The course material states that VTAM configuration files are located through the `VTAMLST` DD in the VTAM start PROC, and that `ATCSTRxx` and `ATCCONxx` normally contain start options and configuration lists.

## Safety

No member was edited. The JCL was viewed from SDSF output only.
