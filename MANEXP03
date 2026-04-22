# Create simulator object
set ns [new Simulator]

# Open NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

# Define finish procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam out.nam &
    exit 0
}

# Create two nodes and a duplex link between them
set n0 [$ns node]
set n1 [$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail

# Create a UDP agent and attach it to node n0
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

# Create a CBR traffic source and attach it to udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

# Create a Null agent and attach it to node n1
set null0 [new Agent/Null]
$ns attach-agent $n1 $null0

# Connect UDP agent to Null agent
$ns connect $udp0 $null0

# Schedule events
$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"
$ns at 5.0 "finish"

# Run simulation
$ns run
