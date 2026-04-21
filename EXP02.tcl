
set ns [new Simulator]

puts "Hello World from NS2"

proc finish {} {
    puts "Simulation Ended"
    exit 0
}

$ns at 1.0 "finish"
$ns run
