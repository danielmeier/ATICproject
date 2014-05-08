#include "__cf_model.h"
#ifndef RTW_HEADER_model_h_
#define RTW_HEADER_model_h_
#ifndef model_COMMON_INCLUDES_
#define model_COMMON_INCLUDES_
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include "rtwtypes.h"
#include "builtin_typeid_types.h"
#include "multiword_types.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "rt_logging.h"
#include "dt_info.h"
#include "ext_work.h"
#include "mwmathutil.h"
#include "rt_defines.h"
#include "rt_nonfinite.h"
#endif
#include "model_types.h"
#define MODEL_NAME model
#define NSAMPLE_TIMES (2) 
#define NINPUTS (1)       
#define NOUTPUTS (1)     
#define NBLOCKIO (9) 
#define NUM_ZC_EVENTS (0) 
#ifndef NCSTATES
#define NCSTATES (4)   
#elif NCSTATES != 4
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (NULL)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val)
#endif
typedef struct { real_T c3xpvjgwzg ; real_T lstpivbnie ; real_T gmylz151q5 ;
real_T jc2lh2qlp4 ; real_T fhsiygks0q ; real_T fzmu0kdnev ; real_T kn1mapxcsj
; real_T fic550owwv ; real_T osvbpvca3z ; } B ; typedef struct { struct {
void * LoggedData ; } chhodkdhlx ; struct { void * LoggedData ; } o4fvkcfghm
; struct { void * LoggedData ; } ksgn3dfdr5 ; struct { void * LoggedData ; }
jj5xns4rur ; } DW ; typedef struct { real_T lh1gy2xy2n ; real_T onrh4mo2fu ;
real_T aluldqk5n4 ; real_T lmgjxnsqbm ; } X ; typedef struct { real_T
lh1gy2xy2n ; real_T onrh4mo2fu ; real_T aluldqk5n4 ; real_T lmgjxnsqbm ; }
XDot ; typedef struct { boolean_T lh1gy2xy2n ; boolean_T onrh4mo2fu ;
boolean_T aluldqk5n4 ; boolean_T lmgjxnsqbm ; } XDis ; typedef struct {
real_T lh1gy2xy2n ; real_T onrh4mo2fu ; real_T aluldqk5n4 ; real_T lmgjxnsqbm
; } CStateAbsTol ; typedef struct { real_T nikd0gsili ; } ExtU ; typedef
struct { real_T hkst4zaajn ; } ExtY ; struct P_ { real_T Integrator1_IC ;
real_T Constant_Value ; real_T Integrator_IC ; real_T Gain_Gain ; real_T
Gain1_Gain ; real_T Gain3_Gain ; real_T Gain2_Gain ; real_T
Constant_Value_lu2pbheprv ; real_T Gain_Gain_objsqoebrs ; real_T
Integrator_IC_fnxbl1ltxt ; real_T Gain_Gain_nm01mepo3f ; real_T
Integrator1_IC_b4qmpi3m02 ; real_T Gain1_Gain_oo1m4itwtp ; } ; extern P rtP ;
extern const char * RT_MEMORY_ALLOCATION_ERROR ; extern B rtB ; extern X rtX
; extern DW rtDW ; extern ExtU rtU ; extern ExtY rtY ; extern SimStruct *
const rtS ; extern const int_T gblNumToFiles ; extern const int_T
gblNumFrFiles ; extern const int_T gblNumFrWksBlocks ; extern rtInportTUtable
* gblInportTUtables ; extern const char * gblInportFileName ; extern const
int_T gblNumRootInportBlks ; extern const int_T gblNumModelInputs ; extern
const int_T gblInportDataTypeIdx [ ] ; extern const int_T gblInportDims [ ] ;
extern const int_T gblInportComplex [ ] ; extern const int_T
gblInportInterpoFlag [ ] ; extern const int_T gblInportContinuous [ ] ;
#endif
