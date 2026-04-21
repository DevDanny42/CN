# Create simulator
set ns [new Simulator]

# Enable Distance Vector Routing
$ns rtproto DV

# Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

# Create links (bandwidth, delay, queue)
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 2Mb 20ms DropTail

# Setup UDP agent
set udp [new Agent/UDP]
$ns attach-agent $n0 $udp

# Setup Null agent (receiver)
set null [new Agent/Null]
$ns attach-agent $n3 $null

# Connect agents
$ns connect $udp $null

# Setup traffic (CBR)
set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 500
$cbr set interval_ 0.05
$cbr attach-agent $udp

# Start and stop traffic
$ns at 1.0 "$cbr start"
$ns at 4.0 "$cbr stop"

# Finish procedure
proc finish {} {
    puts "Distance Vector Simulation Done"
    exit 0
}

# Schedule finish
$ns at 5.0 "finish"

# Run simulation
$ns run
