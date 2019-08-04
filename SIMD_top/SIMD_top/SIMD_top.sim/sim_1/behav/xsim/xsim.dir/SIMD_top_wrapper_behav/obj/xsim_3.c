/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
#include "svdpi.h"
#include <cstring>


#if (defined(_MSC_VER) || defined(__MINGW32__) || defined(__CYGWIN__))
#define DPI_DLLISPEC __declspec(dllimport)
#define DPI_DLLESPEC __declspec(dllexport)
#else
#define DPI_DLLISPEC
#define DPI_DLLESPEC
#endif


extern "C"
{
	DPI_DLLISPEC extern void  DPISetMode(int mode) ;
	DPI_DLLISPEC extern int   DPIGetMode() ; 
	DPI_DLLISPEC extern void  DPIAllocateExportedFunctions(int size) ;
	DPI_DLLISPEC extern void  DPIAddExportedFunction(int index, const char* value) ;
	DPI_DLLISPEC extern void  DPIAllocateSVCallerName(int index, const char* y) ;
	DPI_DLLISPEC extern void  DPISetCallerName(int index, const char* y) ;
	DPI_DLLISPEC extern void  DPISetCallerLine(int index, unsigned int y) ;
	DPI_DLLISPEC extern void  DPISetCallerOffset(int index, int y) ;
	DPI_DLLISPEC extern void  DPIAllocateDPIScopes(int size) ;
	DPI_DLLISPEC extern void  DPISetDPIScopeFunctionName(int index, const char* y) ;
	DPI_DLLISPEC extern void  DPISetDPIScopeHierarchy(int index, const char* y) ;
	DPI_DLLISPEC extern void  DPIRelocateDPIScopeIP(int index, char* IP) ;
	DPI_DLLISPEC extern void  DPIAddDPIScopeAccessibleFunction(int index, unsigned int y) ;
	DPI_DLLISPEC extern void  DPIFlushAll() ;
	DPI_DLLISPEC extern void  DPIVerifyScope() ;
	DPI_DLLISPEC extern char* DPISignalHandle(char* sigHandle, int length) ;
	DPI_DLLISPEC extern char* DPIMalloc(unsigned noOfBytes) ;
	DPI_DLLISPEC extern void  DPITransactionAuto(char* srcValue, unsigned int startIndex, unsigned int endIndex, char* net) ;
	DPI_DLLISPEC extern void  DPIScheduleTransactionBlocking(char* var, char* driver, char* src, unsigned setback, unsigned lenMinusOnne) ;
	DPI_DLLISPEC extern void  DPIMemsetSvToDpi(char* dst, char* src, int numCBytes, int is2state) ;
	DPI_DLLISPEC extern void  DPIMemsetDpiToSv(char* dst, char* src, int numCBytes, int is2state) ;
	DPI_DLLISPEC extern void  DPIMemsetSvLogic1ToDpi(char* dst, char* src) ;
	DPI_DLLISPEC extern void  DPIMemsetDpiToSvLogic1(char* dst, char* src) ;
	DPI_DLLISPEC extern void  DPIMemsetDpiToSvUnpackedLogic(char* dst, char* src, int* numRshift, int* shift) ;
	DPI_DLLISPEC extern void  DPIMemsetDpiToSvUnpackedLogicWithPackedDim(char* dst, char* src, int pckedSz, int* numRshift, int* shift) ;
	DPI_DLLISPEC extern void  DPIMemsetSvToDpiUnpackedLogic(char* dst, char* src, int* numRshift, int* shift) ;
	DPI_DLLISPEC extern void  DPIMemsetSvToDpiUnpackedLogicWithPackedDim(char* dst, char* src, int pckdSz, int* numRshift, int* shift) ;
	DPI_DLLISPEC extern void  DPIMemsetDpiToSvUnpackedBit(char* dst, char* src, int* numRshift, int* shift) ;
	DPI_DLLISPEC extern void  DPIMemsetDpiToSvUnpackedBitWithPackedDim(char* dst, char* src, int pckdSz, int* numRshift, int* shift) ;
	DPI_DLLISPEC extern void  DPIMemsetSvToDpiUnpackedBit(char* dst, char* src, int* numRshift, int* shift) ;
	DPI_DLLISPEC extern void  DPIMemsetSvToDpiUnpackedBitWithPackedDim(char* dst, char* src, int pckdSz, int* numRshift, int* shift) ;
	DPI_DLLISPEC extern void  DPISetFuncName(const char* funcName) ;
	DPI_DLLISPEC extern int   staticScopeCheck(const char* calledFunction) ;
	DPI_DLLISPEC extern void  DPIAllocateSVCallerInfo(int size) ;
	DPI_DLLISPEC extern void* DPICreateContext(int scopeId, char* IP, int callerIdx);
	DPI_DLLISPEC extern void* DPIGetCurrentContext();
	DPI_DLLISPEC extern void  DPISetCurrentContext(void*);
	DPI_DLLISPEC extern void  DPIRemoveContext(void*);
	DPI_DLLISPEC extern int   svGetScopeStaticId();
	DPI_DLLISPEC extern char* svGetScopeIP();
	DPI_DLLISPEC extern unsigned DPIGetUnpackedSizeFromSVOpenArray(svOpenArray*);
	DPI_DLLISPEC extern unsigned DPIGetConstraintSizeFromSVOpenArray(svOpenArray*, int);
	DPI_DLLISPEC extern int   topOffset() ;
	DPI_DLLISPEC extern char* DPIInitializeFunction(char* p, unsigned size, long long offset) ;
	DPI_DLLISPEC extern void  DPIInvokeFunction(char* processPtr, char* SP, void* func, char* IP) ;
	DPI_DLLISPEC extern void  DPIDeleteFunctionInvocation(char* SP) ;
	DPI_DLLISPEC extern void  DPISetTaskScopeId(int scopeId) ;
	DPI_DLLISPEC extern void  DPISetTaskCaller(int index) ;
	DPI_DLLISPEC extern int   DPIGetTaskCaller() ;
	DPI_DLLISPEC extern char* DPIInitializeTask(long long subprogInDPOffset, char* scopePropInIP, unsigned size, char* parentBlock) ;
	DPI_DLLISPEC extern void  DPIInvokeTask(long long subprogInDPOffset, char* SP, void* func, char* IP) ;
	DPI_DLLISPEC extern void  DPIDeleteTaskInvocation(char* SP) ;
	DPI_DLLISPEC extern void* DPICreateTaskContext(int (*wrapper)(char*, char*, char*), char* DP, char* IP, char* SP, size_t stackSz) ;
	DPI_DLLISPEC extern void  DPIRemoveTaskContext(void*) ;
	DPI_DLLISPEC extern void  DPICallCurrentContext() ;
	DPI_DLLISPEC extern void  DPIYieldCurrentContext() ;
	DPI_DLLISPEC extern void* DPIGetCurrentTaskContext() ;
	DPI_DLLISPEC extern int   DPIRunningInNewContext() ;
	DPI_DLLISPEC extern void  DPISetCurrentTaskContext(void* x) ;
}

