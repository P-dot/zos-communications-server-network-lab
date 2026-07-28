# Commands used

All commands were executed in read-only mode.

## OMVS identity

```sh
pwd
whoami
uname -a
```

## SSH configuration

```sh
ls -l /etc/ssh
ls -l /etc/ssh/sshd_config
grep -i Port /etc/ssh/sshd_config
grep -i Protocol /etc/ssh/sshd_config
grep -i PermitRootLogin /etc/ssh/sshd_config
grep -i PasswordAuthentication /etc/ssh/sshd_config
grep -i PubkeyAuthentication /etc/ssh/sshd_config
grep -i HostKey /etc/ssh/sshd_config
grep -i Subsystem /etc/ssh/sshd_config
grep -i Ciphers /etc/ssh/sshd_config
```

## Syslog

```sh
ls -lh /etc/syslog.conf
cat /etc/syslog.conf
```

Note: the captured `ls -lh` output shows an option issue in this environment. The `cat /etc/syslog.conf` check showed that `/etc/syslog.conf` was not found.

## HTTP configuration search

```sh
ls -l /etc | grep -i http
find /etc -name "*http*" -o -name "*HTTP*" 2>/dev/null
```

## Resolver and host files

```sh
ls -l /etc/resolv.conf
ls -l /etc/hosts
cat /etc/hosts
```

## UNIX process checks

```sh
ps -ef | grep -i ssh
ps -ef | grep -i http
ps -ef | grep -i ftp
ps -ef | grep -i syslog
```
