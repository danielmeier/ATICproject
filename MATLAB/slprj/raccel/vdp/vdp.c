#include "__cf_vdp.h"
#include <math.h>
#include "vdp.h"
#include "vdp_private.h"
#include "vdp_dt.h"
const int_T gblNumToFiles = 0 ; const int_T gblNumFrFiles = 0 ; const int_T
gblNumFrWksBlocks = 0 ;
#ifdef RSIM_WITH_SOLVER_MULTITASKING
const boolean_T gbl_raccel_isMultitasking = 1 ;
#else
const boolean_T gbl_raccel_isMultitasking = 0 ;
#endif
const boolean_T gbl_raccel_tid01eq = 0 ; const int_T gbl_raccel_NumST = 1 ;
const char_T * gbl_raccel_Version = "8.5 (R2013b) 08-Aug-2013" ; void
raccel_setup_MMIStateLog ( SimStruct * S ) {
#ifdef UseMMIDataLogging
rt_FillStateSigInfoFromMMI ( ssGetRTWLogInfo ( S ) , & ssGetErrorStatus ( S )
) ;
#endif
} const char * gblSlvrJacPatternFileName =
"slprj\\raccel\\vdp\\vdp_Jpattern.mat" ; const int_T gblNumRootInportBlks = 0
; const int_T gblNumModelInputs = 0 ; extern rtInportTUtable *
gblInportTUtables ; extern const char * gblInportFileName ; const int_T
gblInportDataTypeIdx [ ] = { - 1 } ; const int_T gblInportDims [ ] = { - 1 }
; const int_T gblInportComplex [ ] = { - 1 } ; const int_T
gblInportInterpoFlag [ ] = { - 1 } ; const int_T gblInportContinuous [ ] = {
- 1 } ;
#include "simstruc.h"
#include "fixedpoint.h"
B rtB ; X rtX ; DW rtDW ; ExtY rtY ; static SimStruct model_S ; SimStruct *
const rtS = & model_S ; void MdlInitialize ( void ) { rtX . kvlkue11ai = rtP
. x1_IC ; rtX . irl0u05upf = rtP . x2_IC ; } void MdlStart ( void ) {
MdlInitialize ( ) ; } void MdlOutputs ( int_T tid ) { rtB . or2s1piwky = rtX
. kvlkue11ai ; rtY . glfo2ba35u = rtB . or2s1piwky ; rtB . dmzhdxnmhc = rtX .
irl0u05upf ; rtY . e4wsyelp4n = rtB . dmzhdxnmhc ; rtB . jojgtu40bl = ( 1.0 -
rtB . or2s1piwky * rtB . or2s1piwky ) * rtB . dmzhdxnmhc * rtP . Mu_Gain -
rtB . or2s1piwky ; UNUSED_PARAMETER ( tid ) ; } void MdlUpdate ( int_T tid )
{ UNUSED_PARAMETER ( tid ) ; } void MdlDerivatives ( void ) { { ( ( XDot * )
ssGetdX ( rtS ) ) -> kvlkue11ai = rtB . dmzhdxnmhc ; } { ( ( XDot * ) ssGetdX
( rtS ) ) -> irl0u05upf = rtB . jojgtu40bl ; } } void MdlProjection ( void )
{ } void MdlTerminate ( void ) { } void MdlInitializeSizes ( void ) {
ssSetNumContStates ( rtS , 2 ) ; ssSetNumY ( rtS , 2 ) ; ssSetNumU ( rtS , 0
) ; ssSetDirectFeedThrough ( rtS , 0 ) ; ssSetNumSampleTimes ( rtS , 1 ) ;
ssSetNumBlocks ( rtS , 9 ) ; ssSetNumBlockIO ( rtS , 3 ) ;
ssSetNumBlockParams ( rtS , 3 ) ; } void MdlInitializeSampleTimes ( void ) {
ssSetSampleTime ( rtS , 0 , 0.0 ) ; ssSetOffsetTime ( rtS , 0 , 0.0 ) ; }
void raccel_set_checksum ( SimStruct * rtS ) { ssSetChecksumVal ( rtS , 0 ,
2262851630U ) ; ssSetChecksumVal ( rtS , 1 , 3104152724U ) ; ssSetChecksumVal
( rtS , 2 , 3580160150U ) ; ssSetChecksumVal ( rtS , 3 , 3884046031U ) ; }
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
( ( void * ) & rtB ) ) ; { rtB . or2s1piwky = 0.0 ; rtB . dmzhdxnmhc = 0.0 ;
rtB . jojgtu40bl = 0.0 ; } } { ssSetY ( rtS , & rtY ) ; rtY . glfo2ba35u =
0.0 ; rtY . e4wsyelp4n = 0.0 ; } ssSetDefaultParam ( rtS , ( real_T * ) & rtP
) ; { real_T * x = ( real_T * ) & rtX ; ssSetContStates ( rtS , x ) ; ( void
) memset ( ( void * ) x , 0 , sizeof ( X ) ) ; } { void * dwork = ( void * )
& rtDW ; ssSetRootDWork ( rtS , dwork ) ; ( void ) memset ( dwork , 0 ,
sizeof ( DW ) ) ; } { static DataTypeTransInfo dtInfo ; ( void ) memset ( (
char_T * ) & dtInfo , 0 , sizeof ( dtInfo ) ) ; ssSetModelMappingInfo ( rtS ,
& dtInfo ) ; dtInfo . numDataTypes = 14 ; dtInfo . dataTypeSizes = &
rtDataTypeSizes [ 0 ] ; dtInfo . dataTypeNames = & rtDataTypeNames [ 0 ] ;
dtInfo . B = & rtBTransTable ; dtInfo . P = & rtPTransTable ; } ssSetRootSS (
rtS , rtS ) ; ssSetVersion ( rtS , SIMSTRUCT_VERSION_LEVEL2 ) ;
ssSetModelName ( rtS , "vdp" ) ; ssSetPath ( rtS , "vdp" ) ; ssSetTStart (
rtS , 0.0 ) ; ssSetTFinal ( rtS , 20.0 ) ; { static RTWLogInfo
rt_DataLoggingInfo ; ssSetRTWLogInfo ( rtS , & rt_DataLoggingInfo ) ; } { {
static int_T rt_LoggedStateWidths [ ] = { 1 , 1 } ; static int_T
rt_LoggedStateNumDimensions [ ] = { 1 , 1 } ; static int_T
rt_LoggedStateDimensions [ ] = { 1 , 1 } ; static boolean_T
rt_LoggedStateIsVarDims [ ] = { 0 , 0 } ; static BuiltInDTypeId
rt_LoggedStateDataTypeIds [ ] = { SS_DOUBLE , SS_DOUBLE } ; static int_T
rt_LoggedStateComplexSignals [ ] = { 0 , 0 } ; static const char_T *
rt_LoggedStateLabels [ ] = { "CSTATE" , "CSTATE" } ; static const char_T *
rt_LoggedStateBlockNames [ ] = { "vdp/x1" , "vdp/x2" } ; static const char_T
* rt_LoggedStateNames [ ] = { "" , "" } ; static boolean_T
rt_LoggedStateCrossMdlRef [ ] = { 0 , 0 } ; static RTWLogDataTypeConvert
rt_RTWLogDataTypeConvert [ ] = { { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 ,
1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } }
; static RTWLogSignalInfo rt_LoggedStateSignalInfo = { 2 ,
rt_LoggedStateWidths , rt_LoggedStateNumDimensions , rt_LoggedStateDimensions
, rt_LoggedStateIsVarDims , ( NULL ) , ( NULL ) , rt_LoggedStateDataTypeIds ,
rt_LoggedStateComplexSignals , ( NULL ) , { rt_LoggedStateLabels } , ( NULL )
, ( NULL ) , ( NULL ) , { rt_LoggedStateBlockNames } , { rt_LoggedStateNames
} , rt_LoggedStateCrossMdlRef , rt_RTWLogDataTypeConvert } ; static void *
rt_LoggedStateSignalPtrs [ 2 ] ; rtliSetLogXSignalPtrs ( ssGetRTWLogInfo (
rtS ) , ( LogSignalPtrsType ) rt_LoggedStateSignalPtrs ) ;
rtliSetLogXSignalInfo ( ssGetRTWLogInfo ( rtS ) , & rt_LoggedStateSignalInfo
) ; rt_LoggedStateSignalPtrs [ 0 ] = ( void * ) & rtX . kvlkue11ai ;
rt_LoggedStateSignalPtrs [ 1 ] = ( void * ) & rtX . irl0u05upf ; }
rtliSetLogT ( ssGetRTWLogInfo ( rtS ) , "tout" ) ; rtliSetLogX (
ssGetRTWLogInfo ( rtS ) , "tmp_raccel_xout" ) ; rtliSetLogXFinal (
ssGetRTWLogInfo ( rtS ) , "xFinal" ) ; rtliSetSigLog ( ssGetRTWLogInfo ( rtS
) , "" ) ; rtliSetLogVarNameModifier ( ssGetRTWLogInfo ( rtS ) , "none" ) ;
rtliSetLogFormat ( ssGetRTWLogInfo ( rtS ) , 0 ) ; rtliSetLogMaxRows (
ssGetRTWLogInfo ( rtS ) , 0 ) ; rtliSetLogDecimation ( ssGetRTWLogInfo ( rtS
) , 1 ) ; { static void * rt_LoggedOutputSignalPtrs [ ] = { & rtY .
glfo2ba35u , & rtY . e4wsyelp4n } ; rtliSetLogYSignalPtrs ( ssGetRTWLogInfo (
rtS ) , ( ( LogSignalPtrsType ) rt_LoggedOutputSignalPtrs ) ) ; } { static
int_T rt_LoggedOutputWidths [ ] = { 1 , 1 } ; static int_T
rt_LoggedOutputNumDimensions [ ] = { 1 , 1 } ; static int_T
rt_LoggedOutputDimensions [ ] = { 1 , 1 } ; static boolean_T
rt_LoggedOutputIsVarDims [ ] = { 0 , 0 } ; static void *
rt_LoggedCurrentSignalDimensions [ ] = { ( NULL ) , ( NULL ) } ; static int_T
rt_LoggedCurrentSignalDimensionsSize [ ] = { 4 , 4 } ; static BuiltInDTypeId
rt_LoggedOutputDataTypeIds [ ] = { SS_DOUBLE , SS_DOUBLE } ; static int_T
rt_LoggedOutputComplexSignals [ ] = { 0 , 0 } ; static const char_T *
rt_LoggedOutputLabels_0 [ ] = { "x1" } ; static const char_T *
rt_LoggedOutputBlockNames_0 [ ] = { "vdp/Out1" } ; static const char_T *
rt_LoggedOutputLabels_1 [ ] = { "x2" } ; static const char_T *
rt_LoggedOutputBlockNames_1 [ ] = { "vdp/Out2" } ; static
RTWLogDataTypeConvert rt_RTWLogDataTypeConvert [ ] = { { 0 , SS_DOUBLE ,
SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE , SS_DOUBLE , 0 , 0
, 0 , 1.0 , 0 , 0.0 } } ; static RTWLogSignalInfo rt_LoggedOutputSignalInfo [
] = { { 1 , rt_LoggedOutputWidths , rt_LoggedOutputNumDimensions ,
rt_LoggedOutputDimensions , rt_LoggedOutputIsVarDims ,
rt_LoggedCurrentSignalDimensions , rt_LoggedCurrentSignalDimensionsSize ,
rt_LoggedOutputDataTypeIds , rt_LoggedOutputComplexSignals , ( NULL ) , {
rt_LoggedOutputLabels_0 } , ( NULL ) , ( NULL ) , ( NULL ) , {
rt_LoggedOutputBlockNames_0 } , { ( NULL ) } , ( NULL ) ,
rt_RTWLogDataTypeConvert } , { 1 , rt_LoggedOutputWidths + 1 ,
rt_LoggedOutputNumDimensions + 1 , rt_LoggedOutputDimensions + 1 ,
rt_LoggedOutputIsVarDims + 1 , rt_LoggedCurrentSignalDimensions + 1 ,
rt_LoggedCurrentSignalDimensionsSize + 1 , rt_LoggedOutputDataTypeIds + 1 ,
rt_LoggedOutputComplexSignals + 1 , ( NULL ) , { rt_LoggedOutputLabels_1 } ,
( NULL ) , ( NULL ) , ( NULL ) , { rt_LoggedOutputBlockNames_1 } , { ( NULL )
} , ( NULL ) , rt_RTWLogDataTypeConvert + 1 } } ; rtliSetLogYSignalInfo (
ssGetRTWLogInfo ( rtS ) , rt_LoggedOutputSignalInfo ) ;
rt_LoggedCurrentSignalDimensions [ 0 ] = & rt_LoggedOutputWidths [ 0 ] ;
rt_LoggedCurrentSignalDimensions [ 1 ] = & rt_LoggedOutputWidths [ 1 ] ; }
rtliSetLogY ( ssGetRTWLogInfo ( rtS ) , "tmp_raccel_yout1,tmp_raccel_yout2" )
; } { static struct _ssStatesInfo2 statesInfo2 ; ssSetStatesInfo2 ( rtS , &
statesInfo2 ) ; } { static ssSolverInfo slvrInfo ; static boolean_T
contStatesDisabled [ 2 ] ; static real_T absTol [ 2 ] = { 1.0E-5 , 1.0E-5 } ;
static uint8_T absTolControl [ 2 ] = { 2U , 2U } ; ssSetSolverRelTol ( rtS ,
0.001 ) ; ssSetStepSize ( rtS , 0.0 ) ; ssSetMinStepSize ( rtS , 0.0 ) ;
ssSetMaxNumMinSteps ( rtS , - 1 ) ; ssSetMinStepViolatedError ( rtS , 0 ) ;
ssSetMaxStepSize ( rtS , 0.4 ) ; ssSetSolverMaxOrder ( rtS , - 1 ) ;
ssSetSolverRefineFactor ( rtS , 1 ) ; ssSetOutputTimes ( rtS , ( NULL ) ) ;
ssSetNumOutputTimes ( rtS , 0 ) ; ssSetOutputTimesOnly ( rtS , 0 ) ;
ssSetOutputTimesIndex ( rtS , 0 ) ; ssSetZCCacheNeedsReset ( rtS , 0 ) ;
ssSetDerivCacheNeedsReset ( rtS , 0 ) ; ssSetNumNonContDerivSigInfos ( rtS ,
0 ) ; ssSetNonContDerivSigInfos ( rtS , ( NULL ) ) ; ssSetSolverInfo ( rtS ,
& slvrInfo ) ; ssSetSolverName ( rtS , "ode45" ) ; ssSetVariableStepSolver (
rtS , 1 ) ; ssSetSolverConsistencyChecking ( rtS , 0 ) ;
ssSetSolverAdaptiveZcDetection ( rtS , 0 ) ; ssSetSolverRobustResetMethod (
rtS , 0 ) ; ssSetAbsTolVector ( rtS , absTol ) ; ssSetAbsTolControlVector (
rtS , absTolControl ) ; ssSetSolverAbsTol_Obsolete ( rtS , absTol ) ;
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
ssSetChecksumVal ( rtS , 0 , 2262851630U ) ; ssSetChecksumVal ( rtS , 1 ,
3104152724U ) ; ssSetChecksumVal ( rtS , 2 , 3580160150U ) ; ssSetChecksumVal
( rtS , 3 , 3884046031U ) ; { static const sysRanDType rtAlwaysEnabled =
SUBSYS_RAN_BC_ENABLE ; static RTWExtModeInfo rt_ExtModeInfo ; static const
sysRanDType * systemRan [ 1 ] ; ssSetRTWExtModeInfo ( rtS , & rt_ExtModeInfo
) ; rteiSetSubSystemActiveVectorAddresses ( & rt_ExtModeInfo , systemRan ) ;
systemRan [ 0 ] = & rtAlwaysEnabled ; rteiSetModelMappingInfoPtr (
ssGetRTWExtModeInfo ( rtS ) , & ssGetModelMappingInfo ( rtS ) ) ;
rteiSetChecksumsPtr ( ssGetRTWExtModeInfo ( rtS ) , ssGetChecksums ( rtS ) )
; rteiSetTPtr ( ssGetRTWExtModeInfo ( rtS ) , ssGetTPtr ( rtS ) ) ; } return
rtS ; }
