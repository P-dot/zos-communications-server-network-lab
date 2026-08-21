# Technical Findings

- TCP/IP PROFILE was successfully opened and processed.
- DEVICE LCS1 and LINK ETH1 were successfully initialized.
- LCS1 reached READY state.
- Hercules exposed the expected LCS devices.
- Hercules successfully opened its TAP backend.
- TN3270 was listening internally.
- End-to-end host-to-z/OS reachability remained unavailable.

Conclusion: the unresolved boundary remains in the emulator/host networking integration layer.
