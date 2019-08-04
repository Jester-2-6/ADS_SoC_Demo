
################################################################
# This is a generated script based on design: SIMD_top
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2018.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source SIMD_top_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z045ffg900-2
   set_property BOARD_PART xilinx.com:zc706:part0:1.4 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name SIMD_top

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:user:axi4_to_fifo:1.0\
xilinx.com:ip:fifo_generator:13.2\
xilinx.com:user:fifo_to_axi4:1.0\
xilinx.com:user:mem_slave_top_wrapper:1.0\
xilinx.com:user:video_generator:1.0\
xilinx.com:user:video_monitor:1.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xlconcat:2.1\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: reset_n
proc create_hier_cell_reset_n { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_reset_n() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 Op1
  create_bd_pin -dir O -from 0 -to 0 Res

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create port connections
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins Res] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net video_generator_0_reset [get_bd_pins Op1] [get_bd_pins util_vector_logic_0/Op1]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: frame_rd_write_ctrl
proc create_hier_cell_frame_rd_write_ctrl { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_frame_rd_write_ctrl() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 Op1
  create_bd_pin -dir I -from 0 -to 0 Op2
  create_bd_pin -dir O -from 0 -to 0 Res

  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_1

  # Create port connections
  connect_bd_net -net axi4_to_fifo_0_idle [get_bd_pins Op2] [get_bd_pins util_vector_logic_1/Op2]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins Res] [get_bd_pins util_vector_logic_1/Res]
  connect_bd_net -net video_generator_0_SAV_out [get_bd_pins Op1] [get_bd_pins util_vector_logic_1/Op1]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: fifo_wr_control
