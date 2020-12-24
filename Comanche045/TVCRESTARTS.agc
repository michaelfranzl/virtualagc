### FILE="Main.annotation"
## Copyright:   Public domain.
## Filename:    TVCRESTARTS.agc
## Purpose:     A section of Comanche revision 045.
##              It is part of the reconstructed source code for the
##              second release of the flight software for the Command
##              Module's (CM) Apollo Guidance Computer (AGC) for Apollo 10.
##              The code has been recreated from a copy of Comanche 055. It
##              has been adapted such that the resulting bugger words
##              exactly match those specified for Comanche 45 in NASA drawing
##              2021153D, which gives relatively high confidence that the
##              reconstruction is correct.
## Assembler:   yaYUL
## Contact:     Ron Burkey <info@sandroid.org>.
## Website:     www.ibiblio.org/apollo/index.html
## Mod history: 2020-12-06 MAS  Created from Comanche 44.

## Page 956
# NAME....TVCRESTART PACKAGE, CONSISTING OF REDOTVC, ENABL1, 2, CMDSOUT, PHSCHK2, ETC.
# LOG SECTION...TVCRESTARTS			SUBROUTINE...DAPCSM
# MODIFIED BY SCHLUNDT				21 OCTOBER 1968
#
# FUNCTIONAL DESCRIPTION....
#
#      *RESTART-PROOFS THE TVC DAPS, INCLUDING PITCHDAP, YAWDAP,
#	TVCEXECUTIVE, ROLLDAP, TVCINIT4, TVCDAPON, AND CSM/.M V46 SWTCHOVR.
#
#      *TVC RESTARTS DESERVE SPECIAL CONSIDERATION IN SEVERAL AREAS.
#	RESTART DOWN-TIME IS IMPORTANT BECAUSE OF THE TRANSIENTS INTRODUCED
#	BY THE THRUST VECTOR RETURN TO THE ACTUATOR MECHANICAL NULLS
#	FOLLOWING TVC- AND OPTICS-ERROR-COUNTER-DISENABLES (CHANNEL 12).
#	TVC USES A MIXTURE OF WAITLIST, T5, T6, AND JOB CALLS.  THERE IS
#	FILTER MEMORY (UP TO 6TH ORDER) TO BE PROTECTED IF WILD TRANSIENTS
#	ARE TO BE AVOIDED.  COUNTERS ARE INVOLVED FOR ONE-SHOT
#	CORRECTIONS AND GAIN UPDATES.  THE GIMBAL TRIM ESTIMATORS AND THE
#	BODY AXIS ATTITUDE ERROR INTEGRATORS INVOLVE DIGITAL SUMMATION.
#	DIGITAL DIFFERENTIATORS ARE INVOLVED IN THE BODY AXIS RATE ESTIMA-
#	TIONS AND IN THE OUTPUTTING OF ACTUATOR COMMANDS.  THERE IS AN
#	OFFSET-TRACKER-FILTER TO PROTECT.  ETC., ETC.
#
#      *THOSE QUANTITIES WHICH MUST BE PROTECTED ARE STORED IN TEMPORARY
#	REGISTERS AS THEY ARE COMPUTED, FOR UPDATING THE REAL REGISTERS
#	DURING COPYCYCLES.
#
#      *THE SEVERAL COPYCYCLES ARE EACH PROTECTED BY PHASE POINTS AT THEIR
#	BEGINNING AND AT THEIR TERMINATION.  THE PHASE POINTS ARE SIMPLY
#	..INCR.. INSTRUCTIONS, EITHER ..INCR TVCEXPHS.. FOR COPYCYCLES
#	IN THE TVCEXECUTIVE, OR ..INCR TVCPHASE.. FOR THE PITCH AND YAW
#	COPYCYCLES.  INDEXING ON EACH OF THESE POINTERS THEN PERMITS A
#	RETURN TO THE APPROPRIATE RESTART POINTS.
#
#      *IF A RESTART OCCURS DURING EITHER COPYCYCLE, THAT COPYCYCLE IS
#	COMPLETED.  THEN THE NORMAL TVCINIT4....DAPINIT....PITCHDAP STARTUP
#	SEQUENCE IS CALLED UPON TO GET THINGS GOING AGAIN.
#
#      *TVC-ENABLE AND OPTICS-ERROR-COUNTER ENABLE MUST BE SET ASAP
#	(ALLOWING FOR PROCEDURAL DELAYS).  THEN THE ENGINES ARE COMMANDED
#	TO THE P,YACTOFF TRIM VALUES.  THE DAPS ARE THEN READY TO GO ON THE
#	AIR, WITH THE REGULAR STARTUP SEQUENCE, EITHER AT MRCLEAN FOR A
#	COMPLETE INITIALIZATION OR AT TVCINIT4 FOR A PARTIAL INITIALIZATION
#
#      *FOR RESTARTS PRIOR TO THE SETTING OF THE T5 BITS AT DOTVCON THE
#	PRE40.6 SECTION OF S40.6 TAKES CARE OF RE-ESTABLISHING TRIMS.
#
#      *IF A RESTART OCCURS DURING THE TVCEXEC....TVCEXFIN SEQUENCE THE
#	COMPUTATIONS WILL BE COMPLETED, STARTING AT THE APPROPRIATE RESTART
#	POINT, AFTER THE DAPS ARE READY TO GO ON THE AIR.
#
#      *IF A RESTART OCCURS PRIOR TO TVCINIT4 (TVCPHASE = -1) E.G. DURING
#	THE EARLY DAP INITIALIZATION PHASE, THE DAP STARTUP SEQUENCE IS
#	ENTERED AT MRCLEAN FOR A FULL INITIALIZATION.
#
#      *FOR RESTARTS DURING CSM/LM V46 SWITCH-OVER, TVCPHASE IS SET TO -2.
#	AND THE RESTART LOGIC GOES BACK TO REDO SWITCH-OVER (AFTER THE
#	NORMAL DAP RESTART SEQUENCE IS FOLLOWED).
#
#      *RESTARTS ARE NOT CRITICAL TO THE ROLL DAP PERFORMANCES HENCE THE
#	THE ROLL DAP IS MERELY RESTARTED.
#
#      *RESTARTS DURING A STROKE TEST (STROKER IS NON-ZERO) WILL CAUSE THE
## Page 957
#	STROKE TEST TO BE TERMINATED.  A NEW V68 ENTRY WILL BE REQUIRED
#	TO GET IT GOING AGAIN (NO AUTOMATIC RESTART).
#  
#      *REDOTVC IS REACHED FOLLOWING ANY RESTART WHICH FINDS THE T5 BITS
#	(BITS 15,14 OF FLAGWRD6) SET FOR TVC.  DOTVCON SETS TVCPHASE = -1
# 	AND TVC EXPHS = 0 JUST BEFORE SETTING THESE BITS, JUST BEFORE
#	MAKING THE T5 CALL TO TVCDAPON.  ON A NORMAL SHUTDOWN DOTVCRCS
#	CALLS RCSDAPON, WHICH RESETS THE T5 BITS FOR RCS.
#
# CALLING SEQUENCE....T5, IN PARTICULAR BY ELRSKIP OF FRESH START/RESTART
#
# NORMAL EXIT MODES....RESUME, NOQRSM, POSTJUMP (TO TVCINIT4 OR MRCLEAN)
#
# ALARM OR ABORT EXIT MODES....NONE
#
# SUBROUTINES CALLED....
#
#      *PCOPY+1, YCOPY+1 (PITCH AND YAW COPYCYCLES)
#      *ENABLE1,2, CMDSOUT (RE-ESTABLISH ACTUATOR TRIMS)
#      *MRCLEAN OR TVCINIT4 (TVCDAP INITIALIZATIONS)
#      *SWICHOVR +5 (CSM/LM V46 SWITCH-OVER)
#      *EXRSTRT AND TVCEXECUTIVE PHASE POINTS 1 THRU 6
#      *WAITLIST, IBNKCALL, POSTJUMP, ISWCALL
#
# OTHER INTERFACES....DOTVCON AND RCSDAPON (T5 BITS), ELRSKIP (CALLS IT)
#
# ERASABLE INITIALIZATION REQUIRED....
#
#      *T5 BITS (1,0), TVCPHASE (-2,-1,0,1,2,3), TVCEXPHS (1 THRU 6)
#      *TVC DAP VARIABLES
#      *OPERATIONS PERFORMED BY REDOTVC ARE BASED ON THE ASSUMPTION THAT
#	THE TVC DAPS ARE RUNNING NORMALLY
#
# OUTPUT....
#
#      *PITCH AND YAW TVC DAP COPYCYCLES COMPLETED IF INTERUPTED
#      *TVCEXECUTIVE COMPLETED IF INTERUPTED
#      *STROKE TEST TERMINATED IF INTERRUPTED
#      *CSM/LM V46 SWITCH-OVER REPEATED IF INTERRUPTED
#      *ACTUATOR TRIMS RE-ESTABLISHED (ACTUATORS BACK ON THE AIR)
#      *TVC DAP INITIALIZATION AS REQUIRED
#      *ALL TVC DAP OPERATIONS ON THE AIR
#
# DEBRIS....TVC TEMPORARIES IN EBANK6

