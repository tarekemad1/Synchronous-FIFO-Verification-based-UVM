# Clean Work Library
if [file exists "work"] {vdel -all}
vlib work

# Compile Design Files
vlog -f rtl.f
vlog -f tb.f

# Optimize Design with Coverage Options

#vopt top -o top_optimized +acc +cover=sbfec+synch_fifo(rtl)
vopt top -o top_optimized +acc +cover=bcfst+synch_fifo

# Simulate the Design with Coverage Enabled
vsim  top_optimized -coverage +UVM_TESTNAME=full_test 

# Prevent the Simulator from Quitting Automatically
set NoQuitOnFinish 1
onbreak {resume}

# Enable Logging
log /* -r

# Run the Simulation
run -all 

# Save Coverage Data to a .ucdb File
coverage attribute -name TESTNAME -value full_test
coverage save full_test.ucdb
vcover report full_test.ucdb  -details > "logs/CoverageReportLog.txt"

# Exit the Simulator
quit
