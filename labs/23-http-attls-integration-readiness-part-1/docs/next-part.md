# Lab 23 - Part 2 planned handoff

1. Confirm `H7USER/LAB33RING` and `LAB33CERT` retained state read-only.
2. Determine the exact z/OS V1R11 System SSL / AT-TLS key-ring reference and authorization requirements.
3. Validate any required SAF/SERVAUTH prerequisites before TTLS activation.
4. Build the minimum HTTP-targeted TTLS policy.
5. Start/validate Policy Agent and policy parsing.
6. Re-enable `TCPCONFIG TTLS` only after prerequisites are valid.
7. Validate TLS traffic and rollback.

Do not use TN3270 as the first AT-TLS target.
