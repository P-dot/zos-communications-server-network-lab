# Rollback Notes - Lab 15

## Runtime change

The only runtime control action in this drill was stopping the FTP service.

## Rollback evidence

The final `NETSTAT CONN,PORT=21` screenshot shows that TCP port 21 was listening again, validating service restoration.

## Permanent rollback

No permanent profile rollback was required because:

- `ADCD.Z111S.TCPPARMS(PROF1)` was not modified.
- No `OBEYFILE` was issued.
- No TCP/IP stack restart was performed.
- No RACF/certificate/security policy was changed.
