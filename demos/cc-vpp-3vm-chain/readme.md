# Clear Containers: Chain of 3 VMs using VPP L2 Bridge Domain

cc-vpp-3vm-chain contains a couple of scripts to aid in setting up a chain of 3 Clear Containers.

This has an assumption that a particular branch of Clear Containers is installed as well as FDIO's VPP.  In the given example,
runtime "mine" is used, which points to the cc-oci-runtime binary provided from networking/vhost-user-poc branch.

```
+------------------------------+       +----------------------------+    +----------------------------+
|  CC+A                        |       |   CC+B                     |    |                            |
|                              |       |                            |    | CC+C                       |
|                              |       |   running ip+forward       |    |                            |
|                              |       |                            |    |                            |
|                              |       |                            |    |                            |
|                              |       |                            |    |                            |
|                              |       |                            |    |                            |
|                              |       |                            |    |                            |
|                    +-------+ |       | +--------+       +-------+ |    |  +-------+                 |
+--------------------+ eth0  +-+       +-+ eth0   +-------+ eth1  +-+    +--+ eth0  +-----------------+
                     |       |           |        |       |       |         |       |
                     +-------+           +--------+       +--+----+         +----+--+
            192.168.1.10|                       |192.168.1.2 | 192.168.2.2       |  192.168.2.10
                        |                       |            |                   |
                        |  +-----------------+  |            |   +-------------+ |
                        +--+  vpp 1          +--+            +---+  vpp 2      +-+
                           +-----------------+                   +-------------+
                             192.168.1.0/24                       192.168.2.0/24

```

After running setup.sh, the above pictured setup will exist on the host system.  A s

The user can next ping from CC-A to CC-C.  On the host system, you'll be able to verify the interfaces and see
incrementing traffic via ```sudo vppctl show interfaces```

For comparision, the user can also run br-setup.sh, which will create a similar chain, only connected via Linux bridge instead of VPP.