## Page 958

		BANK	16
		SETLOC	DAPROLL
		BANK
		EBANK=	TVCPHASE
		COUNT*	$$/RSRT
		
REDOTVC		LXCH	BANKRUPT	# TVC RESTART PACKAGE
		EXTEND
		QXCH	QRUPT		# (..TCR.. IN ..FINCOPY..)
		
EXECPHS		CCS	TVCEXPHS	# CHECK TVCEXECUTIVE PHASE
		TCF	+2		#	MUST RESTART TVCEXECUTIVE
		TCF	TVCDAPHS	#	NO NEED TO RESTART TVCEXECUTIVE
		
		CAF	NINE		# 9CS DELAY TO FORCE EXRSTRT TO OCCUR
		TC	WAITLIST	#	BEFORE PITCHDAP, AFTER CMDSOUT
		EBANK=	TVCEXPHS
		2CADR	EXRSTRT

TVCDAPHS	CS	OCT37776	# CHECK BITS 15 AND 1 OF TVCPHASE TO SEE
		MASK	TVCPHASE	#	DAP RESTART LOCATION (-1,1,2,3)
		CCS	A
		TCF	FINCOPY		#	FINISH THE COPYCYCLE FIRST
		TCF	ENABL1		#	JUST PREPARE THE OUTCOUNTERS AND GO
		
		CS	TVCPHASE	# TEST FOR TVCPHASE = -2
		MASK	BIT2		#	(THIS INDICATES RESTART OCCURRED
		EXTEND			#	 DURING CSM/LM V46 SWITCH-OVER)
		BZF	TRIM/CMD	# NO, TVCPHASE = -1, RSTRT WAS IN TVCINIT
		
