create_project fifo_to_axi4 ./fifo_to_axi4 -part xc7z045ffg900-2
set_property board_part xilinx.com:zc706:part0:1.4 [current_project]
add_files -norecurse {./srcs/fifo_to_axi4.sv}
update_compile_order -fileset sources_1
update_compile_order -fileset sources_1

ipx::package_project -root_dir ./ -vendor xilinx.com -library user -taxonomy /UserIP

ipx::add_bus_interface fifo_rd [ipx::current_core]
set_property abstraction_type_vlnv xilinx.com:interface:fifo_read_rtl:1.0 [ipx::get_bus_interfaces fifo_rd -of_objects [ipx::current_core]]
set_property bus_type_vlnv xilinx.com:interface:fifo_read:1.0 [ipx::get_bus_interfaces fifo_rd -of_objects [ipx::current_core]]
set_property interface_mode master [ipx::get_bus_interfaces fifo_rd -of_objects [ipx::current_core]]
ipx::add_port_map RD_DATA [ipx::get_bus_interfaces fifo_rd -of_objects [ipx::current_core]]
set_property physical_name fifo_rd_data_i [ipx::get_port_maps RD_DATA -of_objects [ipx::get_bus_interfaces fifo_rd -of_objects [ipx::current_core]]]
ipx::add_port_map RD_EN [ipx::get_bus_interfaces fifo_rd -of_objects [ipx::current_core]]
set_property physical_name fifo_rd_en_o [ipx::get_port_maps RD_EN -of_objects [ipx::get_bus_interfaces fifo_rd -of_objects [ipx::current_core]]]
ipx::add_port_map EMPTY [ipx::get_bus_interfaces fifo_rd -of_objects [ipx::current_core]]
set_property physical_name fifo_empty_i [ipx::get_port_maps EMPTY -of_objects [ipx::get_bus_interfaces fifo_rd -of_objects [ipx::current_core]]]
ipx::associate_bus_interfaces -busif fifo_rd -clock clk [ipx::current_core]

set_property core_revision 2 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property  ip_repo_paths  ./ [current_project]
update_ip_catalog
close_project