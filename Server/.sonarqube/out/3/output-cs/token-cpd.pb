
bC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Host\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str 
)  
]  !
[		 
assembly		 	
:			 

AssemblyDescription		 
(		 
$str		 !
)		! "
]		" #
[

 
assembly

 	
:

	 
!
AssemblyConfiguration

  
(

  !
$str

! #
)

# $
]

$ %
[ 
assembly 	
:	 

AssemblyCompany 
( 
$str 
)  
]  !
[ 
assembly 	
:	 

AssemblyProduct 
( 
$str !
)! "
]" #
[ 
assembly 	
:	 

AssemblyCopyright 
( 
$str 2
)2 3
]3 4
[ 
assembly 	
:	 

AssemblyTrademark 
( 
$str 
)  
]  !
[ 
assembly 	
:	 

AssemblyCulture 
( 
$str 
) 
] 
[ 
assembly 	
:	 


ComVisible 
( 
false 
) 
] 
[ 
assembly 	
:	 

Guid 
( 
$str 6
)6 7
]7 8
[   
assembly   	
:  	 

AssemblyVersion   
(   
$str   $
)  $ %
]  % &
[!! 
assembly!! 	
:!!	 

AssemblyFileVersion!! 
(!! 
$str!! (
)!!( )
]!!) *ÂG
RC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Host\Program.cs
	namespace 	
Host
 
