# Sanitized findings

- `SSHD4` was observed active before the drill.
- `NETSTAT CONN,PORT=22` showed the SSH listener in `LISTEN` state.
- A normal STOP command was rejected because the task was busy.
- A CANCEL command was accepted.
- After runtime removal, `SSHD4` was not found and TCP port 22 had no records.
- The service was restarted with `/S SSHD,JOBNAME=SSHD4`.
- After restart, `SSHD4` was active and TCP port 22 was listening again.

No permanent configuration was changed.
