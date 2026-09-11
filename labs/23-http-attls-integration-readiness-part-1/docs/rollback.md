# Rollback / safety baseline

Part 1 made no intentional runtime or persistent configuration change, so no Part 1 rollback is required.

For future activation work, preserve the previously validated safe state and rollback path: disable AT-TLS dynamically with `TCPCONFIG NOTTLS` and keep the persistent TCP/IP profile without TTLS until the Policy Agent/policy chain is ready. Exact commands must be revalidated against the active member before execution.
