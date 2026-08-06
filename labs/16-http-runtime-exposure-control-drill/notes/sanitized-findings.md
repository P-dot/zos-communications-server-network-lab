# Sanitized Findings - Lab 16

## Runtime state before control

- HTTPD1 was active.
- TCP port 80 was observed in LISTEN state.
- TCP port 443 returned no records in the captured evidence.

## Runtime control

- HTTPD1 was stopped at runtime.
- After the stop action, HTTPD1 was not found.
- TCP port 80 returned no records after HTTPD1 stopped.

## Rollback

- HTTPD1 was restored.
- TCP port 80 returned to LISTEN state.

## Security interpretation

HTTP exposure can be reduced operationally by stopping HTTPD1. This is a runtime-only action unless the TCP/IP profile, AUTOLOG, PROC, or other startup configuration is also changed.

This lab did not modify permanent configuration and did not enable HTTPS.
