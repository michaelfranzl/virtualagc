EESchema Schematic File Version 4
LIBS:module-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 9 24
Title "BLOCK I LOGIC FLOW S, MODULE A21, DRAWING 1006556"
Date "2018-11-25"
Rev "Draft"
Comp ""
Comment1 "Modules A21"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 1600 7200 0    140  Input ~ 28
+3VDC
Text HLabel 1600 7475 0    140  Input ~ 28
0VDC
$Comp
L AGC_DSKY:ConnectorGeneric J1
U 82 1 5BF9D1BE
P 2400 1425
F 0 "J1" H 2400 1750 140 0001 C CNN
F 1 "ConnectorGeneric" H 2400 1850 140 0001 C CNN
F 2 "" H 2400 1900 140 0001 C CNN
F 3 "" H 2400 1900 140 0001 C CNN
F 4 "T03/" H 1850 1375 140 0000 C BNB "Caption"
	82   2400 1425
	1    0    0    -1  
$EndComp
$Comp
L AGC_DSKY:ConnectorGeneric J1
U 49 1 5BF9D1BF
P 9675 5200
F 0 "J1" H 9675 5525 140 0001 C CNN
F 1 "ConnectorGeneric" H 9675 5625 140 0001 C CNN
F 2 "" H 9675 5675 140 0001 C CNN
F 3 "" H 9675 5675 140 0001 C CNN
F 4 "RQ/" H 9125 5125 140 0000 C BNB "Caption"
	49   9675 5200
	-1   0    0    1   
$EndComp
$Comp
L AGC_DSKY:ConnectorGeneric J1
U 41 1 5BF9D1C0
P 2425 4850
F 0 "J1" H 2425 5175 140 0001 C CNN
F 1 "ConnectorGeneric" H 2425 5275 140 0001 C CNN
F 2 "" H 2425 5325 140 0001 C CNN
F 3 "" H 2425 5325 140 0001 C CNN
F 4 "T02/" H 1850 4775 140 0000 C BNB "Caption"
	41   2425 4850
	1    0    0    -1  
$EndComp
$Comp
L D3NOR-+3VDC-0VDC-nd1021041:D3NOR-+3VDC-0VDC-nd1021041-_B_-___ U?
U 1 1 5BF9D1C1
P 7825 5200
F 0 "U?" H 7825 5525 140 0001 C CNB
F 1 "D3NOR-+3VDC-0VDC-nd1021041-_B_-___" H 7825 5625 140 0001 C CNN
F 2 "" H 7825 5675 140 0001 C CNN
F 3 "" H 7825 5675 140 0001 C CNN
F 4 "60403" H 7825 5200 140 0000 C CNB "Location"
	1    7825 5200
	1    0    0    1   
$EndComp
$Comp
L D3NOR-+3VDC-0VDC-nd1021041:D3NOR-+3VDC-0VDC-nd1021041-A_C-___ U?
U 1 1 5BF9D1C2
P 3875 1775
F 0 "U?" H 3875 2100 140 0001 C CNB
F 1 "D3NOR-+3VDC-0VDC-nd1021041-A_C-___" H 3875 2200 140 0001 C CNN
F 2 "" H 3875 2250 140 0001 C CNN
F 3 "" H 3875 2250 140 0001 C CNN
F 4 "60048" H 3875 1775 140 0000 C CNB "Location"
	1    3875 1775
	1    0    0    -1  
$EndComp
$Comp
L AGC_DSKY:ConnectorGeneric J1
U 50 1 5BF9D1C3
P 2375 2125
F 0 "J1" H 2375 2450 140 0001 C CNN
F 1 "ConnectorGeneric" H 2375 2550 140 0001 C CNN
F 2 "" H 2375 2600 140 0001 C CNN
F 3 "" H 2375 2600 140 0001 C CNN
F 4 "DV1/" H 1775 2050 140 0000 C BNB "Caption"
	50   2375 2125
	1    0    0    -1  
$EndComp
$Comp
L AGC_DSKY:ConnectorGeneric J1
U 56 1 5BF9D1C4
P 9675 1775
F 0 "J1" H 9675 2100 140 0001 C CNN
F 1 "ConnectorGeneric" H 9675 2200 140 0001 C CNN
F 2 "" H 9675 2250 140 0001 C CNN
F 3 "" H 9675 2250 140 0001 C CNN
F 4 "WQ/" H 9125 1700 140 0000 C BNB "Caption"
	56   9675 1775
	-1   0    0    1   
$EndComp
$Comp
L D3NOR-NC-0VDC-expander-nd1021041:D3NOR-NC-0VDC-expander-nd1021041-_B_-___ U?
U 1 1 5BF9D1C5
P 7850 1775
F 0 "U?" H 7850 2100 140 0001 C CNB
F 1 "D3NOR-NC-0VDC-expander-nd1021041-_B_-___" H 7850 2200 140 0001 C CNN
F 2 "" H 7850 2250 140 0001 C CNN
F 3 "" H 7850 2250 140 0001 C CNN
F 4 "60404" H 7775 1775 130 0000 C CNB "Location"
	1    7850 1775
	1    0    0    1   
$EndComp
$Comp
L AGC_DSKY:ConnectorGeneric J1
U 33 1 5BF9D1C6
P 2450 5550
F 0 "J1" H 2450 5875 140 0001 C CNN
F 1 "ConnectorGeneric" H 2450 5975 140 0001 C CNN
F 2 "" H 2450 6025 140 0001 C CNN
F 3 "" H 2450 6025 140 0001 C CNN
F 4 "DV1/" H 1875 5475 140 0000 C BNB "Caption"
	33   2450 5550
	1    0    0    -1  
$EndComp
$Comp
L D3NOR-+3VDC-0VDC-nd1021041:D3NOR-+3VDC-0VDC-nd1021041-A_C-___ U?
U 1 1 5BF9D1C7
P 3875 5200
F 0 "U?" H 3875 5525 140 0001 C CNB
F 1 "D3NOR-+3VDC-0VDC-nd1021041-A_C-___" H 3875 5625 140 0001 C CNN
F 2 "" H 3875 5675 140 0001 C CNN
F 3 "" H 3875 5675 140 0001 C CNN
F 4 "60039" H 3875 5200 140 0000 C CNB "Location"
	1    3875 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4775 1775 7250 1775
Wire Wire Line
	7225 5200 4775 5200
Wire Wire Line
	3250 1425 2675 1425
Wire Wire Line
	3250 2125 2650 2125
Wire Wire Line
	8650 1775 9400 1775
Wire Wire Line
	8725 5200 9400 5200
Wire Wire Line
	3250 5550 2725 5550
Wire Wire Line
	3250 4850 2700 4850
$EndSCHEMATC