# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "ADD_ID_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ADD_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AR_RAND_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "AW_RAND_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BURST_LEN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BURST_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "BURST_TYPE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "B_RAND_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DUMMY_MEM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MAX_BIT_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "MAX_BYTE_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RANDOM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "READ_DATA_DEBUG" -parent ${Page_0}
  ipgui::add_param $IPINST -name "R_RAND_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WRITE_DATA_DEBUG" -parent ${Page_0}
  ipgui::add_param $IPINST -name "W_RAND_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.ADD_ID_WIDTH { PARAM_VALUE.ADD_ID_WIDTH } {
	# Procedure called to update ADD_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADD_ID_WIDTH { PARAM_VALUE.ADD_ID_WIDTH } {
	# Procedure called to validate ADD_ID_WIDTH
	return true
}

proc update_PARAM_VALUE.ADD_WIDTH { PARAM_VALUE.ADD_WIDTH } {
	# Procedure called to update ADD_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADD_WIDTH { PARAM_VALUE.ADD_WIDTH } {
	# Procedure called to validate ADD_WIDTH
	return true
}

proc update_PARAM_VALUE.AR_RAND_WIDTH { PARAM_VALUE.AR_RAND_WIDTH } {
	# Procedure called to update AR_RAND_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AR_RAND_WIDTH { PARAM_VALUE.AR_RAND_WIDTH } {
	# Procedure called to validate AR_RAND_WIDTH
	return true
}

proc update_PARAM_VALUE.AW_RAND_WIDTH { PARAM_VALUE.AW_RAND_WIDTH } {
	# Procedure called to update AW_RAND_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AW_RAND_WIDTH { PARAM_VALUE.AW_RAND_WIDTH } {
	# Procedure called to validate AW_RAND_WIDTH
	return true
}

proc update_PARAM_VALUE.BURST_LEN { PARAM_VALUE.BURST_LEN } {
	# Procedure called to update BURST_LEN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BURST_LEN { PARAM_VALUE.BURST_LEN } {
	# Procedure called to validate BURST_LEN
	return true
}

proc update_PARAM_VALUE.BURST_SIZE { PARAM_VALUE.BURST_SIZE } {
	# Procedure called to update BURST_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BURST_SIZE { PARAM_VALUE.BURST_SIZE } {
	# Procedure called to validate BURST_SIZE
	return true
}

proc update_PARAM_VALUE.BURST_TYPE { PARAM_VALUE.BURST_TYPE } {
	# Procedure called to update BURST_TYPE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BURST_TYPE { PARAM_VALUE.BURST_TYPE } {
	# Procedure called to validate BURST_TYPE
	return true
}

proc update_PARAM_VALUE.B_RAND_WIDTH { PARAM_VALUE.B_RAND_WIDTH } {
	# Procedure called to update B_RAND_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.B_RAND_WIDTH { PARAM_VALUE.B_RAND_WIDTH } {
	# Procedure called to validate B_RAND_WIDTH
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.DUMMY_MEM { PARAM_VALUE.DUMMY_MEM } {
	# Procedure called to update DUMMY_MEM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DUMMY_MEM { PARAM_VALUE.DUMMY_MEM } {
	# Procedure called to validate DUMMY_MEM
	return true
}

proc update_PARAM_VALUE.MAX_BIT_SIZE { PARAM_VALUE.MAX_BIT_SIZE } {
	# Procedure called to update MAX_BIT_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAX_BIT_SIZE { PARAM_VALUE.MAX_BIT_SIZE } {
	# Procedure called to validate MAX_BIT_SIZE
	return true
}

proc update_PARAM_VALUE.MAX_BYTE_SIZE { PARAM_VALUE.MAX_BYTE_SIZE } {
	# Procedure called to update MAX_BYTE_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAX_BYTE_SIZE { PARAM_VALUE.MAX_BYTE_SIZE } {
	# Procedure called to validate MAX_BYTE_SIZE
	return true
}

proc update_PARAM_VALUE.RANDOM { PARAM_VALUE.RANDOM } {
	# Procedure called to update RANDOM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RANDOM { PARAM_VALUE.RANDOM } {
	# Procedure called to validate RANDOM
	return true
}

proc update_PARAM_VALUE.READ_DATA_DEBUG { PARAM_VALUE.READ_DATA_DEBUG } {
	# Procedure called to update READ_DATA_DEBUG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.READ_DATA_DEBUG { PARAM_VALUE.READ_DATA_DEBUG } {
	# Procedure called to validate READ_DATA_DEBUG
	return true
}

proc update_PARAM_VALUE.R_RAND_WIDTH { PARAM_VALUE.R_RAND_WIDTH } {
	# Procedure called to update R_RAND_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.R_RAND_WIDTH { PARAM_VALUE.R_RAND_WIDTH } {
	# Procedure called to validate R_RAND_WIDTH
	return true
}

proc update_PARAM_VALUE.WRITE_DATA_DEBUG { PARAM_VALUE.WRITE_DATA_DEBUG } {
	# Procedure called to update WRITE_DATA_DEBUG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WRITE_DATA_DEBUG { PARAM_VALUE.WRITE_DATA_DEBUG } {
	# Procedure called to validate WRITE_DATA_DEBUG
	return true
}

proc update_PARAM_VALUE.W_RAND_WIDTH { PARAM_VALUE.W_RAND_WIDTH } {
	# Procedure called to update W_RAND_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.W_RAND_WIDTH { PARAM_VALUE.W_RAND_WIDTH } {
	# Procedure called to validate W_RAND_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.DUMMY_MEM { MODELPARAM_VALUE.DUMMY_MEM PARAM_VALUE.DUMMY_MEM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DUMMY_MEM}] ${MODELPARAM_VALUE.DUMMY_MEM}
}

proc update_MODELPARAM_VALUE.READ_DATA_DEBUG { MODELPARAM_VALUE.READ_DATA_DEBUG PARAM_VALUE.READ_DATA_DEBUG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.READ_DATA_DEBUG}] ${MODELPARAM_VALUE.READ_DATA_DEBUG}
}

