create_project video_generator ./video_generator -part xc7z045ffg900-2
set_property board_part xilinx.com:zc706:part0:1.4 [current_project]
add_files -norecurse {./srcs/uhd_sdi_vidgen/multigenHD_horz.v ./srcs/uhd_sdi_vidgen/multigenHD.v ./srcs/uhd_sdi_vidgen/multigenHD_output.v ./srcs/video_generator.sv ./srcs/uhd_sdi_vidgen/multigenHD_vert.v}
update_compile_order -fileset sources_1
update_compile_order -fileset sources_1

ipx::package_project -root_dir ./ -vendor xilinx.com -library user -taxonomy /UserIP
set_property core_revision 2 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property  ip_repo_paths  ./ [current_project]
update_ip_catalog
close_project