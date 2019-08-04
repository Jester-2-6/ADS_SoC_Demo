# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AXI_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FIFO_DATA_COUNT_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FIFO_DEPTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FIFO_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "LOG2_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "LOG2_AXI_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MAX_BURST_COUNT" -parent ${Page_0}


}

proc update_PARAM_VALUE.AXI_ADDR_WIDTH { PARAM_VALUE.AXI_ADDR_WIDTH } {
	# Procedure called to update AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_ADDR_WIDTH { PARAM_VALUE.AXI_ADDR_WIDTH } {
	# Procedure called to validate AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_WIDTH { PARAM_VALUE.AXI_WIDTH } {
	# Procedure called to update AXI_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_WIDTH { PARAM_VALUE.AXI_WIDTH } {
	# Procedure called to validate AXI_WIDTH
	return true
}

proc update_PARAM_VALUE.FIFO_DATA_COUNT_WIDTH { PARAM_VALUE.FIFO_DATA_COUNT_WIDTH } {
	# Procedure called to update FIFO_DATA_COUNT_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FIFO_DATA_COUNT_WIDTH { PARAM_VALUE.FIFO_DATA_COUNT_WIDTH } {
	# Procedure called to validate FIFO_DATA_COUNT_WIDTH
	return true
}

proc update_PARAM_VALUE.FIFO_DEPTH { PARAM_VALUE.FIFO_DEPTH } {
	# Procedure called to update FIFO_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FIFO_DEPTH { PARAM_VALUE.FIFO_DEPTH } {
	# Procedure called to validate FIFO_DEPTH
	return true
}

proc update_PARAM_VALUE.FIFO_WIDTH { PARAM_VALUE.FIFO_WIDTH } {
	# Procedure called to update FIFO_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FIFO_WIDTH { PARAM_VALUE.FIFO_WIDTH } {
	# Procedure called to validate FIFO_WIDTH
	return true
}

proc update_PARAM_VALUE.LOG2_AXI_ADDR_WIDTH { PARAM_VALUE.LOG2_AXI_ADDR_WIDTH } {
	# Procedure called to update LOG2_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LOG2_AXI_ADDR_WIDTH { PARAM_VALUE.LOG2_AXI_ADDR_WIDTH } {
	# Procedure called to validate LOG2_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.LOG2_AXI_WIDTH { PARAM_VALUE.LOG2_AXI_WIDTH } {
	# Procedure called to update LOG2_AXI_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LOG2_AXI_WIDTH { PARAM_VALUE.LOG2_AXI_WIDTH } {
	# Procedure called to validate LOG2_AXI_WIDTH
	return true
}

proc update_PARAM_VALUE.MAX_BURST_COUNT { PARAM_VALUE.MAX_BURST_COUNT } {
	# Procedure called to update MAX_BURST_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAX_BURST_COUNT { PARAM_VALUE.MAX_BURST_COUNT } {
	# Procedure called to validate MAX_BURST_COUNT
	return true
}


proc update_MODELPARAM_VALUE.LOG2_AXI_WIDTH { MODELPARAM_VALUE.LOG2_AXI_WIDTH PARAM_VALUE.LOG2_AXI_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LOG2_AXI_WIDTH}] ${MODELPARAM_VALUE.LOG2_AXI_WIDTH}
}

proc update_MODELPARAM_VALUE.LOG2_AXI_ADDR_WIDTH { MODELPARAM_VALUE.LOG2_AXI_ADDR_WIDTH PARAM_VALUE.LOG2_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LOG2_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.LOG2_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.MAX_BURST_COUNT { MODELPARAM_VALUE.MAX_BURST_COUNT PARAM_VALUE.MAX_BURST_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MAX_BURST_COUNT}] ${MODELPARAM_VALUE.MAX_BURST_COUNT}
}

proc update_MODELPARAM_VALUE.FIFO_DATA_COUNT_WIDTH { MODELPARAM_VALUE.FIFO_DATA_COUNT_WIDTH PARAM_VALUE.FIFO_DATA_COUNT_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FIFO_DATA_COUNT_WIDTH}] ${MODELPARAM_VALUE.FIFO_DATA_COUNT_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_WIDTH { MODELPARAM_VALUE.AXI_WIDTH PARAM_VALUE.AXI_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_WIDTH}] ${MODELPARAM_VALUE.AXI_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_ADDR_WIDTH { MODELPARAM_VALUE.AXI_ADDR_WIDTH PARAM_VALUE.AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.FIFO_WIDTH { MODELPARAM_VALUE.FIFO_WIDTH PARAM_VALUE.FIFO_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FIFO_WIDTH}] ${MODELPARAM_VALUE.FIFO_WIDTH}
}

proc update_MODELPARAM_VALUE.FIFO_DEPTH { MODELPARAM_VALUE.FIFO_DEPTH PARAM_VALUE.FIFO_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FIFO_DEPTH}] ${MODELPARAM_VALUE.FIFO_DEPTH}
}

