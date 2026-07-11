# 05 — Enterprise Extender runtime check

## Question

Is Enterprise Extender active from VTAM's point of view?

## Command

```text
/D NET,EE
```

## Evidence

Screenshot:

```text
evidence/sanitized/06_enterprise_extender_xca_not_active.png
```

Result:

```text
IST2045I ENTERPRISE EXTENDER XCA MAJOR NODE NOT ACTIVE
```

## Interpretation

VTAM recognized the Enterprise Extender display request, but there was no active Enterprise Extender XCA major node.

Therefore:

```text
Enterprise Extender is not active at runtime in this lab environment.
```

## Relation to Lab 01

Lab 01 checked TCP/IP-side symptoms and socket/listener information. This lab adds the VTAM-side check. The result is more direct for Enterprise Extender because `/D NET,EE` asks VTAM about EE state.

## What this does not prove

The command does not prove that no Enterprise Extender definitions exist anywhere in `VTAMLST`. It proves that no active EE XCA major node was present at runtime.

## Safety

No EE major node was activated.
No VTAM resource state was changed.
