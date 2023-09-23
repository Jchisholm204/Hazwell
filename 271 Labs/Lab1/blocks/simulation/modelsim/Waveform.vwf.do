vlog -work work C:/Users/Jacob/Documents/GitHub/Hazwell/271 Labs/Lab1/blocks/simulation/modelsim/Waveform.vwf.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Debouncer_vlg_vec_tst
onerror {resume}
add wave {Debouncer_vlg_vec_tst/i1/button}
add wave {Debouncer_vlg_vec_tst/i1/button_out}
add wave {Debouncer_vlg_vec_tst/i1/clock}
run -all
