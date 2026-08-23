# Technical Findings

Policy Agent is installed in z/OS UNIX at `/usr/lpp/tcpip/sbin/pagent`.

IBM installation material for Policy Agent was located, including `EZAPAGSP` and the PAGENT-related section of `EZARACF`.

Read-only RACF inspection established that `BPX.DAEMON` exists, while the PAGENT RACF user, `STARTED PAGENT.*`, and matching `EZB.PAGENT.*` SERVAUTH resources were not found.

No IBM RACF sample statements were executed. PAGENT was not installed as a started procedure and was not started.