namespace XILINX_DPI { 

	void dpiInitialize()
	{
		DPIAllocateSVCallerInfo(3) ;
		DPISetCallerName(0, "C:/Users/Acer/Desktop/ADS/ADSL_Project_v_1/SIMD_top/SIMD_top/SIMD_top.srcs/sources_1/bd/SIMD_top/ipshared/718d/srcs/rtl/memory_module_virtual_memory.sv") ;
		DPISetCallerLine(0, 63) ;
		DPISetCallerOffset(0, 0) ;
		DPISetCallerName(1, "C:/Users/Acer/Desktop/ADS/ADSL_Project_v_1/SIMD_top/SIMD_top/SIMD_top.srcs/sources_1/bd/SIMD_top/ipshared/718d/srcs/rtl/memory_module_virtual_memory.sv") ;
		DPISetCallerLine(1, 71) ;
		DPISetCallerOffset(1, 0) ;
		DPISetCallerName(2, "C:/Users/Acer/Desktop/ADS/ADSL_Project_v_1/SIMD_top/SIMD_top/SIMD_top.srcs/sources_1/bd/SIMD_top/ipshared/718d/srcs/rtl/memory_module_virtual_memory.sv") ;
		DPISetCallerLine(2, 80) ;
		DPISetCallerOffset(2, 0) ;
		DPIAllocateDPIScopes(3) ;
		DPISetDPIScopeFunctionName(0, "memory_init") ;
		DPISetDPIScopeHierarchy(0, "SIMD_top_wrapper.SIMD_top_i.mem_slave_top_wrapper_0.inst.mem_slave_top_module.data_wr_rd_block.memory") ;
		DPIRelocateDPIScopeIP(0, (char*)(0x196988)) ;
		DPISetDPIScopeFunctionName(1, "memory_read") ;
		DPISetDPIScopeHierarchy(1, "SIMD_top_wrapper.SIMD_top_i.mem_slave_top_wrapper_0.inst.mem_slave_top_module.data_wr_rd_block.memory") ;
		DPIRelocateDPIScopeIP(1, (char*)(0x196988)) ;
		DPISetDPIScopeFunctionName(2, "memory_write") ;
		DPISetDPIScopeHierarchy(2, "SIMD_top_wrapper.SIMD_top_i.mem_slave_top_wrapper_0.inst.mem_slave_top_module.data_wr_rd_block.memory") ;
		DPIRelocateDPIScopeIP(2, (char*)(0x196988)) ;
	}

}


extern "C" {
	void iki_initialize_dpi()
	{ XILINX_DPI::dpiInitialize() ; } 
}


extern "C" {

	extern char memory_init() ;
	extern char memory_read(int arg0) ;
	extern char memory_write(int arg0, char arg1) ;
}


