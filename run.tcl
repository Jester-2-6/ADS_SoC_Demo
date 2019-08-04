cd ./IP/video_generator
source package_ip.tcl
cd ../../

cd ./IP/memory_slave
source package_ip.tcl
cd ../../

cd ./IP/fifo_to_axi4
source package_ip.tcl
cd ../../

cd ./IP/axi4_to_fifo
source package_ip.tcl
cd ../../

cd ./IP/video_monitor
source package_ip.tcl
cd ../../

cd ./SIMD_top
source create_project.tcl