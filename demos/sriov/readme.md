# Basic SRIO-V Demo

This demo will create two Clear Containers on two different hosts, connected back to back over ethernet.

This assumes that an SRIOV enabled Clear Containers runtime is installed on both hosts and that runtime is added
 to Docker as "cor."  Similarly, it assumes SRIOV CNM plugin is installed.

```
    host: sriov +1                                           host sriov +2

+------------------------+                                +-----------------------------+
|                        |                                |                             |
|    +---------------+   +                                |        +----------------+   |
|    |               |                              +-----+--------+                |   |
|    |               +------------+                 |  x540+AT     |                |   |
|    |  Clear        | x540+At    +-----------------+  02:10.0     |     Clear      |   |
|    |  Container    | 02:10.0    |                 +-----+--------+     Container  |   |
|    |               +---+--------+                       |        |                |   |
|    |               |   |                                |        |                |   |
|    |               |   |                                |        +----------------+   |
|    +---------------+   |                                |                             |
+------------------------+                                +-----------------------------+
```

In the pc1 directory, there are directions specific to the first host.  The script 01-setup.sh adds pauses such that
you can see step by step the process being carried out to create virtual functions and add a SRIOV network to Docker.

Once executed, you can run ./01-setup.sh from the pc2 directory on the second host, and then ./02-run-iperf.sh in order to
setup an iperf server.

Back on the first host, ./02-run-iperf can be run in order to create a client connected to the server on host 2.
