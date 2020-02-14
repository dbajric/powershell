## Estimating network latency

Normally, you can measure latency by using the `ping` command, but on some networks, the ICMP protocol is blocked and ping does not work. 
One way to get around this is to use TCP protocol and measure how long it took to establish the connection to a host. Since TCP is underlying protocol used to connect to websites, most networks are not blocking the protocol.

### Usage

`./tcp-connect.ps1 -server 8.8.8.8 -port 53 -iterations 10`