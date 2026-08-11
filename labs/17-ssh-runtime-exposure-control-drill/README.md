# Lab 17 - SSH Runtime Exposure Control Drill

## Objective

Perform a controlled runtime SSH exposure drill on the z/OS Communications Server lab environment.

The lab validates whether the SSH listener on TCP port 22 can be removed from runtime and later restored, without modifying permanent TCP/IP, RACF, certificate, UNIX or PROCLIB configuration.

## Scope

Reviewed component:

- Started task: `SSHD4`
- Service: SSH daemon
- TCP port: `22`

Out of scope:

- Editing `/etc/ssh/sshd_config`
- Modifying RACF users or certificates
- Modifying TCP/IP profile members
- Running `OBEYFILE`
- Permanent service hardening

## Commands used

```text
/D A,SSHD4
/D TCPIP,,NETSTAT,CONN,PORT=22
/P SSHD4
/C SSHD4
/D A,SSHD4
/D TCPIP,,NETSTAT,CONN,PORT=22
/S SSHD,JOBNAME=SSHD4
/D A,SSHD4
/D TCPIP,,NETSTAT,CONN,PORT=22
```

## Findings

### Initial state

`SSHD4` was active and TCP port 22 was listening.

### Controlled stop attempt

A normal STOP attempt was rejected by the system with:

```text
IEE342I STOP REJECTED - TASK BUSY
```

This indicated that the daemon did not stop through the normal operator STOP path at that moment.

### Runtime removal

A CANCEL command was then accepted against `SSHD4`. After that, `SSHD4` was no longer found and `NETSTAT CONN,PORT=22` showed no records.

### Rollback / restoration

The service was restarted with:

```text
/S SSHD,JOBNAME=SSHD4
```

After restart, `SSHD4` was active again and TCP port 22 returned to `LISTEN` state.

## Security relevance

This drill shows runtime control over SSH network exposure. TCP port 22 can be removed from the listening state and later restored. The normal STOP attempt was rejected because the task was busy, so the lab documents the operational behavior and rollback evidence.

## Change control status

No permanent configuration change was applied.

- `sshd_config` was not edited.
- TCP/IP profiles were not edited.
- RACF was not modified.
- Certificates and keyrings were not modified.
- No `OBEYFILE` command was issued.

## Result

Runtime exposure control and rollback were validated for the SSH service.
