onerror {quit -f}
vlib work
vlog -work work Debouncer.vo
vlog -work work Debouncer.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Debouncer_vlg_vec_tst
vcd file -direction Debouncer.msim.vcd
vcd add -internal Debouncer_vlg_vec_tst/*
vcd add -internal Debouncer_vlg_vec_tst/i1/*
add wave /*
run -all
