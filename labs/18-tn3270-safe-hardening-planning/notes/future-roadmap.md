# Future TN3270 hardening roadmap

This lab did not activate secure TN3270. Future hardening should be handled in separate controlled labs:

1. Identify or create an appropriate RACF keyring in a controlled lab.
2. Validate certificate ownership and trust chain.
3. Decide between native secure TN3270 configuration and AT-TLS policy-based protection.
4. Test secure access on an alternate port first.
5. Preserve classic port 23 access until the secure path is proven.
6. Prepare rollback before any OBEYFILE or service restart.

No future step should be performed without a tested 3270 access fallback.
