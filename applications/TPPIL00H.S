FILEO PRINTO[1] = "TRANSIT.MAS"
; Do not change filenames or add or remove FILEI/FILEO statements using an editor. Use Cube/Application Manager.

; Create TRANSIT.MAS file
copy,
 FILE = "C:\NERPM43\APPLICATIONS\TRANSIT.MAS"

DESCRIPTION                  {DESCR}
ZONESA                       {ZONESA}

; AutoCon-Related Files
; Input
StatDataFile                 {SCENARIO_DIR}\output\STATDATA_{ALT}{YEAR}.DAT
XtraAutoFileAM               {SCENARIO_DIR}\input\XTRAAUTO_{YEAR}{ALT}.DAT
XtraAutoFileMD               {SCENARIO_DIR}\input\XTRAAUTO_{YEAR}{ALT}.DAT
AutoDelFileAM                {SCENARIO_DIR}\input\AUTDELPK_{YEAR}{ALT}.DAT
AUTODELFILEMD                {SCENARIO_DIR}\input\AUTDELOP_{YEAR}{ALT}.DAT
NodesFile                    {SCENARIO_DIR}\output\XY_{ALT}{YEAR}.DAT
TransitLineFile              {SCENARIO_DIR}\output\troute_modified.lin
RHSKIMS                      {SCENARIO_DIR}\output\RHSKIMS1.{ALT}{YEAR}
FHSKIMS                      {SCENARIO_DIR}\output\FHSKIMS1.{ALT}{YEAR}
; Output
AUTOCONRPT                   {SCENARIO_DIR}\output\AUTOCON.OUT
PNRAUTOAM                    {SCENARIO_DIR}\output\NTLEG2PK_{ALT}{YEAR}.NTL
PNRAUTOMD                    {SCENARIO_DIR}\output\NTLEG2OP_{ALT}{YEAR}.NTL
KNRAUTOAM                    {SCENARIO_DIR}\output\NTLEG2PK_KNR{ALT}{YEAR}.NTL
KNRAUTOMD                    {SCENARIO_DIR}\output\NTLEG2OP_KNR{ALT}{YEAR}.NTL
; AutoCon Parameters
AUTOCONVERSION               2
ZONESI                       {ZONESI}
CBDZONE                      {CBDZONE}
TERM                         2.00
DEF                          2.00
NOPT                         1
BACK                         1
BACKD                        4.0
BACKPC                       0.30
UNITS                        5280
MAXMODE                      27
MODENUM (not used)            21 22 23 24 25 26 27
PREMIUMFLAG                    0  1  0  1  1  1  1
MODEPRIORITY                   7  5  7  2  1  4  3
VOTAM                         6.00
VOTMD                         3.00
OVTRATIOAM                    2.00
OVTRATIOMD                    2.00
AATRATIOAM                    1.50
AATRATIOMD                    1.50
AUTOCCPNR                    {OCCPNRAccess}
AUTOCCKNR                    {OCCPNRAccess}
AOC                          {hwyopcost}
InflTransitFare              {InflationFare}
InflAOC                      {InflationAOC}
InflParkingCost              {InflationParkCost}
AUTODATAM                    {SCENARIO_DIR}\output\NTLDA2PK_{ALT}{YEAR}.TIM
AUTODATMD                    {SCENARIO_DIR}\output\NTLDA2OP_{ALT}{YEAR}.TIM
ACONLISTAM                   {SCENARIO_DIR}\output\NTLEG2PK_{ALT}{YEAR}.PRN
ACONLISTMD                   {SCENARIO_DIR}\output\NTLEG2OP_{ALT}{YEAR}.PRN


endcopy

