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
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_390(char*, char *);
extern void execute_2003(char*, char *);
extern void execute_2004(char*, char *);
extern void execute_2005(char*, char *);
extern void execute_2006(char*, char *);
extern void execute_2007(char*, char *);
extern void execute_395(char*, char *);
extern void execute_396(char*, char *);
extern void execute_397(char*, char *);
extern void execute_398(char*, char *);
extern void execute_479(char*, char *);
extern void execute_480(char*, char *);
extern void execute_481(char*, char *);
extern void execute_482(char*, char *);
extern void execute_483(char*, char *);
extern void execute_484(char*, char *);
extern void execute_485(char*, char *);
extern void execute_486(char*, char *);
extern void execute_487(char*, char *);
extern void execute_488(char*, char *);
extern void execute_489(char*, char *);
extern void execute_490(char*, char *);
extern void execute_491(char*, char *);
extern void execute_492(char*, char *);
extern void execute_493(char*, char *);
extern void execute_494(char*, char *);
extern void execute_575(char*, char *);
extern void execute_576(char*, char *);
extern void execute_577(char*, char *);
extern void execute_578(char*, char *);
extern void execute_579(char*, char *);
extern void execute_580(char*, char *);
extern void execute_581(char*, char *);
extern void execute_582(char*, char *);
extern void execute_583(char*, char *);
extern void execute_584(char*, char *);
extern void execute_585(char*, char *);
extern void execute_586(char*, char *);
extern void execute_587(char*, char *);
extern void execute_588(char*, char *);
extern void execute_589(char*, char *);
extern void execute_590(char*, char *);
extern void execute_751(char*, char *);
extern void execute_752(char*, char *);
extern void execute_753(char*, char *);
extern void execute_754(char*, char *);
extern void execute_755(char*, char *);
extern void execute_756(char*, char *);
extern void execute_757(char*, char *);
extern void execute_758(char*, char *);
extern void execute_759(char*, char *);
extern void execute_760(char*, char *);
extern void execute_761(char*, char *);
extern void execute_762(char*, char *);
extern void execute_763(char*, char *);
extern void execute_764(char*, char *);
extern void execute_765(char*, char *);
extern void execute_766(char*, char *);
extern void execute_767(char*, char *);
extern void execute_768(char*, char *);
extern void execute_769(char*, char *);
extern void execute_770(char*, char *);
extern void execute_771(char*, char *);
extern void execute_772(char*, char *);
extern void execute_773(char*, char *);
extern void execute_774(char*, char *);
extern void execute_775(char*, char *);
extern void execute_776(char*, char *);
extern void execute_777(char*, char *);
extern void execute_778(char*, char *);
extern void execute_779(char*, char *);
extern void execute_780(char*, char *);
extern void execute_781(char*, char *);
extern void execute_782(char*, char *);
extern void execute_943(char*, char *);
extern void execute_944(char*, char *);
extern void execute_945(char*, char *);
extern void execute_946(char*, char *);
extern void execute_947(char*, char *);
extern void execute_948(char*, char *);
extern void execute_949(char*, char *);
extern void execute_950(char*, char *);
extern void execute_951(char*, char *);
extern void execute_952(char*, char *);
extern void execute_953(char*, char *);
extern void execute_954(char*, char *);
extern void execute_955(char*, char *);
extern void execute_956(char*, char *);
extern void execute_957(char*, char *);
extern void execute_958(char*, char *);
extern void execute_959(char*, char *);
extern void execute_960(char*, char *);
extern void execute_961(char*, char *);
extern void execute_962(char*, char *);
extern void execute_963(char*, char *);
extern void execute_964(char*, char *);
extern void execute_965(char*, char *);
extern void execute_966(char*, char *);
extern void execute_967(char*, char *);
extern void execute_968(char*, char *);
extern void execute_969(char*, char *);
extern void execute_970(char*, char *);
extern void execute_971(char*, char *);
extern void execute_972(char*, char *);
extern void execute_973(char*, char *);
extern void execute_974(char*, char *);
extern void execute_975(char*, char *);
extern void execute_976(char*, char *);
extern void execute_977(char*, char *);
extern void execute_978(char*, char *);
extern void execute_979(char*, char *);
extern void execute_980(char*, char *);
extern void execute_981(char*, char *);
extern void execute_1942(char*, char *);
extern void execute_1943(char*, char *);
extern void execute_1944(char*, char *);
extern void execute_1945(char*, char *);
extern void execute_1946(char*, char *);
extern void execute_1947(char*, char *);
extern void execute_1948(char*, char *);
extern void execute_1949(char*, char *);
extern void execute_1950(char*, char *);
extern void execute_1951(char*, char *);
extern void execute_1952(char*, char *);
extern void execute_1953(char*, char *);
extern void execute_1954(char*, char *);
extern void execute_1955(char*, char *);
extern void execute_1956(char*, char *);
extern void execute_1957(char*, char *);
extern void execute_1958(char*, char *);
extern void execute_1959(char*, char *);
extern void execute_1960(char*, char *);
extern void execute_1961(char*, char *);
extern void execute_1962(char*, char *);
extern void execute_1963(char*, char *);
extern void execute_1964(char*, char *);
extern void execute_1965(char*, char *);
extern void execute_1966(char*, char *);
extern void execute_1967(char*, char *);
extern void execute_1968(char*, char *);
extern void execute_1969(char*, char *);
extern void execute_1970(char*, char *);
extern void execute_1971(char*, char *);
extern void execute_1972(char*, char *);
extern void execute_1973(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_1975(char*, char *);
extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_1977(char*, char *);
extern void execute_1979(char*, char *);
extern void execute_1981(char*, char *);
extern void execute_1984(char*, char *);
extern void execute_2001(char*, char *);
extern void execute_399(char*, char *);
extern void execute_400(char*, char *);
extern void execute_401(char*, char *);
extern void execute_402(char*, char *);
extern void execute_403(char*, char *);
extern void execute_982(char*, char *);
extern void execute_983(char*, char *);
extern void execute_984(char*, char *);
extern void execute_985(char*, char *);
extern void execute_392(char*, char *);
extern void execute_393(char*, char *);
extern void execute_394(char*, char *);
extern void execute_2008(char*, char *);
extern void execute_2009(char*, char *);
extern void execute_2010(char*, char *);
extern void execute_2011(char*, char *);
extern void execute_2012(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[171] = {(funcp)execute_390, (funcp)execute_2003, (funcp)execute_2004, (funcp)execute_2005, (funcp)execute_2006, (funcp)execute_2007, (funcp)execute_395, (funcp)execute_396, (funcp)execute_397, (funcp)execute_398, (funcp)execute_479, (funcp)execute_480, (funcp)execute_481, (funcp)execute_482, (funcp)execute_483, (funcp)execute_484, (funcp)execute_485, (funcp)execute_486, (funcp)execute_487, (funcp)execute_488, (funcp)execute_489, (funcp)execute_490, (funcp)execute_491, (funcp)execute_492, (funcp)execute_493, (funcp)execute_494, (funcp)execute_575, (funcp)execute_576, (funcp)execute_577, (funcp)execute_578, (funcp)execute_579, (funcp)execute_580, (funcp)execute_581, (funcp)execute_582, (funcp)execute_583, (funcp)execute_584, (funcp)execute_585, (funcp)execute_586, (funcp)execute_587, (funcp)execute_588, (funcp)execute_589, (funcp)execute_590, (funcp)execute_751, (funcp)execute_752, (funcp)execute_753, (funcp)execute_754, (funcp)execute_755, (funcp)execute_756, (funcp)execute_757, (funcp)execute_758, (funcp)execute_759, (funcp)execute_760, (funcp)execute_761, (funcp)execute_762, (funcp)execute_763, (funcp)execute_764, (funcp)execute_765, (funcp)execute_766, (funcp)execute_767, (funcp)execute_768, (funcp)execute_769, (funcp)execute_770, (funcp)execute_771, (funcp)execute_772, (funcp)execute_773, (funcp)execute_774, (funcp)execute_775, (funcp)execute_776, (funcp)execute_777, (funcp)execute_778, (funcp)execute_779, (funcp)execute_780, (funcp)execute_781, (funcp)execute_782, (funcp)execute_943, (funcp)execute_944, (funcp)execute_945, (funcp)execute_946, (funcp)execute_947, (funcp)execute_948, (funcp)execute_949, (funcp)execute_950, (funcp)execute_951, (funcp)execute_952, (funcp)execute_953, (funcp)execute_954, (funcp)execute_955, (funcp)execute_956, (funcp)execute_957, (funcp)execute_958, (funcp)execute_959, (funcp)execute_960, (funcp)execute_961, (funcp)execute_962, (funcp)execute_963, (funcp)execute_964, (funcp)execute_965, (funcp)execute_966, (funcp)execute_967, (funcp)execute_968, (funcp)execute_969, (funcp)execute_970, (funcp)execute_971, (funcp)execute_972, (funcp)execute_973, (funcp)execute_974, (funcp)execute_975, (funcp)execute_976, (funcp)execute_977, (funcp)execute_978, (funcp)execute_979, (funcp)execute_980, (funcp)execute_981, (funcp)execute_1942, (funcp)execute_1943, (funcp)execute_1944, (funcp)execute_1945, (funcp)execute_1946, (funcp)execute_1947, (funcp)execute_1948, (funcp)execute_1949, (funcp)execute_1950, (funcp)execute_1951, (funcp)execute_1952, (funcp)execute_1953, (funcp)execute_1954, (funcp)execute_1955, (funcp)execute_1956, (funcp)execute_1957, (funcp)execute_1958, (funcp)execute_1959, (funcp)execute_1960, (funcp)execute_1961, (funcp)execute_1962, (funcp)execute_1963, (funcp)execute_1964, (funcp)execute_1965, (funcp)execute_1966, (funcp)execute_1967, (funcp)execute_1968, (funcp)execute_1969, (funcp)execute_1970, (funcp)execute_1971, (funcp)execute_1972, (funcp)execute_1973, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_1975, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_1977, (funcp)execute_1979, (funcp)execute_1981, (funcp)execute_1984, (funcp)execute_2001, (funcp)execute_399, (funcp)execute_400, (funcp)execute_401, (funcp)execute_402, (funcp)execute_403, (funcp)execute_982, (funcp)execute_983, (funcp)execute_984, (funcp)execute_985, (funcp)execute_392, (funcp)execute_393, (funcp)execute_394, (funcp)execute_2008, (funcp)execute_2009, (funcp)execute_2010, (funcp)execute_2011, (funcp)execute_2012, (funcp)vlog_transfunc_eventcallback};
const int NumRelocateId= 171;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/tb_behav/xsim.reloc",  (void **)funcTab, 171);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
	iki_schedule_processes_at_time_zero(dp, "xsim.dir/tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
