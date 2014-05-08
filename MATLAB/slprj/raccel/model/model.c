#include "__cf_model.h"
#include <math.h>
#include "model.h"
#include "model_private.h"
#include "model_dt.h"
const int_T gblNumToFiles = 0 ; const int_T gblNumFrFiles = 0 ; const int_T
gblNumFrWksBlocks = 0 ;
#ifdef RSIM_WITH_SOLVER_MULTITASKING
const boolean_T gbl_raccel_isMultitasking = 1 ;
#else
const boolean_T gbl_raccel_isMultitasking = 0 ;
#endif
const boolean_T gbl_raccel_tid01eq = 0 ; const int_T gbl_raccel_NumST = 2 ;
const char_T * gbl_raccel_Version = "8.5 (R2013b) 08-Aug-2013" ; void
raccel_setup_MMIStateLog ( SimStruct * S ) {
#ifdef UseMMIDataLogging
rt_FillStateSigInfoFromMMI ( ssGetRTWLogInfo ( S ) , & ssGetErrorStatus ( S )
) ;
#endif
} const char * gblSlvrJacPatternFileName =
"slprj\\raccel\\model\\model_Jpattern.mat" ; const int_T gblNumRootInportBlks
= 1 ; const int_T gblNumModelInputs = 1 ; extern rtInportTUtable *
gblInportTUtables ; extern const char * gblInportFileName ; const int_T
gblInportDataTypeIdx [ ] = { 0 } ; const int_T gblInportDims [ ] = { 1 , 1 }
; const int_T gblInportComplex [ ] = { 0 } ; const int_T gblInportInterpoFlag
[ ] = { 1 } ; const int_T gblInportContinuous [ ] = { 1 } ;
#include "simstruc.h"
#include "fixedpoint.h"
B rtB ; X rtX ; DW rtDW ; ExtU rtU ; ExtY rtY ; static SimStruct model_S ;
SimStruct * const rtS = & model_S ; void MdlInitialize ( void ) { rtX .
lh1gy2xy2n = rtP . Integrator1_IC ; rtX . onrh4mo2fu = rtP . Integrator_IC ;
rtX . aluldqk5n4 = rtP . Integrator_IC_fnxbl1ltxt ; rtX . lmgjxnsqbm = rtP .
Integrator1_IC_b4qmpi3m02 ; } void MdlStart ( void ) { MdlInitialize ( ) ; }
void MdlOutputs ( int_T tid ) { real_T hvttzlxplb ; real_T p0c300l2sv ; if (
gblInportFileName != ( NULL ) ) { int_T currTimeIdx ; int_T i ; if (
gblInportTUtables [ 0 ] . nTimePoints > 0 ) { if ( 1 ) { real_T time =
ssGetTaskTime ( rtS , 0 ) ; int k = 1 ; if ( gblInportTUtables [ 0 ] .
nTimePoints == 1 ) { k = 0 ; } currTimeIdx = rt_getTimeIdx (
gblInportTUtables [ 0 ] . time , time , gblInportTUtables [ 0 ] . nTimePoints
, gblInportTUtables [ 0 ] . currTimeIdx , 1 , 0 ) ; gblInportTUtables [ 0 ] .
currTimeIdx = currTimeIdx ; for ( i = 0 ; i < 1 ; i ++ ) { real_T * realPtr1
= ( real_T * ) gblInportTUtables [ 0 ] . ur + i * gblInportTUtables [ 0 ] .
nTimePoints + currTimeIdx ; real_T * realPtr2 = realPtr1 + 1 * k ; ( void )
rt_Interpolate_Datatype ( realPtr1 , realPtr2 , & rtU . nikd0gsili , time ,
gblInportTUtables [ 0 ] . time [ currTimeIdx ] , gblInportTUtables [ 0 ] .
time [ currTimeIdx + k ] , gblInportTUtables [ 0 ] . uDataType ) ; } } } }
rtB . c3xpvjgwzg = rtX . lh1gy2xy2n ; rtY . hkst4zaajn = rtB . c3xpvjgwzg ;
hvttzlxplb = rtX . onrh4mo2fu ; p0c300l2sv = rtP . Gain_Gain * hvttzlxplb ;
rtB . lstpivbnie = muDoubleScalarSin ( p0c300l2sv - rtP . Constant_Value ) /
muDoubleScalarCos ( p0c300l2sv ) * rtP . Gain1_Gain ; rtB . gmylz151q5 = rtP
. Gain3_Gain * muDoubleScalarSin ( rtB . c3xpvjgwzg ) * rtB . lstpivbnie ; if
( ssIsSampleHit ( rtS , 1 , 0 ) ) { rtB . jc2lh2qlp4 = rtP .
Constant_Value_lu2pbheprv ; } rtB . fhsiygks0q = rtP . Gain2_Gain *
muDoubleScalarCos ( rtB . c3xpvjgwzg ) * rtB . jc2lh2qlp4 ; rtB . fzmu0kdnev
= ( rtB . fhsiygks0q + rtB . gmylz151q5 ) * rtP . Gain_Gain_objsqoebrs ; rtB
. kn1mapxcsj = rtX . aluldqk5n4 ; p0c300l2sv = ( hvttzlxplb - rtU .
nikd0gsili ) * rtP . Gain_Gain_nm01mepo3f ; rtB . fic550owwv = rtX .
lmgjxnsqbm ; rtB . osvbpvca3z = ( 0.0 - p0c300l2sv ) - rtP .
Gain1_Gain_oo1m4itwtp * rtB . fic550owwv ; UNUSED_PARAMETER ( tid ) ; } void
MdlUpdate ( int_T tid ) { UNUSED_PARAMETER ( tid ) ; } void MdlDerivatives (
void ) { { ( ( XDot * ) ssGetdX ( rtS ) ) -> lh1gy2xy2n = rtB . kn1mapxcsj ;
} { ( ( XDot * ) ssGetdX ( rtS ) ) -> onrh4mo2fu = rtB . fic550owwv ; } { ( (
XDot * ) ssGetdX ( rtS ) ) -> aluldqk5n4 = rtB . fzmu0kdnev ; } { ( ( XDot *
) ssGetdX ( rtS ) ) -> lmgjxnsqbm = rtB . osvbpvca3z ; } } void MdlProjection
( void ) { } void MdlTerminate ( void ) { } void MdlInitializeSizes ( void )
{ ssSetNumContStates ( rtS , 4 ) ; ssSetNumY ( rtS , 1 ) ; ssSetNumU ( rtS ,
1 ) ; ssSetDirectFeedThrough ( rtS , 1 ) ; ssSetNumSampleTimes ( rtS , 2 ) ;
ssSetNumBlocks ( rtS , 29 ) ; ssSetNumBlockIO ( rtS , 9 ) ;
ssSetNumBlockParams ( rtS , 13 ) ; } void MdlInitializeSampleTimes ( void ) {
ssSetSampleTime ( rtS , 0 , 0.0 ) ; ssSetSampleTime ( rtS , 1 , 0.0 ) ;
ssSetOffsetTime ( rtS , 0 , 0.0 ) ; ssSetOffsetTime ( rtS , 1 , 1.0 ) ; }
void raccel_set_checksum ( SimStruct * rtS ) { ssSetChecksumVal ( rtS , 0 ,
1558066911U ) ; ssSetChecksumVal ( rtS , 1 , 3475828934U ) ; ssSetChecksumVal
( rtS , 2 , 3969565438U ) ; ssSetChecksumVal ( rtS , 3 , 2112957296U ) ; }
SimStruct * raccel_register_model ( void ) { static struct _ssMdlInfo mdlInfo
; ( void ) memset ( ( char * ) rtS , 0 , sizeof ( SimStruct ) ) ; ( void )
memset ( ( char * ) & mdlInfo , 0 , sizeof ( struct _ssMdlInfo ) ) ;
ssSetMdlInfoPtr ( rtS , & mdlInfo ) ; { static time_T mdlPeriod [
NSAMPLE_TIMES ] ; static time_T mdlOffset [ NSAMPLE_TIMES ] ; static time_T
mdlTaskTimes [ NSAMPLE_TIMES ] ; static int_T mdlTsMap [ NSAMPLE_TIMES ] ;
static int_T mdlSampleHits [ NSAMPLE_TIMES ] ; static boolean_T
mdlTNextWasAdjustedPtr [ NSAMPLE_TIMES ] ; static int_T mdlPerTaskSampleHits
[ NSAMPLE_TIMES * NSAMPLE_TIMES ] ; static time_T mdlTimeOfNextSampleHit [
NSAMPLE_TIMES ] ; { int_T i ; for ( i = 0 ; i < NSAMPLE_TIMES ; i ++ ) {
mdlPeriod [ i ] = 0.0 ; mdlOffset [ i ] = 0.0 ; mdlTaskTimes [ i ] = 0.0 ;
mdlTsMap [ i ] = i ; mdlSampleHits [ i ] = 1 ; } } ssSetSampleTimePtr ( rtS ,
& mdlPeriod [ 0 ] ) ; ssSetOffsetTimePtr ( rtS , & mdlOffset [ 0 ] ) ;
ssSetSampleTimeTaskIDPtr ( rtS , & mdlTsMap [ 0 ] ) ; ssSetTPtr ( rtS , &
mdlTaskTimes [ 0 ] ) ; ssSetSampleHitPtr ( rtS , & mdlSampleHits [ 0 ] ) ;
ssSetTNextWasAdjustedPtr ( rtS , & mdlTNextWasAdjustedPtr [ 0 ] ) ;
ssSetPerTaskSampleHitsPtr ( rtS , & mdlPerTaskSampleHits [ 0 ] ) ;
ssSetTimeOfNextSampleHitPtr ( rtS , & mdlTimeOfNextSampleHit [ 0 ] ) ; }
ssSetSolverMode ( rtS , SOLVER_MODE_SINGLETASKING ) ; { ssSetBlockIO ( rtS ,
( ( void * ) & rtB ) ) ; ( void ) memset ( ( ( void * ) & rtB ) , 0 , sizeof
( B ) ) ; } { ssSetU ( rtS , ( ( void * ) & rtU ) ) ; rtU . nikd0gsili = 0.0
; } { ssSetY ( rtS , & rtY ) ; rtY . hkst4zaajn = 0.0 ; } ssSetDefaultParam (
rtS , ( real_T * ) & rtP ) ; { real_T * x = ( real_T * ) & rtX ;
ssSetContStates ( rtS , x ) ; ( void ) memset ( ( void * ) x , 0 , sizeof ( X
) ) ; } { void * dwork = ( void * ) & rtDW ; ssSetRootDWork ( rtS , dwork ) ;
( void ) memset ( dwork , 0 , sizeof ( DW ) ) ; } { static DataTypeTransInfo
dtInfo ; ( void ) memset ( ( char_T * ) & dtInfo , 0 , sizeof ( dtInfo ) ) ;
ssSetModelMappingInfo ( rtS , & dtInfo ) ; dtInfo . numDataTypes = 14 ;
dtInfo . dataTypeSizes = & rtDataTypeSizes [ 0 ] ; dtInfo . dataTypeNames = &
rtDataTypeNames [ 0 ] ; dtInfo . B = & rtBTransTable ; dtInfo . P = &
rtPTransTable ; } ssSetRootSS ( rtS , rtS ) ; ssSetVersion ( rtS ,
SIMSTRUCT_VERSION_LEVEL2 ) ; ssSetModelName ( rtS , "model" ) ; ssSetPath (
rtS , "model" ) ; ssSetTStart ( rtS , 0.0 ) ; ssSetTFinal ( rtS , 10.0 ) ; {
static RTWLogInfo rt_DataLoggingInfo ; ssSetRTWLogInfo ( rtS , &
rt_DataLoggingInfo ) ; } { { static int_T rt_LoggedStateWidths [ ] = { 1 , 1
, 1 , 1 } ; static int_T rt_LoggedStateNumDimensions [ ] = { 1 , 1 , 1 , 1 }
; static int_T rt_LoggedStateDimensions [ ] = { 1 , 1 , 1 , 1 } ; static
boolean_T rt_LoggedStateIsVarDims [ ] = { 0 , 0 , 0 , 0 } ; static
BuiltInDTypeId rt_LoggedStateDataTypeIds [ ] = { SS_DOUBLE , SS_DOUBLE ,
SS_DOUBLE , SS_DOUBLE } ; static int_T rt_LoggedStateComplexSignals [ ] = { 0
, 0 , 0 , 0 } ; static const char_T * rt_LoggedStateLabels [ ] = { "CSTATE" ,
"CSTATE" , "CSTATE" , "CSTATE" } ; static const char_T *
rt_LoggedStateBlockNames [ ] = { "model/Plant/P_pendulum/Integrator1" ,
"model/Plant/Steering/Integrator" , "model/Plant/P_pendulum/Integrator" ,
"model/Plant/Steering/Integrator1" } ; static const char_T *
rt_LoggedStateNames [ ] = { "rho" , "" , "rho_dot" , "" } ; static boolean_T
rt_LoggedStateCrossMdlRef [ ] = { 0 , 0 , 0 , 0 } ; static
RTWLogDataTypeConvert rt_RTWLogDataTypeConvert [ ] = { { 0 , SS_DOUBLE ,
SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0
, 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 ,
0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } } ; static
RTWLogSignalInfo rt_LoggedStateSignalInfo = { 4 , rt_LoggedStateWidths ,
rt_LoggedStateNumDimensions , rt_LoggedStateDimensions ,
rt_LoggedStateIsVarDims , ( NULL ) , ( NULL ) , rt_LoggedStateDataTypeIds ,
rt_LoggedStateComplexSignals , ( NULL ) , { rt_LoggedStateLabels } , ( NULL )
, ( NULL ) , ( NULL ) , { rt_LoggedStateBlockNames } , { rt_LoggedStateNames
} , rt_LoggedStateCrossMdlRef , rt_RTWLogDataTypeConvert } ; static void *
rt_LoggedStateSignalPtrs [ 4 ] ; rtliSetLogXSignalPtrs ( ssGetRTWLogInfo (
rtS ) , ( LogSignalPtrsType ) rt_LoggedStateSignalPtrs ) ;
rtliSetLogXSignalInfo ( ssGetRTWLogInfo ( rtS ) , & rt_LoggedStateSignalInfo
) ; rt_LoggedStateSignalPtrs [ 0 ] = ( void * ) & rtX . lh1gy2xy2n ;
rt_LoggedStateSignalPtrs [ 1 ] = ( void * ) & rtX . onrh4mo2fu ;
rt_LoggedStateSignalPtrs [ 2 ] = ( void * ) & rtX . aluldqk5n4 ;
rt_LoggedStateSignalPtrs [ 3 ] = ( void * ) & rtX . lmgjxnsqbm ; }
rtliSetLogT ( ssGetRTWLogInfo ( rtS ) , "tout" ) ; rtliSetLogX (
ssGetRTWLogInfo ( rtS ) , "tmp_raccel_xout" ) ; rtliSetLogXFinal (
ssGetRTWLogInfo ( rtS ) , "xFinal" ) ; rtliSetSigLog ( ssGetRTWLogInfo ( rtS
) , "" ) ; rtliSetLogVarNameModifier ( ssGetRTWLogInfo ( rtS ) , "none" ) ;
rtliSetLogFormat ( ssGetRTWLogInfo ( rtS ) , 0 ) ; rtliSetLogMaxRows (
ssGetRTWLogInfo ( rtS ) , 1000 ) ; rtliSetLogDecimation ( ssGetRTWLogInfo (
rtS ) , 1 ) ; { static void * rt_LoggedOutputSignalPtrs [ ] = { & rtY .
hkst4zaajn } ; rtliSetLogYSignalPtrs ( ssGetRTWLogInfo ( rtS ) , ( (
LogSignalPtrsType ) rt_LoggedOutputSignalPtrs ) ) ; } { static int_T
rt_LoggedOutputWidths [ ] = { 1 } ; static int_T rt_LoggedOutputNumDimensions
[ ] = { 1 } ; static int_T rt_LoggedOutputDimensions [ ] = { 1 } ; static
boolean_T rt_LoggedOutputIsVarDims [ ] = { 0 } ; static void *
rt_LoggedCurrentSignalDimensions [ ] = { ( NULL ) } ; static int_T
rt_LoggedCurrentSignalDimensionsSize [ ] = { 4 } ; static BuiltInDTypeId
rt_LoggedOutputDataTypeIds [ ] = { SS_DOUBLE } ; static int_T
rt_LoggedOutputComplexSignals [ ] = { 0 } ; static const char_T *
rt_LoggedOutputLabels [ ] = { "" } ; static const char_T *
rt_LoggedOutputBlockNames [ ] = { "model/rho" } ; static
RTWLogDataTypeConvert rt_RTWLogDataTypeConvert [ ] = { { 0 , SS_DOUBLE ,
SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } } ; static RTWLogSignalInfo
rt_LoggedOutputSignalInfo [ ] = { { 1 , rt_LoggedOutputWidths ,
rt_LoggedOutputNumDimensions , rt_LoggedOutputDimensions ,
rt_LoggedOutputIsVarDims , rt_LoggedCurrentSignalDimensions ,
rt_LoggedCurrentSignalDimensionsSize , rt_LoggedOutputDataTypeIds ,
rt_LoggedOutputComplexSignals , ( NULL ) , { rt_LoggedOutputLabels } , ( NULL
) , ( NULL ) , ( NULL ) , { rt_LoggedOutputBlockNames } , { ( NULL ) } , (
NULL ) , rt_RTWLogDataTypeConvert } } ; rtliSetLogYSignalInfo (
ssGetRTWLogInfo ( rtS ) , rt_LoggedOutputSignalInfo ) ;
rt_LoggedCurrentSignalDimensions [ 0 ] = & rt_LoggedOutputWidths [ 0 ] ; }
rtliSetLogY ( ssGetRTWLogInfo ( rtS ) , "tmp_raccel_yout1" ) ; } { static
struct _ssStatesInfo2 statesInfo2 ; ssSetStatesInfo2 ( rtS , & statesInfo2 )
; } { static ssSolverInfo slvrInfo ; static boolean_T contStatesDisabled [ 4
] ; static real_T absTol [ 4 ] = { 1.0E-5 , 1.0E-5 , 1.0E-5 , 1.0E-5 } ;
static uint8_T absTolControl [ 4 ] = { 2U , 2U , 2U , 2U } ;
ssSetSolverRelTol ( rtS , 0.001 ) ; ssSetStepSize ( rtS , 0.0 ) ;
ssSetMinStepSize ( rtS , 0.0 ) ; ssSetMaxNumMinSteps ( rtS , - 1 ) ;
ssSetMinStepViolatedError ( rtS , 0 ) ; ssSetMaxStepSize ( rtS , 0.2 ) ;
ssSetSolverMaxOrder ( rtS , - 1 ) ; ssSetSolverRefineFactor ( rtS , 1 ) ;
ssSetOutputTimes ( rtS , ( NULL ) ) ; ssSetNumOutputTimes ( rtS , 0 ) ;
ssSetOutputTimesOnly ( rtS , 0 ) ; ssSetOutputTimesIndex ( rtS , 0 ) ;
ssSetZCCacheNeedsReset ( rtS , 0 ) ; ssSetDerivCacheNeedsReset ( rtS , 0 ) ;
ssSetNumNonContDerivSigInfos ( rtS , 0 ) ; ssSetNonContDerivSigInfos ( rtS ,
( NULL ) ) ; ssSetSolverInfo ( rtS , & slvrInfo ) ; ssSetSolverName ( rtS ,
"ode45" ) ; ssSetVariableStepSolver ( rtS , 1 ) ;
ssSetSolverConsistencyChecking ( rtS , 0 ) ; ssSetSolverAdaptiveZcDetection (
rtS , 0 ) ; ssSetSolverRobustResetMethod ( rtS , 0 ) ; ssSetAbsTolVector (
rtS , absTol ) ; ssSetAbsTolControlVector ( rtS , absTolControl ) ;
ssSetSolverAbsTol_Obsolete ( rtS , absTol ) ;
ssSetSolverAbsTolControl_Obsolete ( rtS , absTolControl ) ;
ssSetSolverStateProjection ( rtS , 0 ) ; ssSetSolverMassMatrixType ( rtS , (
ssMatrixType ) 0 ) ; ssSetSolverMassMatrixNzMax ( rtS , 0 ) ;
ssSetModelOutputs ( rtS , MdlOutputs ) ; ssSetModelLogData ( rtS ,
rt_UpdateTXYLogVars ) ; ssSetModelUpdate ( rtS , MdlUpdate ) ;
ssSetModelDerivatives ( rtS , MdlDerivatives ) ;
ssSetSolverMaxConsecutiveMinStep ( rtS , 1 ) ;
ssSetSolverShapePreserveControl ( rtS , 2 ) ; ssSetTNextTid ( rtS , INT_MIN )
; ssSetTNext ( rtS , rtMinusInf ) ; ssSetSolverNeedsReset ( rtS ) ;
ssSetNumNonsampledZCs ( rtS , 0 ) ; ssSetContStateDisabled ( rtS ,
contStatesDisabled ) ; ssSetSolverMaxConsecutiveMinStep ( rtS , 1 ) ; }
ssSetChecksumVal ( rtS , 0 , 1558066911U ) ; ssSetChecksumVal ( rtS , 1 ,
3475828934U ) ; ssSetChecksumVal ( rtS , 2 , 3969565438U ) ; ssSetChecksumVal
( rtS , 3 , 2112957296U ) ; { static const sysRanDType rtAlwaysEnabled =
SUBSYS_RAN_BC_ENABLE ; static RTWExtModeInfo rt_ExtModeInfo ; static const
sysRanDType * systemRan [ 1 ] ; ssSetRTWExtModeInfo ( rtS , & rt_ExtModeInfo
) ; rteiSetSubSystemActiveVectorAddresses ( & rt_ExtModeInfo , systemRan ) ;
systemRan [ 0 ] = & rtAlwaysEnabled ; rteiSetModelMappingInfoPtr (
ssGetRTWExtModeInfo ( rtS ) , & ssGetModelMappingInfo ( rtS ) ) ;
rteiSetChecksumsPtr ( ssGetRTWExtModeInfo ( rtS ) , ssGetChecksums ( rtS ) )
; rteiSetTPtr ( ssGetRTWExtModeInfo ( rtS ) , ssGetTPtr ( rtS ) ) ; } return
rtS ; }
