create_project SIMD_top ./SIMD_top -part xc7z045ffg900-2
set_property board_part xilinx.com:zc706:part0:1.4 [current_project]

set_property  ip_repo_paths  C:/Users/Acer/Desktop/ADS/ADSL_Project_v_1/IP [current_project]
update_ip_catalog

create_bd_design "SIMD_top"
source create_bd.tcl
validate_bd_design

make_wrapper -files [get_files C:/Users/Acer/Desktop/ADS/ADSL_Project_v_1/SIMD_top/SIMD_top/SIMD_top.srcs/sources_1/bd/SIMD_top/SIMD_top.bd] -top
add_files -norecurse C:/Users/Acer/Desktop/ADS/ADSL_Project_v_1/SIMD_top/SIMD_top/SIMD_top.srcs/sources_1/bd/SIMD_top/hdl/SIMD_top_wrapper.v
set_property -name {xsim.elaborate.xelab.more_options} -value {-sv_lib ..\..\..\..\..\..\IP\memory_slave\srcs\lib\memory_slave.a} -objects [get_filesets sim_1]