ENABL1		CAF	BIT8		# TVC ENABLE, FOLLOWED BY 40 MS (MIN) WAIT
		AD	BIT11		#	SET BIT FOR OPTICS-DAC-ENABLE ALSO
		EXTEND			#	(ENABL1 ENTERED FROM TVCDAPHS / FINCOPY)
		WOR	CHAN12
		CAF	TVCADDR		# WAIT, CALLING ENABL2 (BBCON THERE)
		TS	T5LOC
		CAF	TVCADDR +4	#	60 MS (TVCEXADR)
		TS	TIME5
		
		TCF	RESUME
		
ENABL2		LXCH	BANKRUPT	# CONTINUE PREPARATION OF OUTCOUNTERS

		CAF	BIT2		# OPTICS ERROR CNTR ENABLE, 4MS MIN WAIT
		EXTEND
		WOR	CHAN12
## Page 959		
		CAF	TVCADDR +2	# WAIT, CALLING CMDSOUT (BBCON THERE)
		TS	T5LOC
		CAF	OCT37776	# 	20MS
		TS	TIME5
		
		TCF	NOQRSM
		
CMDSOUT		LXCH	BANKRUPT	# CONTINUE PREPARATION OF OUTCOUNTERS
		EXTEND
		QXCH	QRUPT
		
		CS	ZERO		# MOST RECENT ACTUATOR COMMANDS
		AD	PCMD		#	(AVOID +0)
		TS	TVCPITCH
		CS	ZERO
		AD	YCMD
		TS	TVCYAW
		
		CAF	PRIO6		# RELEASE THE COUNTERS (BITS 11,12)
		EXTEND
		WOR	CHAN14
		