proc create_hier_cell_fifo_wr_control { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_fifo_wr_control() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 9 -to 0 In0
  create_bd_pin -dir I -from 9 -to 0 In2
  create_bd_pin -dir I -from 0 -to 0 Op1
  create_bd_pin -dir I -from 0 -to 0 Op2
  create_bd_pin -dir O -from 0 -to 0 Res
  create_bd_pin -dir O -from 31 -to 0 dout

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_0

  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_1

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
   CONFIG.IN0_WIDTH {10} \
   CONFIG.IN1_WIDTH {6} \
   CONFIG.IN2_WIDTH {10} \
   CONFIG.IN3_WIDTH {6} \
   CONFIG.IN4_WIDTH {1} \
   CONFIG.NUM_PORTS {4} \
 ] $xlconcat_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {6} \
 ] $xlconstant_0

  # Create port connections
  connect_bd_net -net Op1_1 [get_bd_pins Op1] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net Op2_1 [get_bd_pins Op2] [get_bd_pins util_vector_logic_0/Op2]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins Res] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins util_vector_logic_1/Res]
  connect_bd_net -net video_generator_0_CbCr_out [get_bd_pins In2] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net video_generator_0_Y_out [get_bd_pins In0] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins dout] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconcat_0/In1] [get_bd_pins xlconcat_0/In3] [get_bd_pins xlconstant_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: fifo_to_axi4_const
proc create_hier_cell_fifo_to_axi4_const { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_fifo_to_axi4_const() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir O -from 31 -to 0 dout
  create_bd_pin -dir O -from 31 -to 0 dout1

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0x00000000} \
   CONFIG.CONST_WIDTH {32} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {8294400} \
   CONFIG.CONST_WIDTH {32} \
 ] $xlconstant_1

  # Create port connections
  connect_bd_net -net xlconstant_0_dout [get_bd_pins dout] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins dout1] [get_bd_pins xlconstant_1/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: fifo_read_ctrl
proc create_hier_cell_fifo_read_ctrl { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_fifo_read_ctrl() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 31 -to 0 Din
  create_bd_pin -dir O -from 9 -to 0 Dout
  create_bd_pin -dir O -from 9 -to 0 Dout1
  create_bd_pin -dir I -from 0 -to 0 Op1
  create_bd_pin -dir I -from 0 -to 0 Op2
  create_bd_pin -dir O -from 0 -to 0 Res

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_0

  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_1

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {9} \
   CONFIG.DOUT_WIDTH {10} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {25} \
   CONFIG.DIN_TO {16} \
   CONFIG.DOUT_WIDTH {10} \
 ] $xlslice_1

  # Create port connections
  connect_bd_net -net Op1_1 [get_bd_pins Op1] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net Op2_1 [get_bd_pins Op2] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net fifo_generator_1_dout [get_bd_pins Din] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins Res] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins util_vector_logic_0/Op2] [get_bd_pins util_vector_logic_1/Res]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins Dout] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins Dout1] [get_bd_pins xlslice_1/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports

  # Create instance: axi4_to_fifo_0, and set properties
  set axi4_to_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:axi4_to_fifo:1.0 axi4_to_fifo_0 ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
 ] $axi_interconnect_0

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Data_Count {false} \
   CONFIG.Data_Count_Width {11} \
   CONFIG.Empty_Threshold_Assert_Value {4} \
   CONFIG.Empty_Threshold_Negate_Value {5} \
   CONFIG.Full_Threshold_Assert_Value {1023} \
   CONFIG.Full_Threshold_Negate_Value {1022} \
   CONFIG.Input_Data_Width {32} \
   CONFIG.Input_Depth {1024} \
   CONFIG.Output_Data_Width {64} \
   CONFIG.Output_Depth {512} \
   CONFIG.Performance_Options {First_Word_Fall_Through} \
   CONFIG.Read_Data_Count {true} \
   CONFIG.Read_Data_Count_Width {10} \
   CONFIG.Use_Extra_Logic {true} \
   CONFIG.Write_Data_Count {true} \
   CONFIG.Write_Data_Count_Width {11} \
 ] $fifo_generator_0

  # Create instance: fifo_generator_1, and set properties
  set fifo_generator_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_1 ]
  set_property -dict [ list \
   CONFIG.Data_Count {false} \
   CONFIG.Data_Count_Width {10} \
   CONFIG.Empty_Threshold_Assert_Value {4} \
   CONFIG.Empty_Threshold_Negate_Value {5} \
   CONFIG.Full_Threshold_Assert_Value {509} \
   CONFIG.Full_Threshold_Negate_Value {508} \
   CONFIG.Input_Data_Width {64} \
   CONFIG.Input_Depth {512} \
   CONFIG.Output_Data_Width {32} \
   CONFIG.Output_Depth {1024} \
   CONFIG.Performance_Options {First_Word_Fall_Through} \
   CONFIG.Read_Data_Count {true} \
   CONFIG.Read_Data_Count_Width {11} \
   CONFIG.Use_Extra_Logic {true} \
   CONFIG.Write_Data_Count {true} \
   CONFIG.Write_Data_Count_Width {10} \
 ] $fifo_generator_1

  # Create instance: fifo_read_ctrl
  create_hier_cell_fifo_read_ctrl [current_bd_instance .] fifo_read_ctrl

  # Create instance: fifo_to_axi4_0, and set properties
  set fifo_to_axi4_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:fifo_to_axi4:1.0 fifo_to_axi4_0 ]

  # Create instance: fifo_to_axi4_const
  create_hier_cell_fifo_to_axi4_const [current_bd_instance .] fifo_to_axi4_const

  # Create instance: fifo_wr_control
  create_hier_cell_fifo_wr_control [current_bd_instance .] fifo_wr_control

  # Create instance: frame_rd_write_ctrl
  create_hier_cell_frame_rd_write_ctrl [current_bd_instance .] frame_rd_write_ctrl

  # Create instance: mem_slave_top_wrapper_0, and set properties
  set mem_slave_top_wrapper_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:mem_slave_top_wrapper:1.0 mem_slave_top_wrapper_0 ]
  set_property -dict [ list \
   CONFIG.ADD_ID_WIDTH {5} \
 ] $mem_slave_top_wrapper_0

  # Create instance: reset_n
  create_hier_cell_reset_n [current_bd_instance .] reset_n

  # Create instance: video_generator_0, and set properties
  set video_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:video_generator:1.0 video_generator_0 ]

  # Create instance: video_monitor_0, and set properties
  set video_monitor_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:video_monitor:1.0 video_monitor_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi4_to_fifo_0_axi [get_bd_intf_pins axi4_to_fifo_0/axi] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net axi4_to_fifo_0_fifo_wr [get_bd_intf_pins axi4_to_fifo_0/fifo_wr] [get_bd_intf_pins fifo_generator_1/FIFO_WRITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins mem_slave_top_wrapper_0/interface_aximm]
  connect_bd_intf_net -intf_net fifo_to_axi4_0_axi [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins fifo_to_axi4_0/axi]
  connect_bd_intf_net -intf_net fifo_to_axi4_0_fifo_rd [get_bd_intf_pins fifo_generator_0/FIFO_READ] [get_bd_intf_pins fifo_to_axi4_0/fifo_rd]

  # Create port connections
  connect_bd_net -net axi4_to_fifo_0_idle [get_bd_pins axi4_to_fifo_0/idle] [get_bd_pins frame_rd_write_ctrl/Op2]
  connect_bd_net -net fifo_generator_0_full [get_bd_pins fifo_generator_0/full] [get_bd_pins fifo_wr_control/Op1]
  connect_bd_net -net fifo_generator_0_rd_data_count [get_bd_pins fifo_generator_0/rd_data_count] [get_bd_pins fifo_to_axi4_0/fifo_data_count_i]
  connect_bd_net -net fifo_generator_1_dout [get_bd_pins fifo_generator_1/dout] [get_bd_pins fifo_read_ctrl/Din]
  connect_bd_net -net fifo_generator_1_empty [get_bd_pins fifo_generator_1/empty] [get_bd_pins fifo_read_ctrl/Op2]
  connect_bd_net -net fifo_generator_1_wr_data_count [get_bd_pins axi4_to_fifo_0/fifo_data_count_i] [get_bd_pins fifo_generator_1/wr_data_count]
  connect_bd_net -net fifo_read_ctrl_Res [get_bd_pins fifo_generator_1/rd_en] [get_bd_pins fifo_read_ctrl/Res]
  connect_bd_net -net fifo_to_axi4_0_done [get_bd_pins axi4_to_fifo_0/start] [get_bd_pins fifo_to_axi4_0/done] [get_bd_pins video_monitor_0/start]
  connect_bd_net -net fifo_wr_control_Res [get_bd_pins fifo_generator_0/wr_en] [get_bd_pins fifo_wr_control/Res]
  connect_bd_net -net fifo_wr_control_dout [get_bd_pins fifo_generator_0/din] [get_bd_pins fifo_wr_control/dout]
  connect_bd_net -net reset_n_Res [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins reset_n/Res]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins fifo_to_axi4_0/start] [get_bd_pins frame_rd_write_ctrl/Res]
  connect_bd_net -net video_generator_0_CbCr_out [get_bd_pins fifo_wr_control/In2] [get_bd_pins video_generator_0/CbCr_out]
  connect_bd_net -net video_generator_0_SAV_out [get_bd_pins frame_rd_write_ctrl/Op1] [get_bd_pins video_generator_0/SAV_out]
  connect_bd_net -net video_generator_0_Y_out [get_bd_pins fifo_wr_control/In0] [get_bd_pins video_generator_0/Y_out]
  connect_bd_net -net video_generator_0_clk [get_bd_pins axi4_to_fifo_0/clk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins fifo_generator_0/clk] [get_bd_pins fifo_generator_1/clk] [get_bd_pins fifo_to_axi4_0/clk] [get_bd_pins mem_slave_top_wrapper_0/clk] [get_bd_pins video_generator_0/clk] [get_bd_pins video_monitor_0/clk]
  connect_bd_net -net video_generator_0_de_out [get_bd_pins fifo_wr_control/Op2] [get_bd_pins video_generator_0/de_out]
  connect_bd_net -net video_generator_0_reset [get_bd_pins axi4_to_fifo_0/reset] [get_bd_pins fifo_generator_0/srst] [get_bd_pins fifo_generator_1/srst] [get_bd_pins fifo_to_axi4_0/reset] [get_bd_pins mem_slave_top_wrapper_0/reset] [get_bd_pins reset_n/Op1] [get_bd_pins video_generator_0/reset] [get_bd_pins video_monitor_0/reset]
  connect_bd_net -net video_monitor_0_de_out [get_bd_pins fifo_read_ctrl/Op1] [get_bd_pins video_monitor_0/de_out]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins axi4_to_fifo_0/base_addr] [get_bd_pins fifo_to_axi4_0/base_addr] [get_bd_pins fifo_to_axi4_const/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins axi4_to_fifo_0/buff_size] [get_bd_pins axi4_to_fifo_0/read_size] [get_bd_pins fifo_to_axi4_0/buff_size] [get_bd_pins fifo_to_axi4_0/write_size] [get_bd_pins fifo_to_axi4_const/dout1]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins fifo_read_ctrl/Dout] [get_bd_pins video_monitor_0/Y_in]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins fifo_read_ctrl/Dout1] [get_bd_pins video_monitor_0/CbCr_in]

  # Create address segments
  create_bd_addr_seg -range 0x000100000000 -offset 0x00000000 [get_bd_addr_spaces axi4_to_fifo_0/axi] [get_bd_addr_segs mem_slave_top_wrapper_0/interface_aximm/reg0] SEG_mem_slave_top_wrapper_0_reg0
  create_bd_addr_seg -range 0x000100000000 -offset 0x00000000 [get_bd_addr_spaces fifo_to_axi4_0/axi] [get_bd_addr_segs mem_slave_top_wrapper_0/interface_aximm/reg0] SEG_mem_slave_top_wrapper_0_reg0


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


