# Rollback notes

The pre-change TCP/IP profile was preserved as:

`ADCD.Z111S.TCPPARMS(PROF1B22)`

The active profile was changed to include `TTLS` in the existing `TCPCONFIG` statement. If rollback is required in a later controlled maintenance step, use `PROF1B22` as the baseline reference rather than reconstructing the previous profile from memory.

No rollback command is executed as part of this checkpoint because the achieved state is the intended lab result.
