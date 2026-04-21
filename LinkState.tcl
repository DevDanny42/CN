# Create simulator object
set ns [new Simulator]

# Open trace file
set tracefile [open ls.tr w]
$ns trace-all $tracefile

# Create NAM file
set namfile [open ls.nam w]
$ns namtrace-all $namfile

# Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

# Create links (duplex links with bandwidth and delay)
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 2Mb 20ms DropTail

# Enable Link State Routing (use dynamic routing)
$ns rtproto LS

# Setup UDP agent
set udp [new Agent/UDP]
$ns attach-agent $n0 $udp

# Setup Null agent (receiver)
set null [new Agent/Null]
$ns attach-agent $n3 $null

# Connect agents
$ns connect $udp $null

# Setup CBR traffic
set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 500
$cbr set interval_ 0.05
$cbr attach-agent $udp

# Start and stop traffic
$ns at 1.0 "$cbr start"
$ns at 5.0 "$cbr stop"

# Finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam ls.nam &
    exit 0
}

# End simulation
$ns at 6.0 "finish"

# Run simulation
$ns run
