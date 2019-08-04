create_project memory_slave ./memory_slave -part xc7z045ffg900-2
set_property board_part xilinx.com:zc706:part0:1.4 [current_project]
add_files -norecurse {./srcs/rtl/mem_slave_top_module.v ./srcs/rtl/memory_module_virtual_memory.sv ./srcs/rtl/add_read.v ./srcs/rtl/param.v ./srcs/rtl/data_read_write.v ./srcs/rtl/mem_slave_top_wrapper.sv ./srcs/rtl/add_write.v ./srcs/rtl/data_resp.v}

update_compile_order -fileset sources_1
update_compile_order -fileset sources_1

#xsc ./srcs/c/memory_slave.cpp -o ./srcs/lib/memory_slave.a

ipx::package_project -root_dir ./ -vendor xilinx.com -library user -taxonomy /UserIP
set_property core_revision 2 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property  ip_repo_paths  ./ [current_project]
update_ip_catalog
close_project

