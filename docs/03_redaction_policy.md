# 03 - Redaction policy

This repository is designed for public portfolio use. Do not publish raw outputs.

## Replace these values before committing

| Sensitive value | Replacement |
|---|---|
| Private IPv4 addresses | `<PRIVATE_IP>`, `<ZOS_IP>`, `<HOST_IP>`, `<HOST_LCS_IP>` |
| Windows usernames | `<WINDOWS_USER>` |
| Hostnames | `<HOSTNAME>` |
| Local directories | `<LOCAL_PATH>` |
| Shared folders | `\<HOSTNAME>\<SHARE>` |
| MAC addresses | `<MAC_ADDRESS>` |
| Raw packet captures | Do not commit |

## Files that must remain private

- Raw screenshots.
- Full `ipconfig /all` output.
- Full routing table if it identifies your LAN.
- Raw PowerShell transcripts.
- Packet captures.
- Local `hercules.cnf` if it contains real IPs, paths, or host details.

## Safe public evidence

- Sanitized screenshots.
- Command names.
- Generic outputs with placeholders.
- Technical interpretation without private addressing.