extern "C" {
	char Dpi_wrapper_memory_init(char *GlobalDP, char *IP, char *SP)
	{
DPISetMode(1) ; // Function chain mode : with or without context 

		    /******* Preserve Context Info *******/ 
		char *ptrToSP  = SP; 
		ptrToSP = ptrToSP + 160; 
		int scopeIdx = *((int*)ptrToSP);
		ptrToSP = (char*)((int*)ptrToSP + 1); 
		int callerIdx = *((int*)ptrToSP);
		void* funcContext = DPICreateContext(scopeIdx, IP, callerIdx);
		(*((void**)(SP + 160))) = funcContext;
		DPISetCurrentContext(*(void**)(SP + 160));
		ptrToSP = (char*)((int*)ptrToSP + 1); 

		    /******* Convert SV types to DPI-C Types *******/ 

		    /******* Create and populate DPI-C types for the arguments *******/ 

		    /******* Done Conversion of SV types to DPI-C Types *******/ 
		    /******* Call the DPI-C function *******/ 
		DPISetFuncName("memory_init");
		DPIFlushAll();
		char result = 0 ;
		result = memory_init();

		    /******* Write result value into the SP *******/ 
		ptrToSP = SP + 312 ; 
		DPIRemoveContext(funcContext);
		DPIFlushAll();
		DPISetFuncName(0);
		*((int*)ptrToSP) = result & 0xff; 
		*((int*)ptrToSP + 1) = 0; 
		/****** Subprogram Debug : Pop the Call Stack entry for this function invocation  ******/
		iki_vlog_function_callstack_update(SP); 
		return result ;
	}
	char Dpi_wrapper_memory_read(char *GlobalDP, char *IP, char *SP)
	{
DPISetMode(1) ; // Function chain mode : with or without context 

		    /******* Preserve Context Info *******/ 
		char *ptrToSP  = SP; 
		ptrToSP = ptrToSP + 160; 
		int scopeIdx = *((int*)ptrToSP);
		ptrToSP = (char*)((int*)ptrToSP + 1); 
		int callerIdx = *((int*)ptrToSP);
		void* funcContext = DPICreateContext(scopeIdx, IP, callerIdx);
		(*((void**)(SP + 160))) = funcContext;
		DPISetCurrentContext(*(void**)(SP + 160));
		ptrToSP = (char*)((int*)ptrToSP + 1); 

		    /******* Convert SV types to DPI-C Types *******/ 

		    /******* Create and populate DPI-C types for the arguments *******/ 

		ptrToSP = SP + 480 ; 
		int cObj0;
		DPIMemsetSvToDpi( (char*)(&cObj0), ptrToSP, 4, 1 );
		ptrToSP = ptrToSP + 8; 

		    /******* Done Conversion of SV types to DPI-C Types *******/ 
		    /******* Call the DPI-C function *******/ 
		DPISetFuncName("memory_read");
		DPIFlushAll();
		char result = 0 ;
		result = memory_read(cObj0);

		    /******* Write result value into the SP *******/ 
		ptrToSP = SP + 312 ; 
		DPIRemoveContext(funcContext);
		DPIFlushAll();
		DPISetFuncName(0);
		*((int*)ptrToSP) = result & 0xff; 
		*((int*)ptrToSP + 1) = 0; 
		/****** Subprogram Debug : Pop the Call Stack entry for this function invocation  ******/
		iki_vlog_function_callstack_update(SP); 
		return result ;
	}
	char Dpi_wrapper_memory_write(char *GlobalDP, char *IP, char *SP)
	{
DPISetMode(1) ; // Function chain mode : with or without context 

		    /******* Preserve Context Info *******/ 
		char *ptrToSP  = SP; 
		ptrToSP = ptrToSP + 160; 
		int scopeIdx = *((int*)ptrToSP);
		ptrToSP = (char*)((int*)ptrToSP + 1); 
		int callerIdx = *((int*)ptrToSP);
		void* funcContext = DPICreateContext(scopeIdx, IP, callerIdx);
		(*((void**)(SP + 160))) = funcContext;
		DPISetCurrentContext(*(void**)(SP + 160));
		ptrToSP = (char*)((int*)ptrToSP + 1); 

		    /******* Convert SV types to DPI-C Types *******/ 

		    /******* Create and populate DPI-C types for the arguments *******/ 

		ptrToSP = SP + 480 ; 
		int cObj0;
		DPIMemsetSvToDpi( (char*)(&cObj0), ptrToSP, 4, 1 );
		ptrToSP = ptrToSP + 8; 

		ptrToSP = SP + 648 ; 
		char cObj1;
		DPIMemsetSvToDpi( (char*)(&cObj1), ptrToSP, 1, 1 );
		ptrToSP = ptrToSP + 8; 

		    /******* Done Conversion of SV types to DPI-C Types *******/ 
		    /******* Call the DPI-C function *******/ 
		DPISetFuncName("memory_write");
		DPIFlushAll();
		char result = 0 ;
		result = memory_write(cObj0, cObj1);

		    /******* Write result value into the SP *******/ 
		ptrToSP = SP + 312 ; 
		DPIRemoveContext(funcContext);
		DPIFlushAll();
		DPISetFuncName(0);
		*((int*)ptrToSP) = result & 0xff; 
		*((int*)ptrToSP + 1) = 0; 
		/****** Subprogram Debug : Pop the Call Stack entry for this function invocation  ******/
		iki_vlog_function_callstack_update(SP); 
		return result ;
	}
}


extern "C" {
}