proc update_MODELPARAM_VALUE.WRITE_DATA_DEBUG { MODELPARAM_VALUE.WRITE_DATA_DEBUG PARAM_VALUE.WRITE_DATA_DEBUG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WRITE_DATA_DEBUG}] ${MODELPARAM_VALUE.WRITE_DATA_DEBUG}
}

proc update_MODELPARAM_VALUE.RANDOM { MODELPARAM_VALUE.RANDOM PARAM_VALUE.RANDOM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RANDOM}] ${MODELPARAM_VALUE.RANDOM}
}

proc update_MODELPARAM_VALUE.ADD_ID_WIDTH { MODELPARAM_VALUE.ADD_ID_WIDTH PARAM_VALUE.ADD_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADD_ID_WIDTH}] ${MODELPARAM_VALUE.ADD_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.ADD_WIDTH { MODELPARAM_VALUE.ADD_WIDTH PARAM_VALUE.ADD_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADD_WIDTH}] ${MODELPARAM_VALUE.ADD_WIDTH}
}

proc update_MODELPARAM_VALUE.BURST_LEN { MODELPARAM_VALUE.BURST_LEN PARAM_VALUE.BURST_LEN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BURST_LEN}] ${MODELPARAM_VALUE.BURST_LEN}
}

proc update_MODELPARAM_VALUE.BURST_SIZE { MODELPARAM_VALUE.BURST_SIZE PARAM_VALUE.BURST_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BURST_SIZE}] ${MODELPARAM_VALUE.BURST_SIZE}
}

proc update_MODELPARAM_VALUE.DATA_WIDTH { MODELPARAM_VALUE.DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.BURST_TYPE { MODELPARAM_VALUE.BURST_TYPE PARAM_VALUE.BURST_TYPE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BURST_TYPE}] ${MODELPARAM_VALUE.BURST_TYPE}
}

proc update_MODELPARAM_VALUE.MAX_BYTE_SIZE { MODELPARAM_VALUE.MAX_BYTE_SIZE PARAM_VALUE.MAX_BYTE_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MAX_BYTE_SIZE}] ${MODELPARAM_VALUE.MAX_BYTE_SIZE}
}

proc update_MODELPARAM_VALUE.MAX_BIT_SIZE { MODELPARAM_VALUE.MAX_BIT_SIZE PARAM_VALUE.MAX_BIT_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MAX_BIT_SIZE}] ${MODELPARAM_VALUE.MAX_BIT_SIZE}
}

proc update_MODELPARAM_VALUE.AW_RAND_WIDTH { MODELPARAM_VALUE.AW_RAND_WIDTH PARAM_VALUE.AW_RAND_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AW_RAND_WIDTH}] ${MODELPARAM_VALUE.AW_RAND_WIDTH}
}

proc update_MODELPARAM_VALUE.W_RAND_WIDTH { MODELPARAM_VALUE.W_RAND_WIDTH PARAM_VALUE.W_RAND_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.W_RAND_WIDTH}] ${MODELPARAM_VALUE.W_RAND_WIDTH}
}

proc update_MODELPARAM_VALUE.AR_RAND_WIDTH { MODELPARAM_VALUE.AR_RAND_WIDTH PARAM_VALUE.AR_RAND_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AR_RAND_WIDTH}] ${MODELPARAM_VALUE.AR_RAND_WIDTH}
}

proc update_MODELPARAM_VALUE.R_RAND_WIDTH { MODELPARAM_VALUE.R_RAND_WIDTH PARAM_VALUE.R_RAND_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.R_RAND_WIDTH}] ${MODELPARAM_VALUE.R_RAND_WIDTH}
}

proc update_MODELPARAM_VALUE.B_RAND_WIDTH { MODELPARAM_VALUE.B_RAND_WIDTH PARAM_VALUE.B_RAND_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.B_RAND_WIDTH}] ${MODELPARAM_VALUE.B_RAND_WIDTH}
}

