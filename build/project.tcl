set projDir "./vivado"
set projName "BITBLASTERRR"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir"]} { file delete -force "$projDir" }
create_project $projName "$projDir" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "./source/alchitry_top.sv" "./source/reset_conditioner.sv" "./source/alu.sv" "./source/pipeline.sv" "./source/button_conditioner.sv" "./source/bin_to_dec.sv" "./source/counter.sv" "./source/decoder.sv" "./source/edge_detector.sv" "./source/simple_dual_port_ram.v" "./source/game_data_path.sv" "./source/game_cu.sv" "./source/game_regfile.sv" "./source/index_reverser.sv" "./source/ws2812b_driver.sv" "./source/data_ram.sv" "./source/ram_mode.sv" "./source/enemy_rom.sv" "./source/bullet_moving_encode.sv" "./source/bullet_encode.sv" "./source/enemy_color_encode.sv" "./source/multi_seven_seg.sv" "./source/seven_seg.sv" "./source/adder.sv" "./source/fa.sv" "./source/rca.sv" "./source/multiplier.sv" "./source/init_rom.sv" "./source/game_end_rom.sv" "./source/lucid_globals.sv" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "./constraint/alchitry.xdc" "./constraint/au_props.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