PHSCHK2		CCS	TVCPHASE	# CHECK TVCPHASE AGAIN
		TCF	CHKSTRK
		TCF	CHKSTRK
		CCS	A		# A CONTAINS THE DIMINISHED ABSOLUTE OF
		TC	+3		# TVCPHASE (-2 BECOMES +1. -1 BECOMES +0)
		
		TC	POSTJUMP	#	REPEAT TVC INITIALIZATION
		CADR	MRCLEAN		#	(DO NOT RETURN)

 +3		TC	IBNKCALL	#	REPEAT CSM/LM V46 SWITCH-OVER
		CADR	SWICHOVR +5	#	(RETURN TO CHECK FOR STROKE TEST)

CHKSTRK		CCS	STROKER		# CHECK FOR STROKE TEST IN PROGRESS
		TCF	TSTINITJ	# YES, KILL IT
		TCF	+2		# NO, PROCEED
		TCF	TSTINITJ	# YES, KILL IT

 +4		TC	POSTJUMP	#	IF POSITIVE OR ZERO, RESTART AT
		CADR	TVCINIT4	#		TVCINIT4 (ZEROS TVCPHASE, AND
					#		CALLS TVC DAPS VIA DAPINIT)
FINCOPY		INDEX	TVCPHASE	# PICK UP THE APPROPRIATE COPYCYCLE
		CAF	TVCCADR
		TCR	ISWCALL		# RE-ENTER THE COPYCYCLE, RETURN AT END
		TCF	ENABL1		# NOW PREPARE THE OUTCOUNTERS
		
TRIM/CMD	EXTEND			# TVCDAPON INITIALIZATION NOT COMPLETED,
## Page 960
		DCA	PACTOFF		#	EG. P,YCMD MAY NOT BE SET.  SET...
		DXCH	PCMD
		TCF	ENABL1		# NOW PREPARE THE OUTCOUNTERS
		
TSTINITJ	CAF	ZERO		# DISABLE STROKE TEST (-0 SHOWS PRIOR V68)
		TS	STROKER		# (+0 MEANS NEW V68 REQUIRED FOR STARTUP)
		
		TCF	CHKSTRK +4
		
EXRSTRT		INDEX	TVCEXPHS	# TVCEXECUTIVE RESTARTS....GO TO
		CAF	TVCEXADR	#	APPROPRIATE RESTART POINT
		INDEX	A
		TCF	0

# TVC RESTART TABLES.... ORDER IS REQUIRED.  HI-ORDER WORDS ONLY, OF 2CADRS, SINCE BBCON IS ALREADY THERE.

TVCADDR		=	TVCCADR		# TABLE OF CADRS, UNUSED LOCS FOR GENADRS
TVCCADR		GENADR	ENABL2		# (FOR T5 CALL, UNUSED TABLE LOC)
 +1		CADR	PCOPY 	+1	# PITCH COPYCYCLE
 +2		GENADR	CMDSOUT		# (FOR T5 CALL, UNUSED TABLE LOC)
 +3		CADR	YCOPY 	+1	# YAW COPYCYCLE
TVCEXADR	OCT	37772		# (UNUSED TABLE LOC, FILL WITH 60MS, T5)
 +1		GENADR	EXECCOPY +1	# TVCEXECUTIVE RESTART POINTS (ORDERED)
 +2		GENADR	1SHOTCHK
 +3		GENADR	TEMPSET
 +4		GENADR	CORSETUP
 +5		GENADR	CORCOPY	+1
 +6		GENADR	CNTRCOPY