{ 
public 

class 
Program 
{ 
private 
static 
readonly 
ILog  $
logger% +
=, -

LogManager. 8
.8 9
	GetLogger9 B
(B C
typeofC I
(I J
ProgramJ Q
)Q R
)R S
;S T
static 
void 
Main 
( 
string 
[  
]  !
args" &
)& '
{ 	
XmlConfigurator 
. 
	Configure %
(% &
)& '
;' (
logger 
. 
Info 
( 
$str 8
)8 9
;9 :
Console 
. 
	WriteLine 
( 
$str Q
)Q R
;R S
Console 
. 
ReadLine 
( 
) 
; 
var 
	container 
= 
ConfigureAutofac ,
(, -
)- .
;. /
try 
{ 
using 
( 
var 
scope  
=! "
	container# ,
., -
BeginLifetimeScope- ?
(? @
)@ A
)A B
{ 
var 
services  
=! "
new# &
[& '
]' (
{ 
new   
ServiceDefinition   -
(  - .
typeof  . 4
(  4 5
AccountService  5 C
)  C D
,  D E
typeof  F L
(  L M
IAccountService  M \
)  \ ]
,  ] ^
$str  _ o
)  o p
,  p q
new!! 
ServiceDefinition!! -
(!!- .
typeof!!. 4
(!!4 5
ProfileService!!5 C
)!!C D
,!!D E
typeof!!F L
(!!L M
IProfileService!!M \
)!!\ ]
,!!] ^
$str!!_ o
)!!o p
,!!p q
new"" 
ServiceDefinition"" -
(""- .
typeof"". 4
(""4 5
FriendshipService""5 F
)""F G
,""G H
typeof""I O
(""O P
IFriendshipService""P b
)""b c
,""c d
$str""e x
)""x y
,""y z
new## 
ServiceDefinition## -
(##- .
typeof##. 4
(##4 5
ChatService##5 @
)##@ A
,##A B
typeof##C I
(##I J
IChatService##J V
)##V W
,##W X
$str##Y f
)##f g
,##g h
new$$ 
ServiceDefinition$$ -
($$- .
typeof$$. 4
($$4 5
LobbyService$$5 A
)$$A B
,$$B C
typeof$$D J
($$J K
ILobbyService$$K X
)$$X Y
,$$Y Z
$str$$[ i
)$$i j
,$$j k
new%% 
ServiceDefinition%% -
(%%- .
typeof%%. 4
(%%4 5
ChatFriendService%%5 F
)%%F G
,%%G H
typeof%%I O
(%%O P
IChatFriendService%%P b
)%%b c
,%%c d
$str%%e x
)%%x y
,%%y z
new&& 
ServiceDefinition&& -
(&&- .
typeof&&. 4
(&&4 5
PlayerScoresService&&5 H
)&&H I
,&&I J
typeof&&K Q
(&&Q R 
IPlayerScoresService&&R f
)&&f g
,&&g h
$str&&i ~
)&&~ 
,	&& €
new'' 
ServiceDefinition'' -
(''- .
typeof''. 4
(''4 5
GameService''5 @
)''@ A
,''A B
typeof''C I
(''I J
IGameService''J V
)''V W
,''W X
$str''Y f
)''f g
,''g h
new(( 
ServiceDefinition(( -
(((- .
typeof((. 4
(((4 5
ChatLobbyService((5 E
)((E F
,((F G
typeof((H N
(((N O
IChatLobbyService((O `
)((` a
,((a b
$str((c u
)((u v
}** 
;** 
StartServices,, !
(,,! "
services,," *
,,,* +
scope,,, 1
),,1 2
;,,2 3
Console-- 
.-- 
	WriteLine-- %
(--% &
$str--& c
)--c d
;--d e
Console.. 
... 
ReadLine.. $
(..$ %
)..% &
;..& '
}// 
}00 
catch11 
(11 
	Exception11 
ex11 
)11  
{22 
logger33 
.33 
Fatal33 
(33 
$str33 =
+33> ?
ex33@ B
)33B C
;33C D
Console44 
.44 
	WriteLine44 !
(44! "
$str44" +
+44, -
ex44. 0
.440 1
Message441 8
)448 9
;449 :
}55 
finally66 
{77 
logger88 
.88 
Info88 
(88 
$str88 ?
)88? @
;88@ A
Console99 
.99 
	WriteLine99 !
(99! "
$str99" M
)99M N
;99N O
Console:: 
.:: 
ReadLine::  
(::  !
)::! "
;::" #
};; 
}<< 	
private>> 
static>> 
void>> 
StartServices>> )
(>>) *
ServiceDefinition>>* ;
[>>; <
]>>< =
services>>> F
,>>F G
ILifetimeScope>>H V
scope>>W \
)>>\ ]
{?? 	
foreach@@ 
(@@ 
var@@ 
service@@  
in@@! #
services@@$ ,
)@@, -
{AA 
tryBB 
{CC 
varDD 
serviceHostDD #
=DD$ %
newDD& )
ServiceHostDD* 5
(DD5 6
serviceDD6 =
.DD= >
ServiceTypeDD> I
)DDI J
;DDJ K
serviceHostEE 
.EE  *
AddDependencyInjectionBehaviorEE  >
(EE> ?
serviceEE? F
.EEF G
ContractTypeEEG S
,EES T
scopeEEU Z
)EEZ [
;EE[ \
serviceHostFF 
.FF  
OpenFF  $
(FF$ %
)FF% &
;FF& '
ConsoleHH 
.HH 
	WriteLineHH %
(HH% &
$"HH& (
{HH( )
serviceHH) 0
.HH0 1
DisplayNameHH1 <
}HH< =
$strHH= K
"HHK L
)HHL M
;HHM N
}II 
catchJJ 
(JJ 
	ExceptionJJ  
exJJ! #
)JJ# $
{KK 
loggerLL 
.LL 
ErrorLL  
(LL  !
$"LL! #
$strLL# 4
{LL4 5
serviceLL5 <
.LL< =
DisplayNameLL= H
}LLH I
$strLLI K
{LLK L
exLLL N
.LLN O
MessageLLO V
}LLV W
"LLW X
)LLX Y
;LLY Z
ConsoleMM 
.MM 
	WriteLineMM %
(MM% &
$"MM& (
{MM( )
serviceMM) 0
.MM0 1
DisplayNameMM1 <
}MM< =
$strMM= P
"MMP Q
)MMQ R
;MMR S
}NN 
}OO 
}PP 	
privateRR 
staticRR 

IContainerRR !
ConfigureAutofacRR" 2
(RR2 3
)RR3 4
{SS 	
varTT 
builderTT 
=TT 
newTT 
ContainerBuilderTT .
(TT. /
)TT/ 0
;TT0 1
builderUU 
.UU 
RegisterModuleUU "
<UU" #
ServiceModuleUU# 0
>UU0 1
(UU1 2
)UU2 3
;UU3 4
returnVV 
builderVV 
.VV 
BuildVV  
(VV  !
)VV! "
;VV" #
}WW 	
privateYY 
classYY 
ServiceDefinitionYY '
{ZZ 	
public[[ 
Type[[ 
ServiceType[[ #
{[[$ %
get[[& )
;[[) *
}[[+ ,
public\\ 
Type\\ 
ContractType\\ $
{\\% &
get\\' *
;\\* +
}\\, -
public]] 
string]] 
DisplayName]] %
{]]& '
get]]( +
;]]+ ,
}]]- .
public__ 
ServiceDefinition__ $
(__$ %
Type__% )
serviceType__* 5
,__5 6
Type__7 ;
contractType__< H
,__H I
string__J P
displayName__Q \
)__\ ]
{`` 
ServiceTypeaa 
=aa 
serviceTypeaa )
;aa) *
ContractTypebb 
=bb 
contractTypebb +
;bb+ ,
DisplayNamecc 
=cc 
displayNamecc )
;cc) *
}dd 
}ee 	
}ff 
}gg 