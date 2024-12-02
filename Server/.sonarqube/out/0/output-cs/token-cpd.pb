≤
nC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Utilities\DataAccessException.cs
	namespace 	

DataAccess
 
. 
	Utilities 
{ 
public 

class 
DataAccessException $
:% &
	Exception' 0
{ 
public 
DataAccessException "
(" #
string# )
message* 1
)1 2
:3 4
base5 9
(9 :
message: A
)A B
{C D
}E F
public		 
DataAccessException		 "
(		" #
string		# )
message		* 1
,		1 2
	Exception		3 <
innerException		= K
)		K L
:

 
base

 
(

 
message

 
,

 
innerException

 *
)

* +
{

, -
}

. /
} 
} ¯=
oC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\ProfileRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

class 
ProfileRepository "
:# $
IProfileRepository% 7
{ 
private 
readonly 
BMCEntities $
_context% -
;- .
public 
ProfileRepository  
(  !
BMCEntities! ,
context- 4
)4 5
{ 	
_context 
= 
context 
?? !
throw" '
new( +!
ArgumentNullException, A
(A B
nameofB H
(H I
contextI P
)P Q
,Q R
$strS u
)u v
;v w
} 	
public 
Profile  
GetProfileByPlayerId +
(+ ,
int, /
playerId0 8
)8 9
{ 	
if 
( 
playerId 
<= 
$num 
) 
{ 
throw 
new 
ArgumentException +
(+ ,
$str, R
,R S
nameofT Z
(Z [
playerId[ c
)c d
)d e
;e f
} 
try 
{ 
return 
_context 
.  
Profile  '
.' (
SingleOrDefault( 7
(7 8
p8 9
=>: <
p= >
.> ?
PlayerID? G
==H J
playerIdK S
)S T
;T U
}   
catch!! 
(!! 
SqlException!! 
ex!!  "
)!!" #
{"" 
throw## 
new## 
DataAccessException## -
(##- .
$str##. l
,##l m
ex##n p
)##p q
;##q r
}$$ 
catch%% 
(%% 
	Exception%% 
ex%% 
)%%  
{&& 
throw'' 
new'' 
DataAccessException'' -
(''- .
$str''. ^
,''^ _
ex''` b
)''b c
;''c d
}(( 
})) 	
public++ 
void++ 
Add++ 
(++ 
Profile++ 
profile++  '
)++' (
{,, 	
if-- 
(-- 
profile-- 
==-- 
null-- 
)--  
{.. 
throw// 
new// !
ArgumentNullException// /
(/// 0
nameof//0 6
(//6 7
profile//7 >
)//> ?
,//? @
$str//A Z
)//Z [
;//[ \
}00 
try22 
{33 
_context44 
.44 
Profile44  
.44  !
Add44! $
(44$ %
profile44% ,
)44, -
;44- .
}55 
catch66 
(66 
DbUpdateException66 $
ex66% '
)66' (
{77 
throw88 
new88 
DataAccessException88 -
(88- .
$str88. Z
,88Z [
ex88\ ^
)88^ _
;88_ `
}99 
catch:: 
(:: 
SqlException:: 
ex::  "
)::" #
{;; 
throw<< 
new<< 
DataAccessException<< -
(<<- .
$str<<. ^
,<<^ _
ex<<` b
)<<b c
;<<c d
}== 
catch>> 
(>> 
	Exception>> 
ex>> 
)>>  
{?? 
throw@@ 
new@@ 
DataAccessException@@ -
(@@- .
$str@@. \
,@@\ ]
ex@@^ `
)@@` a
;@@a b
}AA 
}BB 	
publicDD 
voidDD 
UpdateDD 
(DD 
ProfileDD "
profileDD# *
)DD* +
{EE 	
ifFF 
(FF 
profileFF 
==FF 
nullFF 
)FF  
{GG 
throwHH 
newHH !
ArgumentNullExceptionHH /
(HH/ 0
nameofHH0 6
(HH6 7
profileHH7 >
)HH> ?
,HH? @
$strHHA a
)HHa b
;HHb c
}II 
tryKK 
{LL 
varMM 
existingProfileMM #
=MM$ % 
GetProfileByPlayerIdMM& :
(MM: ;
profileMM; B
.MMB C
PlayerIDMMC K
)MMK L
;MML M
ifNN 
(NN 
existingProfileNN #
==NN$ &
nullNN' +
)NN+ ,
{OO 
throwPP 
newPP 
DataAccessExceptionPP 1
(PP1 2
$strPP2 F
)PPF G
;PPG H
}QQ 
existingProfileSS 
.SS  
FullNameSS  (
=SS) *
profileSS+ 2
.SS2 3
FullNameSS3 ;
;SS; <
existingProfileTT 
.TT  
BioTT  #
=TT$ %
profileTT& -
.TT- .
BioTT. 1
;TT1 2
existingProfileUU 
.UU  
LastUpdatedUU  +
=UU, -
DateTimeUU. 6
.UU6 7
NowUU7 :
;UU: ;
_contextWW 
.WW 
EntryWW 
(WW 
existingProfileWW .
)WW. /
.WW/ 0
StateWW0 5
=WW6 7
EntityStateWW8 C
.WWC D
ModifiedWWD L
;WWL M
_contextYY 
.YY 
SaveChangesYY $
(YY$ %
)YY% &
;YY& '
}ZZ 
catch[[ 
([[ 
SqlException[[ 
ex[[  "
)[[" #
{\\ 
throw]] 
new]] 
DataAccessException]] -
(]]- .
$str]]. U
,]]U V
ex]]W Y
)]]Y Z
;]]Z [
}^^ 
catch__ 
(__ 
	Exception__ 
ex__ 
)__  
{`` 
throwaa 
newaa 
DataAccessExceptionaa -
(aa- .
$straa. ]
,aa] ^
exaa_ a
)aaa b
;aab c
}bb 
}cc 	
publicee 
voidee 
SetLastVisitee  
(ee  !
intee! $
playerIdee% -
,ee- .
DateTimeee/ 7
lastVisitDateee8 E
)eeE F
{ff 	
ifgg 
(gg 
playerIdgg 
<=gg 
$numgg 
)gg 
{hh 
throwii 
newii 
ArgumentExceptionii +
(ii+ ,
$strii, R
,iiR S
nameofiiT Z
(iiZ [
playerIdii[ c
)iic d
)iid e
;iie f
}jj 
tryll 
{mm 
varnn 
profilenn 
=nn  
GetProfileByPlayerIdnn 2
(nn2 3
playerIdnn3 ;
)nn; <
;nn< =
ifoo 
(oo 
profileoo 
!=oo 
nulloo #
)oo# $
{pp 
profileqq 
.qq 
	LastVisitqq %
=qq& '
lastVisitDateqq( 5
;qq5 6
Updaterr 
(rr 
profilerr "
)rr" #
;rr# $
}ss 
}tt 
catchuu 
(uu 
SqlExceptionuu 
exuu  "
)uu" #
{vv 
throwww 
newww 
DataAccessExceptionww -
(ww- .
$strww. ]
,ww] ^
exww_ a
)wwa b
;wwb c
}xx 
}yy 	
public{{ 
void{{ 
Save{{ 
({{ 
){{ 
{|| 	
_context}} 
.}} 
SaveChanges}}  
(}}  !
)}}! "
;}}" #
}~~ 	
}
ÅÅ 
}ÇÇ —I
tC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\PlayerScoresRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{		 
public

 

class

 "
PlayerScoresRepository

 '
:

( )#
IPlayerScoresRepository

* A
{ 
private 
readonly 
BMCEntities $
_context% -
;- .
public "
PlayerScoresRepository %
(% &
BMCEntities& 1
context2 9
)9 :
{ 	
_context 
= 
context 
; 
} 	
public 

UserScores 
GetScoresByPlayerId -
(- .
int. 1
playerId2 :
): ;
{ 	
if 
( 
playerId 
<= 
$num 
) 
{ 
throw 
new 
ArgumentException +
(+ ,
$str, R
,R S
nameofT Z
(Z [
playerId[ c
)c d
)d e
;e f
} 
try 
{ 
return 
_context 
.  

UserScores  *
.* +
FirstOrDefault+ 9
(9 :
us: <
=>= ?
us@ B
.B C
PlayerIDC K
==L N
playerIdO W
)W X
;X Y
} 
catch 
( 
SqlException 
)  
{ 
throw   
;   
}!! 
catch"" 
("" 
	Exception"" 
ex"" 
)""  
{## 
throw$$ 
new$$ 
DataAccessException$$ -
($$- .
$str$$. r
,$$r s
ex$$t v
)$$v w
;$$w x
}%% 
}&& 	
public(( 
IEnumerable(( 
<(( 

UserScores(( %
>((% &
GetTopScores((' 3
(((3 4
int((4 7
top((8 ;
)((; <
{)) 	
if** 
(** 
top** 
<=** 
$num** 
)** 
{++ 
throw,, 
new,, 
ArgumentException,, +
(,,+ ,
$str,,, R
,,,R S
nameof,,T Z
(,,Z [
top,,[ ^
),,^ _
),,_ `
;,,` a
}-- 
try// 
{00 
return11 
_context11 
.11  

UserScores11  *
.11* +
OrderByDescending11+ <
(11< =
us11= ?
=>11@ B
us11C E
.11E F
Wins11F J
)11J K
.11K L
Take11L P
(11P Q
top11Q T
)11T U
.11U V
ToList11V \
(11\ ]
)11] ^
;11^ _
}22 
catch33 
(33 
SqlException33 
)33  
{44 
throw55 
;55 
}66 
catch77 
(77 
	Exception77 
ex77 
)77  
{88 
throw99 
new99 
DataAccessException99 -
(99- .
$str99. i
,99i j
ex99k m
)99m n
;99n o
}:: 
};; 	
public== 
void== 
IncrementWins== !
(==! "
int==" %
playerId==& .
)==. /
{>> 	
var?? 
scores?? 
=?? 
GetScoresByPlayerId?? ,
(??, -
playerId??- 5
)??5 6
;??6 7
if@@ 
(@@ 
scores@@ 
==@@ 
null@@ 
)@@ 
{AA 
throwBB 
newBB %
InvalidOperationExceptionBB 3
(BB3 4
$"BB4 6
$strBB6 Y
{BBY Z
playerIdBBZ b
}BBb c
$strBBc d
"BBd e
)BBe f
;BBf g
}CC 
tryEE 
{FF 
scoresGG 
.GG 
WinsGG 
++GG 
;GG 
UpdateHH 
(HH 
scoresHH 
)HH 
;HH 
SaveII 
(II 
)II 
;II 
}JJ 
catchKK 
(KK 
DbUpdateExceptionKK $
exKK% '
)KK' (
{LL 
throwMM 
newMM 
DataAccessExceptionMM -
(MM- .
$strMM. p
,MMp q
exMMr t
)MMt u
;MMu v
}NN 
catchOO 
(OO 
SqlExceptionOO 
)OO  
{PP 
throwQQ 
;QQ 
}RR 
catchSS 
(SS 
	ExceptionSS 
exSS 
)SS  
{TT 
throwUU 
newUU 
DataAccessExceptionUU -
(UU- .
$strUU. e
,UUe f
exUUg i
)UUi j
;UUj k
}VV 
}WW 	
publicYY 
voidYY 
IncrementLossesYY #
(YY# $
intYY$ '
playerIdYY( 0
)YY0 1
{ZZ 	
var[[ 
scores[[ 
=[[ 
GetScoresByPlayerId[[ ,
([[, -
playerId[[- 5
)[[5 6
;[[6 7
if\\ 
(\\ 
scores\\ 
==\\ 
null\\ 
)\\ 
{]] 
throw^^ 
new^^ %
InvalidOperationException^^ 3
(^^3 4
$"^^4 6
$str^^6 Y
{^^Y Z
playerId^^Z b
}^^b c
$str^^c d
"^^d e
)^^e f
;^^f g
}__ 
tryaa 
{bb 
scorescc 
.cc 
Lossescc 
++cc 
;cc  
Updatedd 
(dd 
scoresdd 
)dd 
;dd 
Saveee 
(ee 
)ee 
;ee 
}ff 
catchgg 
(gg 
DbUpdateExceptiongg $
exgg% '
)gg' (
{hh 
throwii 
newii 
DataAccessExceptionii -
(ii- .
$strii. q
,iiq r
exiis u
)iiu v
;iiv w
}jj 
catchkk 
(kk 
SqlExceptionkk 
exkk  "
)kk" #
{ll 
throwmm 
newmm 
DataAccessExceptionmm -
(mm- .
$strmm. ]
,mm] ^
exmm_ a
)mma b
;mmb c
}nn 
catchoo 
(oo 
	Exceptionoo 
exoo 
)oo  
{pp 
throwqq 
newqq 
DataAccessExceptionqq -
(qq- .
$strqq. g
,qqg h
exqqi k
)qqk l
;qql m
}rr 
}ss 	
publicuu 
voiduu 
Adduu 
(uu 

UserScoresuu "
playerScoresuu# /
)uu/ 0
{vv 	
ifww 
(ww 
playerScoresww 
==ww 
nullww  $
)ww$ %
{xx 
throwyy 
newyy !
ArgumentNullExceptionyy /
(yy/ 0
nameofyy0 6
(yy6 7
playerScoresyy7 C
)yyC D
,yyD E
$stryyF k
)yyk l
;yyl m
}zz 
try|| 
{}} 
_context~~ 
.~~ 

UserScores~~ #
.~~# $
Add~~$ '
(~~' (
playerScores~~( 4
)~~4 5
;~~5 6
} 
catch
ÄÄ 
(
ÄÄ 
DbUpdateException
ÄÄ $
ex
ÄÄ% '
)
ÄÄ' (
{
ÅÅ 
throw
ÇÇ 
new
ÇÇ !
DataAccessException
ÇÇ -
(
ÇÇ- .
$str
ÇÇ. j
,
ÇÇj k
ex
ÇÇl n
)
ÇÇn o
;
ÇÇo p
}
ÉÉ 
catch
ÑÑ 
(
ÑÑ 
SqlException
ÑÑ 
ex
ÑÑ  "
)
ÑÑ" #
{
ÖÖ 
throw
ÜÜ 
new
ÜÜ !
DataAccessException
ÜÜ -
(
ÜÜ- .
$str
ÜÜ. ^
,
ÜÜ^ _
ex
ÜÜ` b
)
ÜÜb c
;
ÜÜc d
}
áá 
catch
àà 
(
àà 
	Exception
àà 
ex
àà 
)
àà  
{
ââ 
throw
ää 
new
ää !
DataAccessException
ää -
(
ää- .
$str
ää. h
,
ääh i
ex
ääj l
)
ääl m
;
ääm n
}
ãã 
}
åå 	
private
éé 
void
éé 
Update
éé 
(
éé 

UserScores
éé &
scores
éé' -
)
éé- .
{
èè 	
_context
êê 
.
êê 
Entry
êê 
(
êê 
scores
êê !
)
êê! "
.
êê" #
State
êê# (
=
êê) *
System
êê+ 1
.
êê1 2
Data
êê2 6
.
êê6 7
Entity
êê7 =
.
êê= >
EntityState
êê> I
.
êêI J
Modified
êêJ R
;
êêR S
}
ëë 	
public
ìì 
void
ìì 
Save
ìì 
(
ìì 
)
ìì 
{
îî 	
_context
ïï 
.
ïï 
SaveChanges
ïï  
(
ïï  !
)
ïï! "
;
ïï" #
}
ññ 	
}
óó 
}òò ç
oC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\IPlayerRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

	interface 
IPlayerRepository &
{ 
Player 
GetByUsername 
( 
string #
username$ ,
), -
;- .
Player 

GetByEmail 
( 
string  
email! &
)& '
;' (
void		 
Add		 
(		 
Player		 
player		 
)		 
;		  
void

 
Update

 
(

 
Player

 
player

 !
)

! "
;

" #
void 
UpdatePasswordHash 
(  
string  &
username' /
,/ 0
string2 8
passwordHash9 E
)E F
;F G
void 
Save 
( 
) 
; 
IEnumerable 
< 
Player 
>  
GetPlayersByUsername 0
(0 1
string1 7
username8 @
,@ A
intB E
playerIdF N
)N O
;O P
IEnumerable 
< 
Player 
> 

GetPlayers &
(& '
string' -
username. 6
)6 7
;7 8
} 
} «a
mC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\PlayerRepositoy.cs
	namespace

 	

DataAccess


 
.

 
Repositories

 !
{ 
public 

class 
PlayerRepository !
:" #
IPlayerRepository$ 5
{ 
private 
readonly 
BMCEntities $
_context% -
;- .
public 
PlayerRepository 
(  
BMCEntities  +
context, 3
)3 4
{ 	
_context 
= 
context 
; 
} 	
public 
Player 
GetByUsername #
(# $
string$ *
username+ 3
)3 4
{ 	
if 
( 
string 
. 
IsNullOrEmpty $
($ %
username% -
)- .
). /
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
username7 ?
)? @
,@ A
$strB e
)e f
;f g
} 
try 
{ 
return 
_context 
.  
Player  &
.& '
SingleOrDefault' 6
(6 7
p7 8
=>9 ;
p< =
.= >
Username> F
==G I
usernameJ R
)R S
;S T
}   
catch!! 
(!! 
SqlException!! 
)!!  
{"" 
throw## 
;## 
}$$ 
catch%% 
(%% %
InvalidOperationException%% ,
ex%%- /
)%%/ 0
{&& 
throw'' 
new'' 
DataAccessException'' -
(''- .
$str''. v
,''v w
ex''x z
)''z {
;''{ |
}(( 
})) 	
public++ 
Player++ 

GetByEmail++  
(++  !
string++! '
email++( -
)++- .
{,, 	
if-- 
(-- 
string-- 
.-- 
IsNullOrEmpty-- $
(--$ %
email--% *
)--* +
)--+ ,
{.. 
throw// 
new// !
ArgumentNullException// /
(/// 0
nameof//0 6
(//6 7
email//7 <
)//< =
,//= >
$str//? _
)//_ `
;//` a
}00 
try22 
{33 
return44 
_context44 
.44  
Player44  &
.44& '
SingleOrDefault44' 6
(446 7
p447 8
=>449 ;
p44< =
.44= >
Email44> C
==44D F
email44G L
)44L M
;44M N
}55 
catch66 
(66 
SqlException66 
)66  
{77 
throw88 
;88 
}99 
catch:: 
(:: %
InvalidOperationException:: ,
ex::- /
)::/ 0
{;; 
throw<< 
new<< 
DataAccessException<< -
(<<- .
$str<<. s
,<<s t
ex<<u w
)<<w x
;<<x y
}== 
}>> 	
public@@ 
void@@ 
Add@@ 
(@@ 
Player@@ 
player@@ %
)@@% &
{AA 	
ifBB 
(BB 
playerBB 
==BB 
nullBB 
)BB 
{CC 
throwDD 
newDD !
ArgumentNullExceptionDD /
(DD/ 0
nameofDD0 6
(DD6 7
playerDD7 =
)DD= >
,DD> ?
$strDD@ _
)DD_ `
;DD` a
}EE 
tryGG 
{HH 
_contextII 
.II 
PlayerII 
.II  
AddII  #
(II# $
playerII$ *
)II* +
;II+ ,
}JJ 
catchKK 
(KK 
DbUpdateExceptionKK $
exKK% '
)KK' (
{LL 
throwMM 
newMM 
DataAccessExceptionMM -
(MM- .
$strMM. y
,MMy z
exMM{ }
)MM} ~
;MM~ 
}NN 
catchOO 
(OO '
DbEntityValidationExceptionOO .
exOO/ 1
)OO1 2
{PP 
throwQQ 
newQQ 
DataAccessExceptionQQ -
(QQ- .
$strQQ. a
,QQa b
exQQc e
)QQe f
;QQf g
}RR 
catchSS 
(SS 
SqlExceptionSS 
)SS  
{TT 
throwUU 
;UU 
}VV 
catchWW 
(WW %
InvalidOperationExceptionWW ,
exWW- /
)WW/ 0
{XX 
throwYY 
newYY 
DataAccessExceptionYY -
(YY- .
$strYY. f
,YYf g
exYYh j
)YYj k
;YYk l
}ZZ 
}[[ 	
public]] 
void]] 
UpdatePasswordHash]] &
(]]& '
string]]' -
username]]. 6
,]]6 7
string]]8 >
passwordHash]]? K
)]]K L
{^^ 	
var``	 
player`` 
=`` 
GetByUsername`` #
(``# $
username``$ ,
)``, -
;``- .
ifaa	 
(aa 
playeraa 
!=aa 
nullaa 
)aa 
{bb	 

playercc 
.cc 
PasswordHashcc 
=cc  !
passwordHashcc" .
;cc. /
_contextdd 
.dd 
Entrydd 
(dd 
playerdd !
)dd! "
.dd" #
Statedd# (
=dd) *
EntityStatedd+ 6
.dd6 7
Modifieddd7 ?
;dd? @
_contextee 
.ee 
SaveChangesee  
(ee  !
)ee! "
;ee" #
}ff	 

}hh 	
publicjj 
voidjj 
Savejj 
(jj 
)jj 
{kk 	
_contextll 
.ll 
SaveChangesll  
(ll  !
)ll! "
;ll" #
}mm 	
publicoo 
voidoo 
Updateoo 
(oo 
Playeroo !
playeroo" (
)oo( )
{pp 	
ifqq 
(qq 
playerqq 
==qq 
nullqq 
)qq 
{rr 
throwss 
newss !
ArgumentNullExceptionss /
(ss/ 0
nameofss0 6
(ss6 7
playerss7 =
)ss= >
,ss> ?
$strss@ _
)ss_ `
;ss` a
}tt 
tryvv 
{ww 
_contextxx 
.xx 
Entryxx 
(xx 
playerxx %
)xx% &
.xx& '
Statexx' ,
=xx- .
EntityStatexx/ :
.xx: ;
Modifiedxx; C
;xxC D
_contextzz 
.zz 
SaveChangeszz $
(zz$ %
)zz% &
;zz& '
}{{ 
catch|| 
(|| 
DbUpdateException|| $
ex||% '
)||' (
{}} 
throw~~ 
new~~ 
DataAccessException~~ -
(~~- .
$str~~. w
,~~w x
ex~~y {
)~~{ |
;~~| }
} 
catch
ÄÄ 
(
ÄÄ )
DbEntityValidationException
ÄÄ .
ex
ÄÄ/ 1
)
ÄÄ1 2
{
ÅÅ 
throw
ÇÇ 
new
ÇÇ !
DataAccessException
ÇÇ -
(
ÇÇ- .
$str
ÇÇ. c
,
ÇÇc d
ex
ÇÇe g
)
ÇÇg h
;
ÇÇh i
}
ÉÉ 
catch
ÑÑ 
(
ÑÑ 
SqlException
ÑÑ 
)
ÑÑ  
{
ÖÖ 
throw
ÜÜ 
;
ÜÜ 
}
áá 
catch
àà 
(
àà '
InvalidOperationException
àà ,
ex
àà- /
)
àà/ 0
{
ââ 
throw
ää 
new
ää !
DataAccessException
ää -
(
ää- .
$str
ää. h
,
ääh i
ex
ääj l
)
ääl m
;
ääm n
}
ãã 
}
åå 	
public
éé 
IEnumerable
éé 
<
éé 
Player
éé !
>
éé! ""
GetPlayersByUsername
éé# 7
(
éé7 8
string
éé8 >
username
éé? G
,
ééG H
int
ééI L
playerId
ééM U
)
ééU V
{
èè 	
if
êê 
(
êê 
playerId
êê 
<=
êê 
$num
êê 
)
êê 
{
ëë 
throw
íí 
new
íí 
ArgumentException
íí +
(
íí+ ,
$str
íí, R
,
ííR S
nameof
ííT Z
(
ííZ [
playerId
íí[ c
)
ííc d
)
ííd e
;
ííe f
}
ìì 
try
ïï 
{
ññ 
var
óó 
players
óó 
=
óó 
_context
óó &
.
óó& '
Player
óó' -
.
òò 
Where
òò 
(
òò 
p
òò 
=>
òò 
p
òò 
.
òò 
Username
òò &
.
òò& '
Contains
òò' /
(
òò/ 0
username
òò0 8
)
òò8 9
&&
òò: <
p
òò= >
.
òò> ?
PlayerID
òò? G
!=
òòH J
playerId
òòK S
)
òòS T
.
ôô 
ToList
ôô 
(
ôô 
)
ôô 
;
ôô 
return
õõ 
players
õõ 
;
õõ 
}
úú 
catch
ùù 
(
ùù 
SqlException
ùù 
)
ùù  
{
ûû 
throw
üü 
;
üü 
}
†† 
catch
°° 
(
°° '
InvalidOperationException
°° ,
ex
°°- /
)
°°/ 0
{
¢¢ 
throw
££ 
new
££ !
DataAccessException
££ -
(
££- .
$str
££. d
,
££d e
ex
££f h
)
££h i
;
££i j
}
§§ 
catch
•• 
(
•• 
	Exception
•• 
ex
•• 
)
••  
{
¶¶ 
throw
ßß 
new
ßß !
DataAccessException
ßß -
(
ßß- .
$str
ßß. o
,
ßßo p
ex
ßßq s
)
ßßs t
;
ßßt u
}
®® 
}
©© 	
public
´´ 
IEnumerable
´´ 
<
´´ 
Player
´´ !
>
´´! "

GetPlayers
´´# -
(
´´- .
string
´´. 4
username
´´5 =
)
´´= >
{
¨¨ 	
if
≠≠ 
(
≠≠ 
string
≠≠ 
.
≠≠ 
IsNullOrEmpty
≠≠ $
(
≠≠$ %
username
≠≠% -
)
≠≠- .
)
≠≠. /
{
ÆÆ 
throw
ØØ 
new
ØØ 
ArgumentException
ØØ +
(
ØØ+ ,
$str
ØØ, H
,
ØØH I
username
ØØJ R
)
ØØR S
;
ØØS T
}
∞∞ 
try
≤≤ 
{
≥≥ 
var
¥¥ 
players
¥¥ 
=
¥¥ 
_context
¥¥ &
.
¥¥& '
Player
¥¥' -
.
µµ 
Where
µµ 
(
µµ 
p
µµ 
=>
µµ 
p
µµ 
.
µµ 
Username
µµ &
!=
µµ' )
username
µµ* 2
)
µµ2 3
.
∂∂ 
ToList
∂∂ 
(
∂∂ 
)
∂∂ 
;
∂∂ 
return
∑∑ 
players
∑∑ 
;
∑∑ 
}
∏∏ 
catch
∏∏ 
(
∏∏ 
SqlException
∏∏ !
)
∏∏! "
{
ππ 
throw
∫∫ 
;
∫∫ 
}
ªª 
catch
ºº 
(
ºº '
InvalidOperationException
ºº ,
ex
ºº- /
)
ºº/ 0
{
ΩΩ 
throw
ææ 
new
ææ !
DataAccessException
ææ -
(
ææ- .
$str
ææ. d
,
ææd e
ex
ææf h
)
ææh i
;
ææi j
}
øø 
catch
¿¿ 
(
¿¿ 
	Exception
¿¿ 
ex
¿¿ 
)
¿¿  
{
¡¡ 
throw
¬¬ 
new
¬¬ !
DataAccessException
¬¬ -
(
¬¬- .
$str
¬¬. o
,
¬¬o p
ex
¬¬q s
)
¬¬s t
;
¬¬t u
}
√√ 
}
ƒƒ 	
}
∆∆ 
}«« Ò
uC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\IPlayerScoresRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

	interface #
IPlayerScoresRepository ,
{ 
IEnumerable 
< 

UserScores 
> 
GetTopScores  ,
(, -
int- 0
top1 4
)4 5
;5 6

UserScores 
GetScoresByPlayerId &
(& '
int' *
playerId+ 3
)3 4
;4 5
void		 
IncrementWins		 
(		 
int		 
playerId		 '
)		' (
;		( )
void

 
IncrementLosses

 
(

 
int

  
playerId

! )
)

) *
;

* +
void 
Add 
( 

UserScores 
playerScores (
)( )
;) *
void 
Save 
( 
) 
; 
} 
} ∫f
qC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\GameLobbyRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public		 

class		 
GameLobbyRepository		 $
:		% & 
IGameLobbyRepository		' ;
{

 
private 
readonly 
BMCEntities $
_context% -
;- .
public 
GameLobbyRepository "
(" #
BMCEntities# .
context/ 6
)6 7
{ 	
_context 
= 
context 
; 
} 	
public 
void 
CreateLobby 
(  
	GameLobby  )
lobby* /
)/ 0
{ 	
if 
( 
lobby 
== 
null 
) 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
lobby7 <
)< =
,= >
$str? V
)V W
;W X
try 
{ 
_context 
. 
	GameLobby "
." #
Add# &
(& '
lobby' ,
), -
;- .
_context 
. 
SaveChanges $
($ %
)% &
;& '
} 
catch 
( 
SqlException 
ex  "
)" #
{ 
throw 
new 
DataAccessException -
(- .
$str. \
,\ ]
ex^ `
)` a
;a b
} 
catch   
(   
	Exception   
ex   
)    
{!! 
throw"" 
new"" 
DataAccessException"" -
(""- .
$str"". f
,""f g
ex""h j
)""j k
;""k l
}## 
}$$ 	
public&& 
	GameLobby&& 
GetByLobbyName&& '
(&&' (
string&&( .
	lobbyName&&/ 8
)&&8 9
{'' 	
if(( 
((( 
string(( 
.(( 
IsNullOrWhiteSpace(( )
((() *
	lobbyName((* 3
)((3 4
)((4 5
throw)) 
new)) 
ArgumentException)) +
())+ ,
$str)), I
,))I J
nameof))K Q
())Q R
	lobbyName))R [
)))[ \
)))\ ]
;))] ^
try++ 
{,, 
return-- 
_context-- 
.--  
	GameLobby--  )
.--) *
SingleOrDefault--* 9
(--9 :
l--: ;
=>--< >
l--? @
.--@ A
	LobbyName--A J
==--K M
	lobbyName--N W
)--W X
;--X Y
}.. 
catch// 
(// 
SqlException// 
ex//  "
)//" #
{00 
throw11 
new11 
DataAccessException11 -
(11- .
$str11. f
,11f g
ex11h j
)11j k
;11k l
}22 
catch33 
(33 
	Exception33 
ex33 
)33  
{44 
throw55 
new55 
DataAccessException55 -
(55- .
$str55. p
,55p q
ex55r t
)55t u
;55u v
}66 
}77 	
public99 
	GameLobby99 
GetById99  
(99  !
int99! $
lobbyId99% ,
)99, -
{:: 	
if;; 
(;; 
lobbyId;; 
<=;; 
$num;; 
);; 
throw<< 
new<< 
ArgumentException<< +
(<<+ ,
$str<<, Q
,<<Q R
nameof<<S Y
(<<Y Z
lobbyId<<Z a
)<<a b
)<<b c
;<<c d
try>> 
{?? 
return@@ 
_context@@ 
.@@  
	GameLobby@@  )
.@@) *
SingleOrDefault@@* 9
(@@9 :
l@@: ;
=>@@< >
l@@? @
.@@@ A
LobbyID@@A H
==@@I K
lobbyId@@L S
)@@S T
;@@T U
}AA 
catchBB 
(BB 
SqlExceptionBB 
exBB  "
)BB" #
{CC 
throwDD 
newDD 
DataAccessExceptionDD -
(DD- .
$strDD. d
,DDd e
exDDf h
)DDh i
;DDi j
}EE 
catchFF 
(FF 
	ExceptionFF 
exFF 
)FF  
{GG 
throwHH 
newHH 
DataAccessExceptionHH -
(HH- .
$strHH. n
,HHn o
exHHp r
)HHr s
;HHs t
}II 
}JJ 	
publicLL 
boolLL 
IsLobbyPrivateLL "
(LL" #
intLL# &
lobbyIdLL' .
)LL. /
{MM 	
tryNN 
{OO 
varPP 
lobbyPP 
=PP 
GetByIdPP #
(PP# $
lobbyIdPP$ +
)PP+ ,
;PP, -
returnQQ 
!QQ 
stringQQ 
.QQ 
IsNullOrEmptyQQ ,
(QQ, -
lobbyQQ- 2
?QQ2 3
.QQ3 4
PasswordQQ4 <
)QQ< =
;QQ= >
}RR 
catchSS 
(SS 
	ExceptionSS 
exSS 
)SS  
{TT 
throwUU 
newUU 
DataAccessExceptionUU -
(UU- .
$strUU. f
,UUf g
exUUh j
)UUj k
;UUk l
}VV 
}WW 	
publicYY 
boolYY 
VerifyLobbyPasswordYY '
(YY' (
intYY( +
lobbyIdYY, 3
,YY3 4
stringYY5 ;
passwordYY< D
)YYD E
{ZZ 	
if[[ 
([[ 
string[[ 
.[[ 
IsNullOrWhiteSpace[[ )
([[) *
password[[* 2
)[[2 3
)[[3 4
throw\\ 
new\\ 
ArgumentException\\ +
(\\+ ,
$str\\, G
,\\G H
nameof\\I O
(\\O P
password\\P X
)\\X Y
)\\Y Z
;\\Z [
try^^ 
{__ 
var`` 
lobby`` 
=`` 
GetById`` #
(``# $
lobbyId``$ +
)``+ ,
;``, -
ifaa 
(aa 
lobbyaa 
==aa 
nullaa !
||aa" $
lobbyaa% *
.aa* +
Passwordaa+ 3
==aa4 6
nullaa7 ;
)aa; <
returnbb 
falsebb  
;bb  !
returndd 
lobbydd 
.dd 
Passworddd %
==dd& (
passworddd) 1
;dd1 2
}ee 
catchff 
(ff 
	Exceptionff 
exff 
)ff  
{gg 
throwhh 
newhh 
DataAccessExceptionhh -
(hh- .
$strhh. b
,hhb c
exhhd f
)hhf g
;hhg h
}ii 
}jj 	
publicll 
voidll 
DeleteLobbyll 
(ll  
intll  #
lobbyIdll$ +
)ll+ ,
{mm 	
trynn 
{oo 
varpp 
lobbypp 
=pp 
GetByIdpp #
(pp# $
lobbyIdpp$ +
)pp+ ,
;pp, -
ifqq 
(qq 
lobbyqq 
!=qq 
nullqq !
)qq! "
{rr 
_contextss 
.ss 
	GameLobbyss &
.ss& '
Removess' -
(ss- .
lobbyss. 3
)ss3 4
;ss4 5
_contexttt 
.tt 
SaveChangestt (
(tt( )
)tt) *
;tt* +
}uu 
}vv 
catchww 
(ww 
SqlExceptionww 
exww  "
)ww" #
{xx 
throwyy 
newyy 
DataAccessExceptionyy -
(yy- .
$stryy. \
,yy\ ]
exyy^ `
)yy` a
;yya b
}zz 
catch{{ 
({{ 
	Exception{{ 
ex{{ 
){{  
{|| 
throw}} 
new}} 
DataAccessException}} -
(}}- .
$str}}. f
,}}f g
ex}}h j
)}}j k
;}}k l
}~~ 
} 	
public
ÅÅ 
void
ÅÅ 
UpdateLobby
ÅÅ 
(
ÅÅ  
	GameLobby
ÅÅ  )
lobby
ÅÅ* /
)
ÅÅ/ 0
{
ÇÇ 	
if
ÉÉ 
(
ÉÉ 
lobby
ÉÉ 
==
ÉÉ 
null
ÉÉ 
)
ÉÉ 
throw
ÑÑ 
new
ÑÑ #
ArgumentNullException
ÑÑ /
(
ÑÑ/ 0
nameof
ÑÑ0 6
(
ÑÑ6 7
lobby
ÑÑ7 <
)
ÑÑ< =
,
ÑÑ= >
$str
ÑÑ? V
)
ÑÑV W
;
ÑÑW X
try
ÜÜ 
{
áá 
var
àà 
existingLobby
àà !
=
àà" #
GetById
àà$ +
(
àà+ ,
lobby
àà, 1
.
àà1 2
LobbyID
àà2 9
)
àà9 :
;
àà: ;
if
ââ 
(
ââ 
existingLobby
ââ !
!=
ââ" $
null
ââ% )
)
ââ) *
{
ää 
existingLobby
ãã !
.
ãã! "
	LobbyName
ãã" +
=
ãã, -
lobby
ãã. 3
.
ãã3 4
	LobbyName
ãã4 =
;
ãã= >
existingLobby
åå !
.
åå! "
Password
åå" *
=
åå+ ,
lobby
åå- 2
.
åå2 3
Password
åå3 ;
;
åå; <
existingLobby
çç !
.
çç! "
HostID
çç" (
=
çç) *
lobby
çç+ 0
.
çç0 1
HostID
çç1 7
;
çç7 8
_context
éé 
.
éé 
SaveChanges
éé (
(
éé( )
)
éé) *
;
éé* +
}
èè 
}
êê 
catch
ëë 
(
ëë 
SqlException
ëë 
ex
ëë  "
)
ëë" #
{
íí 
throw
ìì 
new
ìì !
DataAccessException
ìì -
(
ìì- .
$str
ìì. \
,
ìì\ ]
ex
ìì^ `
)
ìì` a
;
ììa b
}
îî 
catch
ïï 
(
ïï 
	Exception
ïï 
ex
ïï 
)
ïï  
{
ññ 
throw
óó 
new
óó !
DataAccessException
óó -
(
óó- .
$str
óó. f
,
óóf g
ex
óóh j
)
óój k
;
óók l
}
òò 
}
ôô 	
public
õõ 
IEnumerable
õõ 
<
õõ 
	GameLobby
õõ $
>
õõ$ %
GetAllLobbies
õõ& 3
(
õõ3 4
)
õõ4 5
{
úú 	
try
ùù 
{
ûû 
return
üü 
_context
üü 
.
üü  
	GameLobby
üü  )
.
üü) *
ToList
üü* 0
(
üü0 1
)
üü1 2
;
üü2 3
}
†† 
catch
°° 
(
°° 
SqlException
°° 
ex
°°  "
)
°°" #
{
¢¢ 
throw
££ 
new
££ !
DataAccessException
££ -
(
££- .
$str
££. `
,
££` a
ex
££b d
)
££d e
;
££e f
}
§§ 
catch
•• 
(
•• 
	Exception
•• 
ex
•• 
)
••  
{
¶¶ 
throw
ßß 
new
ßß !
DataAccessException
ßß -
(
ßß- .
$str
ßß. j
,
ßßj k
ex
ßßl n
)
ßßn o
;
ßßo p
}
®® 
}
©© 	
public
´´ 
IEnumerable
´´ 
<
´´ 
	GameLobby
´´ $
>
´´$ %
GetPublicLobbies
´´& 6
(
´´6 7
)
´´7 8
{
¨¨ 	
try
≠≠ 
{
ÆÆ 
return
ØØ 
_context
ØØ 
.
ØØ  
	GameLobby
ØØ  )
.
ØØ) *
Where
ØØ* /
(
ØØ/ 0
l
ØØ0 1
=>
ØØ2 4
string
ØØ5 ;
.
ØØ; <
IsNullOrEmpty
ØØ< I
(
ØØI J
l
ØØJ K
.
ØØK L
Password
ØØL T
)
ØØT U
)
ØØU V
.
ØØV W
ToList
ØØW ]
(
ØØ] ^
)
ØØ^ _
;
ØØ_ `
}
∞∞ 
catch
±± 
(
±± 
SqlException
±± 
ex
±±  "
)
±±" #
{
≤≤ 
throw
≥≥ 
new
≥≥ !
DataAccessException
≥≥ -
(
≥≥- .
$str
≥≥. c
,
≥≥c d
ex
≥≥e g
)
≥≥g h
;
≥≥h i
}
¥¥ 
catch
µµ 
(
µµ 
	Exception
µµ 
ex
µµ 
)
µµ  
{
∂∂ 
throw
∑∑ 
new
∑∑ !
DataAccessException
∑∑ -
(
∑∑- .
$str
∑∑. m
,
∑∑m n
ex
∑∑o q
)
∑∑q r
;
∑∑r s
}
∏∏ 
}
ππ 	
}
∫∫ 
}ªª ˙8
tC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\ChatMessagesRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{		 
public

 

class

 "
ChatMessagesRepository

 '
:

( )#
IChatMessagesRepository

* A
{ 
private 
readonly 
BMCEntities $
_context% -
;- .
public "
ChatMessagesRepository %
(% &
BMCEntities& 1
context2 9
)9 :
{ 	
_context 
= 
context 
; 
} 	
public 
IEnumerable 
< 
ChatMessages '
>' (%
GetMessagesBetweenPlayers) B
(B C
intC F
	player1IdG P
,P Q
intR U
	player2IdV _
)_ `
{ 	
if 
( 
	player1Id 
<= 
$num 
|| !
	player2Id" +
<=, .
$num/ 0
)0 1
{ 
throw 
new 
ArgumentException +
(+ ,
$str, S
)S T
;T U
} 
try 
{ 
return 
_context 
.  
ChatMessages  ,
. 
Where 
( 
cm 
=>  
(! "
cm" $
.$ %
SenderID% -
==. 0
	player1Id1 :
&&; =
cm> @
.@ A

ReceiverIDA K
==L N
	player2IdO X
)X Y
||Z \
(! "
cm" $
.$ %
SenderID% -
==. 0
	player2Id1 :
&&; =
cm> @
.@ A

ReceiverIDA K
==L N
	player1IdO X
)X Y
)Y Z
. 
OrderBy 
( 
cm 
=>  "
cm# %
.% &
	Timestamp& /
)/ 0
.   
ToList   
(   
)   
;   
}!! 
catch"" 
("" 
SqlException"" 
)""  
{## 
throw$$ 
;$$ 
}%% 
catch&& 
(&& 
	Exception&& 
ex&& 
)&&  
{'' 
throw(( 
new(( 
DataAccessException(( -
(((- .
$str((. w
,((w x
ex((y {
)(({ |
;((| }
})) 
}** 	
public,, 
IEnumerable,, 
<,, 
ChatMessages,, '
>,,' (
GetRecentMessages,,) :
(,,: ;
int,,; >
playerId,,? G
,,,G H
int,,I L
limit,,M R
),,R S
{-- 	
if.. 
(.. 
playerId.. 
<=.. 
$num.. 
).. 
{// 
throw00 
new00 
ArgumentException00 +
(00+ ,
$str00, R
,00R S
nameof00T Z
(00Z [
playerId00[ c
)00c d
)00d e
;00e f
}11 
if33 
(33 
limit33 
<=33 
$num33 
)33 
{44 
throw55 
new55 
ArgumentException55 +
(55+ ,
$str55, N
,55N O
nameof55P V
(55V W
limit55W \
)55\ ]
)55] ^
;55^ _
}66 
try88 
{99 
return:: 
_context:: 
.::  
ChatMessages::  ,
.;; 
Where;; 
(;; 
cm;; 
=>;;  
cm;;! #
.;;# $

ReceiverID;;$ .
==;;/ 1
playerId;;2 :
||;;; =
cm;;> @
.;;@ A
SenderID;;A I
==;;J L
playerId;;M U
);;U V
.<< 
OrderByDescending<< &
(<<& '
cm<<' )
=><<* ,
cm<<- /
.<</ 0
	Timestamp<<0 9
)<<9 :
.== 
Take== 
(== 
limit== 
)==  
.>> 
ToList>> 
(>> 
)>> 
;>> 
}?? 
catch@@ 
(@@ 
SqlException@@ 
)@@  
{AA 
throwBB 
;BB 
}CC 
catchDD 
(DD 
	ExceptionDD 
exDD 
)DD  
{EE 
throwFF 
newFF 
DataAccessExceptionFF -
(FF- .
$strFF. n
,FFn o
exFFp r
)FFr s
;FFs t
}GG 
}HH 	
publicJJ 
voidJJ 

AddMessageJJ 
(JJ 
intJJ "
senderIdJJ# +
,JJ+ ,
intJJ- 0

receiverIdJJ1 ;
,JJ; <
stringJJ= C
messageTextJJD O
)JJO P
{KK 	
ifLL 
(LL 
senderIdLL 
<=LL 
$numLL 
||LL  

receiverIdLL! +
<=LL, .
$numLL/ 0
)LL0 1
{MM 
throwNN 
newNN 
ArgumentExceptionNN +
(NN+ ,
$strNN, `
)NN` a
;NNa b
}OO 
ifQQ 
(QQ 
stringQQ 
.QQ 
IsNullOrWhiteSpaceQQ )
(QQ) *
messageTextQQ* 5
)QQ5 6
)QQ6 7
{RR 
throwSS 
newSS 
ArgumentExceptionSS +
(SS+ ,
$strSS, Y
)SSY Z
;SSZ [
}TT 
tryVV 
{WW 
varXX 
messageXX 
=XX 
newXX !
ChatMessagesXX" .
{YY 
SenderIDZZ 
=ZZ 
senderIdZZ '
,ZZ' (

ReceiverID[[ 
=[[  

receiverId[[! +
,[[+ ,
MessageText\\ 
=\\  !
messageText\\" -
,\\- .
	Timestamp]] 
=]] 
DateTime]]  (
.]]( )
Now]]) ,
}^^ 
;^^ 
_context`` 
.`` 
ChatMessages`` %
.``% &
Add``& )
(``) *
message``* 1
)``1 2
;``2 3
_contextaa 
.aa 
SaveChangesaa $
(aa$ %
)aa% &
;aa& '
}bb 
catchcc 
(cc 
DbUpdateExceptioncc $
excc% '
)cc' (
{dd 
throwee 
newee 
DataAccessExceptionee -
(ee- .
$stree. ]
,ee] ^
exee_ a
)eea b
;eeb c
}ff 
catchgg 
(gg 
SqlExceptiongg 
)gg  
{hh 
throwii 
;ii 
}jj 
catchkk 
(kk 
	Exceptionkk 
exkk 
)kk  
{ll 
throwmm 
newmm 
DataAccessExceptionmm -
(mm- .
$strmm. k
,mmk l
exmmm o
)mmo p
;mmp q
}nn 
}oo 	
}pp 
}qq  
rC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\IGameLobbyRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

	interface  
IGameLobbyRepository )
{ 
void 
CreateLobby 
( 
	GameLobby "
lobby# (
)( )
;) *
	GameLobby 
GetByLobbyName  
(  !
string! '
	lobbyName( 1
)1 2
;2 3
	GameLobby		 
GetById		 
(		 
int		 
lobbyId		 %
)		% &
;		& '
bool

 
IsLobbyPrivate

 
(

 
int

 
lobbyId

  '
)

' (
;

( )
bool 
VerifyLobbyPassword  
(  !
int! $
lobbyId% ,
,, -
string. 4
password5 =
)= >
;> ?
void 
DeleteLobby 
( 
int 
lobbyId $
)$ %
;% &
void 
UpdateLobby 
( 
	GameLobby "
lobby# (
)( )
;) *
IEnumerable 
< 
	GameLobby 
> 
GetAllLobbies ,
(, -
)- .
;. /
IEnumerable 
< 
	GameLobby 
> 
GetPublicLobbies /
(/ 0
)0 1
;1 2
} 
} ŒL
tC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\LobbyPlayersRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{		 
public

 

class

 "
LobbyPlayersRepository

 '
:

( )#
ILobbyPlayersRepository

* A
{ 
private 
readonly 
BMCEntities $
_context% -
;- .
public "
LobbyPlayersRepository %
(% &
BMCEntities& 1
context2 9
)9 :
{ 	
_context 
= 
context 
; 
} 	
public 
void 
AddPlayerToLobby $
($ %
int% (
lobbyId) 0
,0 1
int2 5
playerId6 >
)> ?
{ 	
if 
( 
IsLobbyFull 
( 
lobbyId #
)# $
)$ %
{ 
throw 
new %
InvalidOperationException 3
(3 4
$str4 ]
)] ^
;^ _
} 
var 
lobbyPlayer 
= 
new !
LobbyPlayers" .
{ 
LobbyID 
= 
lobbyId !
,! "
PlayerID 
= 
playerId #
,# $
PlayerStatus 
= 
$str *
} 
; 
try!! 
{"" 
_context## 
.## 
LobbyPlayers## %
.##% &
Add##& )
(##) *
lobbyPlayer##* 5
)##5 6
;##6 7
_context$$ 
.$$ 
SaveChanges$$ $
($$$ %
)$$% &
;$$& '
}%% 
catch&& 
(&& 
SqlException&& 
)&&  
{'' 
throw(( 
;(( 
})) 
catch** 
(** 
	Exception** 
ex** 
)**  
{++ 
throw,, 
new,, 
DataAccessException,, -
(,,- .
$str,,. r
,,,r s
ex,,t v
),,v w
;,,w x
}-- 
}.. 	
public00 
void00 !
RemovePlayerFromLobby00 )
(00) *
int00* -
lobbyId00. 5
,005 6
int007 :
playerId00; C
)00C D
{11 	
var22 
lobbyPlayer22 
=22 
_context22 &
.22& '
LobbyPlayers22' 3
.33 
FirstOrDefault33 
(33  
lp33  "
=>33# %
lp33& (
.33( )
LobbyID33) 0
==331 3
lobbyId334 ;
&&33< >
lp33? A
.33A B
PlayerID33B J
==33K M
playerId33N V
)33V W
;33W X
if55 
(55 
lobbyPlayer55 
!=55 
null55 #
)55# $
{66 
try77 
{88 
_context99 
.99 
LobbyPlayers99 )
.99) *
Remove99* 0
(990 1
lobbyPlayer991 <
)99< =
;99= >
_context:: 
.:: 
SaveChanges:: (
(::( )
)::) *
;::* +
};; 
catch<< 
(<< 
SqlException<< #
)<<# $
{== 
throw>> 
;>> 
}?? 
catch@@ 
(@@ 
	Exception@@  
ex@@! #
)@@# $
{AA 
throwBB 
newBB 
DataAccessExceptionBB 1
(BB1 2
$strBB2 z
,BBz {
exBB| ~
)BB~ 
;	BB Ä
}CC 
}DD 
}EE 	
publicGG 
IEnumerableGG 
<GG 
LobbyPlayersGG '
>GG' (
GetPlayersInLobbyGG) :
(GG: ;
intGG; >
lobbyIdGG? F
)GGF G
{HH 	
tryII 
{JJ 
returnKK 
_contextKK 
.KK  
LobbyPlayersKK  ,
.LL 
WhereLL 
(LL 
lpLL 
=>LL  
lpLL! #
.LL# $
LobbyIDLL$ +
==LL, .
lobbyIdLL/ 6
)LL6 7
.MM 
IncludeMM 
(MM 
lpMM 
=>MM  "
lpMM# %
.MM% &
PlayerMM& ,
)MM, -
.NN 
ToListNN 
(NN 
)NN 
;NN 
}OO 
catchPP 
(PP 
SqlExceptionPP 
)PP  
{QQ 
throwRR 
;RR 
}SS 
catchTT 
(TT 
	ExceptionTT 
exTT 
)TT  
{UU 
throwVV 
newVV 
DataAccessExceptionVV -
(VV- .
$strVV. q
,VVq r
exVVs u
)VVu v
;VVv w
}WW 
}XX 	
publicZZ 
boolZZ 
IsPlayerInLobbyZZ #
(ZZ# $
intZZ$ '
lobbyIdZZ( /
,ZZ/ 0
intZZ1 4
playerIdZZ5 =
)ZZ= >
{[[ 	
try\\ 
{]] 
return^^ 
_context^^ 
.^^  
LobbyPlayers^^  ,
.__ 
Any__ 
(__ 
lp__ 
=>__ 
lp__ !
.__! "
LobbyID__" )
==__* ,
lobbyId__- 4
&&__5 7
lp__8 :
.__: ;
PlayerID__; C
==__D F
playerId__G O
)__O P
;__P Q
}`` 
catchaa 
(aa 
SqlExceptionaa 
)aa  
{bb 
throwcc 
;cc 
}dd 
catchee 
(ee 
	Exceptionee 
exee 
)ee  
{ff 
throwgg 
newgg 
DataAccessExceptiongg -
(gg- .
$strgg. v
,ggv w
exggx z
)ggz {
;gg{ |
}hh 
}ii 	
publickk 
boolkk 
IsLobbyFullkk 
(kk  
intkk  #
lobbyIdkk$ +
)kk+ ,
{ll 	
trymm 
{nn 
returnoo 
_contextoo 
.oo  
LobbyPlayersoo  ,
.pp 
Countpp 
(pp 
lppp 
=>pp  
lppp! #
.pp# $
LobbyIDpp$ +
==pp, .
lobbyIdpp/ 6
)pp6 7
>=pp8 :
$numpp; <
;pp< =
}qq 
catchrr 
(rr 
SqlExceptionrr 
)rr  
{ss 
throwtt 
;tt 
}uu 
catchvv 
(vv 
	Exceptionvv 
exvv 
)vv  
{ww 
throwxx 
newxx 
DataAccessExceptionxx -
(xx- .
$strxx. q
,xxq r
exxxs u
)xxu v
;xxv w
}yy 
}zz 	
public|| 
int|| %
GetNumberOfPlayersInLobby|| ,
(||, -
int||- 0
lobbyId||1 8
)||8 9
{}} 	
try~~ 
{ 
return
ÄÄ 
_context
ÄÄ 
.
ÄÄ  
LobbyPlayers
ÄÄ  ,
.
ÄÄ, -
Count
ÄÄ- 2
(
ÄÄ2 3
lp
ÄÄ3 5
=>
ÄÄ6 8
lp
ÄÄ9 ;
.
ÄÄ; <
LobbyID
ÄÄ< C
==
ÄÄD F
lobbyId
ÄÄG N
)
ÄÄN O
;
ÄÄO P
}
ÅÅ 
catch
ÇÇ 
(
ÇÇ 
SqlException
ÇÇ 
)
ÇÇ  
{
ÉÉ 
throw
ÑÑ 
;
ÑÑ 
}
ÖÖ 
catch
ÜÜ 
(
ÜÜ 
	Exception
ÜÜ 
ex
ÜÜ 
)
ÜÜ  
{
áá 
throw
àà 
new
àà !
DataAccessException
àà -
(
àà- .
$str
àà. ~
,
àà~ 
exààÄ Ç
)ààÇ É
;ààÉ Ñ
}
ââ 
}
ää 	
public
åå 
void
åå  
UpdatePlayerStatus
åå &
(
åå& '
int
åå' *
lobbyId
åå+ 2
,
åå2 3
int
åå4 7
playerId
åå8 @
,
åå@ A
string
ååB H
status
ååI O
)
ååO P
{
çç 	
var
éé 
lobbyPlayer
éé 
=
éé 
_context
éé &
.
éé& '
LobbyPlayers
éé' 3
.
èè 
FirstOrDefault
èè 
(
èè  
lp
èè  "
=>
èè# %
lp
èè& (
.
èè( )
LobbyID
èè) 0
==
èè1 3
lobbyId
èè4 ;
&&
èè< >
lp
èè? A
.
èèA B
PlayerID
èèB J
==
èèK M
playerId
èèN V
)
èèV W
;
èèW X
if
ëë 
(
ëë 
lobbyPlayer
ëë 
!=
ëë 
null
ëë #
)
ëë# $
{
íí 
try
ìì 
{
îî 
lobbyPlayer
ïï 
.
ïï  
PlayerStatus
ïï  ,
=
ïï- .
status
ïï/ 5
;
ïï5 6
_context
ññ 
.
ññ 
SaveChanges
ññ (
(
ññ( )
)
ññ) *
;
ññ* +
}
óó 
catch
òò 
(
òò 
SqlException
òò #
)
òò# $
{
ôô 
throw
öö 
;
öö 
}
õõ 
catch
úú 
(
úú 
	Exception
úú  
ex
úú! #
)
úú# $
{
ùù 
throw
ûû 
new
ûû !
DataAccessException
ûû 1
(
ûû1 2
$str
ûû2 n
,
ûûn o
ex
ûûp r
)
ûûr s
;
ûûs t
}
üü 
}
†† 
}
°° 	
}
¢¢ 
}££ ¬
uC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\IChatMessagesRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

	interface #
IChatMessagesRepository ,
{ 
IEnumerable 
< 
ChatMessages  
>  !%
GetMessagesBetweenPlayers" ;
(; <
int< ?
	player1Id@ I
,I J
intK N
	player2IdO X
)X Y
;Y Z
IEnumerable 
< 
ChatMessages  
>  !
GetRecentMessages" 3
(3 4
int4 7
playerId8 @
,@ A
intB E
limitF K
)K L
;L M
void		 

AddMessage		 
(		 
int		 
senderId		 $
,		$ %
int		& )

receiverId		* 4
,		4 5
string		6 <
messageText		= H
)		H I
;		I J
}

 
} ﬁ
pC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\IProfileRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

	interface 
IProfileRepository '
{ 
Profile  
GetProfileByPlayerId $
($ %
int% (
playerId) 1
)1 2
;2 3
void 
Add 
( 
Profile 
profile  
)  !
;! "
void		 
Update		 
(		 
Profile		 
profile		 #
)		# $
;		$ %
void

 
SetLastVisit

 
(

 
int

 
playerId

 &
,

& '
DateTime

( 0
lastVisitDate

1 >
)

> ?
;

? @
void 
Save 
( 
) 
; 
} 
} Ñ
vC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\IFriendRequestRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public		 

	interface		 $
IFriendRequestRepository		 -
{

 
void 
SendFriendRequest 
( 
int "
senderPlayerId# 1
,1 2
int3 6
receiverPlayerId7 G
)G H
;H I
bool "
IsFriendRequestPending #
(# $
int$ '
senderPlayerId( 6
,6 7
int8 ;
receiverPlayerId< L
)L M
;M N
IEnumerable 
< 
FriendRequest !
>! "
GetReceivedRequests# 6
(6 7
int7 :
receiverPlayerId; K
)K L
;L M
IEnumerable 
< 
FriendRequest !
>! "
GetSentRequests# 2
(2 3
int3 6
senderPlayerId7 E
)E F
;F G
void 
AcceptRequest 
( 
int 
	requestId (
)( )
;) *
void 
RejectRequest 
( 
int 
	requestId (
)( )
;) *
void 
RemoveFriend 
( 
int 
userId $
,$ %
int& )
friendId* 2
)2 3
;3 4
IEnumerable 
< 
Player 
> 
GetAcceptedFriends .
(. /
int/ 2
playerId3 ;
); <
;< =
bool 

AreFriends 
( 
int 
	player1Id %
,% &
int' *
	player2Id+ 4
)4 5
;5 6
void 
Save 
( 
) 
; 
} 
} ¬
uC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\ILobbyPlayersRepository.cs
	namespace 	

DataAccess
 
. 
Repositories !
{ 
public 

	interface #
ILobbyPlayersRepository ,
{ 
void 
AddPlayerToLobby 
( 
int !
lobbyId" )
,) *
int+ .
playerId/ 7
)7 8
;8 9
void !
RemovePlayerFromLobby "
(" #
int# &
lobbyId' .
,. /
int0 3
playerId4 <
)< =
;= >
IEnumerable		 
<		 
LobbyPlayers		  
>		  !
GetPlayersInLobby		" 3
(		3 4
int		4 7
lobbyId		8 ?
)		? @
;		@ A
bool

 
IsPlayerInLobby

 
(

 
int

  
lobbyId

! (
,

( )
int

* -
playerId

. 6
)

6 7
;

7 8
bool 
IsLobbyFull 
( 
int 
lobbyId $
)$ %
;% &
int %
GetNumberOfPlayersInLobby %
(% &
int& )
lobbyId* 1
)1 2
;2 3
void 
UpdatePlayerStatus 
(  
int  #
lobbyId$ +
,+ ,
int- 0
playerId1 9
,9 :
string; A
statusB H
)H I
;I J
} 
} ®Å
uC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Repositories\FriendRequestRepository.cs
	namespace		 	

DataAccess		
 
.		 
Repositories		 !
{

 
public 

class #
FriendRequestRepository (
:) *$
IFriendRequestRepository+ C
{ 
private 
readonly 
BMCEntities $
_context% -
;- .
public #
FriendRequestRepository &
(& '
BMCEntities' 2
context3 :
): ;
{ 	
_context 
= 
context 
; 
} 	
public 
void 
AcceptRequest !
(! "
int" %
	requestId& /
)/ 0
{ 	
try 
{ 
var 
request 
= 
_context &
.& '
FriendRequest' 4
.4 5
SingleOrDefault5 D
(D E
rE F
=>G I
rJ K
.K L
	RequestIDL U
==V X
	requestIdY b
)b c
;c d
if 
( 
request 
== 
null #
)# $
{ 
throw 
new %
InvalidOperationException 7
(7 8
$"8 :
$str: Z
{Z [
	requestId[ d
}d e
$stre f
"f g
)g h
;h i
} 
request 
. 
RequestStatus %
=& '
$str( 2
;2 3
}   
catch!! 
(!! 
DbUpdateException!! $
ex!!% '
)!!' (
{"" 
throw## 
new## 
DataAccessException## -
(##- .
$str##. u
,##u v
ex##w y
)##y z
;##z {
}$$ 
catch%% 
(%% 
SqlException%% 
)%%  
{&& 
throw'' 
;'' 
}(( 
catch)) 
()) 
	Exception)) 
ex)) 
)))  
{** 
throw++ 
new++ 
DataAccessException++ -
(++- .
$str++. p
,++p q
ex++r t
)++t u
;++u v
},, 
}-- 	
public// 
IEnumerable// 
<// 
Player// !
>//! "
GetAcceptedFriends//# 5
(//5 6
int//6 9
playerId//: B
)//B C
{00 	
if11 
(11 
playerId11 
<=11 
$num11 
)11 
{22 
throw33 
new33 
ArgumentException33 +
(33+ ,
$str33, R
,33R S
nameof33T Z
(33Z [
playerId33[ c
)33c d
)33d e
;33e f
}44 
try66 
{77 
var88 
acceptedRequests88 $
=88% &
_context88' /
.88/ 0
FriendRequest880 =
.99 
Where99 
(99 
r99 
=>99 
(99  !
r99! "
.99" #
SenderPlayerID99# 1
==992 4
playerId995 =
||99> @
r99A B
.99B C
ReceiverPlayerID99C S
==99T V
playerId99W _
)99_ `
&&99a c
r99d e
.99e f
RequestStatus99f s
==99t v
$str	99w Å
)
99Å Ç
.:: 
Select:: 
(:: 
r:: 
=>::  
r::! "
.::" #
SenderPlayerID::# 1
==::2 4
playerId::5 =
?::> ?
r::@ A
.::A B
Player::B H
:::I J
r::K L
.::L M
Player1::M T
)::T U
.;; 
ToList;; 
(;; 
);; 
;;; 
return== 
acceptedRequests== '
;==' (
}>> 
catch?? 
(?? 
SqlException?? 
)??  
{@@ 
throwAA 
;AA 
}BB 
catchCC 
(CC %
InvalidOperationExceptionCC ,
exCC- /
)CC/ 0
{DD 
throwEE 
newEE 
DataAccessExceptionEE -
(EE- .
$strEE. d
,EEd e
exEEf h
)EEh i
;EEi j
}FF 
catchGG 
(GG 
	ExceptionGG 
exGG 
)GG  
{HH 
throwII 
newII 
DataAccessExceptionII -
(II- .
$strII. o
,IIo p
exIIq s
)IIs t
;IIt u
}JJ 
}KK 	
publicMM 
IEnumerableMM 
<MM 
FriendRequestMM (
>MM( )
GetReceivedRequestsMM* =
(MM= >
intMM> A
receiverPlayerIdMMB R
)MMR S
{NN 	
tryOO 
{PP 
returnQQ 
_contextQQ 
.QQ  
FriendRequestQQ  -
.QQ- .
WhereQQ. 3
(QQ3 4
rQQ4 5
=>QQ6 8
rQQ9 :
.QQ: ;
ReceiverPlayerIDQQ; K
==QQL N
receiverPlayerIdQQO _
&&QQ` b
rQQc d
.QQd e
RequestStatusQQe r
==QQs u
$strQQv 
)	QQ Ä
.
QQÄ Å
ToList
QQÅ á
(
QQá à
)
QQà â
;
QQâ ä
}RR 
catchSS 
(SS 
SqlExceptionSS 
)SS  
{TT 
throwUU 
;UU 
}VV 
catchWW 
(WW 
	ExceptionWW 
exWW 
)WW  
{XX 
throwYY 
newYY 
DataAccessExceptionYY -
(YY- .
$strYY. w
,YYw x
exYYy {
)YY{ |
;YY| }
}ZZ 
}[[ 	
public]] 
bool]] 

AreFriends]] 
(]] 
int]] "
	player1Id]]# ,
,]], -
int]]. 1
	player2Id]]2 ;
)]]; <
{^^ 	
try__ 
{`` 
returnaa 
_contextaa 
.aa  
FriendRequestaa  -
.aa- .
Anyaa. 1
(aa1 2
raa2 3
=>aa4 6
(bb 
(bb 
rbb 
.bb 
SenderPlayerIDbb &
==bb' )
	player1Idbb* 3
&&bb4 6
rbb7 8
.bb8 9
ReceiverPlayerIDbb9 I
==bbJ L
	player2IdbbM V
)bbV W
||bbX Z
(cc 
rcc 
.cc 
SenderPlayerIDcc &
==cc' )
	player2Idcc* 3
&&cc4 6
rcc7 8
.cc8 9
ReceiverPlayerIDcc9 I
==ccJ L
	player1IdccM V
)ccV W
)ccW X
&&ccY [
rdd 
.dd 
RequestStatusdd #
==dd$ &
$strdd' 1
)dd1 2
;dd2 3
}ee 
catchff 
(ff 
SqlExceptionff 
exff  "
)ff" #
{gg 
throwhh 
newhh 
DataAccessExceptionhh -
(hh- .
$strhh. `
,hh` a
exhhb d
)hhd e
;hhe f
}ii 
catchjj 
(jj 
	Exceptionjj 
exjj 
)jj  
{kk 
throwll 
newll 
DataAccessExceptionll -
(ll- .
$strll. n
,lln o
exllp r
)llr s
;lls t
}mm 
}nn 	
publicpp 
IEnumerablepp 
<pp 
FriendRequestpp (
>pp( )
GetSentRequestspp* 9
(pp9 :
intpp: =
senderPlayerIdpp> L
)ppL M
{qq 	
tryrr 
{ss 
returntt 
_contexttt 
.tt  
FriendRequesttt  -
.tt- .
Wherett. 3
(tt3 4
rtt4 5
=>tt6 8
rtt9 :
.tt: ;
SenderPlayerIDtt; I
==ttJ L
senderPlayerIdttM [
)tt[ \
.tt\ ]
ToListtt] c
(ttc d
)ttd e
;tte f
}uu 
catchvv 
(vv 
SqlExceptionvv 
)vv  
{ww 
throwxx 
;xx 
}yy 
catchzz 
(zz 
	Exceptionzz 
exzz 
)zz  
{{{ 
throw|| 
new|| 
DataAccessException|| -
(||- .
$str||. s
,||s t
ex||u w
)||w x
;||x y
}}} 
}~~ 	
public
ÄÄ 
bool
ÄÄ $
IsFriendRequestPending
ÄÄ *
(
ÄÄ* +
int
ÄÄ+ .
senderPlayerId
ÄÄ/ =
,
ÄÄ= >
int
ÄÄ? B
receiverPlayerId
ÄÄC S
)
ÄÄS T
{
ÅÅ 	
try
ÇÇ 
{
ÉÉ 
return
ÑÑ 
_context
ÑÑ 
.
ÑÑ  
FriendRequest
ÑÑ  -
.
ÑÑ- .
Any
ÑÑ. 1
(
ÑÑ1 2
r
ÑÑ2 3
=>
ÑÑ4 6
r
ÖÖ 
.
ÖÖ 
SenderPlayerID
ÖÖ $
==
ÖÖ% '
senderPlayerId
ÖÖ( 6
&&
ÖÖ7 9
r
ÜÜ 
.
ÜÜ 
ReceiverPlayerID
ÜÜ &
==
ÜÜ' )
receiverPlayerId
ÜÜ* :
&&
ÜÜ; =
r
áá 
.
áá 
RequestStatus
áá #
==
áá$ &
$str
áá' 0
)
áá0 1
;
áá1 2
}
àà 
catch
ââ 
(
ââ 
SqlException
ââ 
)
ââ  
{
ää 
throw
ãã 
;
ãã 
}
åå 
catch
çç 
(
çç 
	Exception
çç 
ex
çç 
)
çç  
{
éé 
throw
èè 
new
èè !
DataAccessException
èè -
(
èè- .
$str
èè. w
,
èèw x
ex
èèy {
)
èè{ |
;
èè| }
}
êê 
}
ëë 	
public
ìì 
void
ìì 
RejectRequest
ìì !
(
ìì! "
int
ìì" %
	requestId
ìì& /
)
ìì/ 0
{
îî 	
try
ïï 
{
ññ 
var
óó 
request
óó 
=
óó 
_context
óó &
.
óó& '
FriendRequest
óó' 4
.
óó4 5
SingleOrDefault
óó5 D
(
óóD E
r
óóE F
=>
óóG I
r
óóJ K
.
óóK L
	RequestID
óóL U
==
óóV X
	requestId
óóY b
)
óób c
;
óóc d
if
ôô 
(
ôô 
request
ôô 
==
ôô 
null
ôô #
)
ôô# $
{
öö 
throw
õõ 
new
õõ '
InvalidOperationException
õõ 7
(
õõ7 8
$"
õõ8 :
$str
õõ: Z
{
õõZ [
	requestId
õõ[ d
}
õõd e
$str
õõe f
"
õõf g
)
õõg h
;
õõh i
}
úú 
request
ûû 
.
ûû 
RequestStatus
ûû %
=
ûû& '
$str
ûû( 2
;
ûû2 3
}
üü 
catch
†† 
(
†† 
DbUpdateException
†† $
ex
††% '
)
††' (
{
°° 
throw
¢¢ 
new
¢¢ !
DataAccessException
¢¢ -
(
¢¢- .
$str
¢¢. t
,
¢¢t u
ex
¢¢v x
)
¢¢x y
;
¢¢y z
}
££ 
catch
§§ 
(
§§ 
SqlException
§§ 
)
§§  
{
•• 
throw
¶¶ 
;
¶¶ 
}
ßß 
catch
®® 
(
®® 
	Exception
®® 
ex
®® 
)
®®  
{
©© 
throw
™™ 
new
™™ !
DataAccessException
™™ -
(
™™- .
$str
™™. p
,
™™p q
ex
™™r t
)
™™t u
;
™™u v
}
´´ 
}
¨¨ 	
public
ÆÆ 
void
ÆÆ 
RemoveFriend
ÆÆ  
(
ÆÆ  !
int
ÆÆ! $
userId
ÆÆ% +
,
ÆÆ+ ,
int
ÆÆ- 0
friendId
ÆÆ1 9
)
ÆÆ9 :
{
ØØ 	
try
∞∞ 
{
±± 
var
≤≤ 
acceptedRequest
≤≤ #
=
≤≤$ %
_context
≤≤& .
.
≤≤. /
FriendRequest
≤≤/ <
.
≥≥ 
FirstOrDefault
≥≥ #
(
≥≥# $
r
≥≥$ %
=>
≥≥& (
(
¥¥ 
(
¥¥ 
r
¥¥ 
.
¥¥ 
SenderPlayerID
¥¥ *
==
¥¥+ -
userId
¥¥. 4
&&
¥¥5 7
r
¥¥8 9
.
¥¥9 :
ReceiverPlayerID
¥¥: J
==
¥¥K M
friendId
¥¥N V
)
¥¥V W
||
¥¥X Z
(
µµ 
r
µµ 
.
µµ 
SenderPlayerID
µµ )
==
µµ* ,
friendId
µµ- 5
&&
µµ6 8
r
µµ9 :
.
µµ: ;
ReceiverPlayerID
µµ; K
==
µµL N
userId
µµO U
)
µµU V
)
µµV W
&&
µµX Z
r
∂∂ 
.
∂∂ 
RequestStatus
∂∂ '
==
∂∂( *
$str
∂∂+ 5
)
∂∂5 6
;
∂∂6 7
if
∏∏ 
(
∏∏ 
acceptedRequest
∏∏ #
==
∏∏$ &
null
∏∏' +
)
∏∏+ ,
{
ππ 
throw
∫∫ 
new
∫∫ '
InvalidOperationException
∫∫ 7
(
∫∫7 8
$str
∫∫8 o
)
∫∫o p
;
∫∫p q
}
ªª 
_context
ΩΩ 
.
ΩΩ 
FriendRequest
ΩΩ &
.
ΩΩ& '
Remove
ΩΩ' -
(
ΩΩ- .
acceptedRequest
ΩΩ. =
)
ΩΩ= >
;
ΩΩ> ?
}
ææ 
catch
øø 
(
øø 
DbUpdateException
øø $
ex
øø% '
)
øø' (
{
¿¿ 
throw
¡¡ 
new
¡¡ !
DataAccessException
¡¡ -
(
¡¡- .
$str
¡¡. q
,
¡¡q r
ex
¡¡s u
)
¡¡u v
;
¡¡v w
}
¬¬ 
catch
√√ 
(
√√ 
SqlException
√√ 
)
√√  
{
ƒƒ 
throw
≈≈ 
;
≈≈ 
}
∆∆ 
catch
«« 
(
«« 
	Exception
«« 
ex
«« 
)
««  
{
»» 
throw
…… 
new
…… !
DataAccessException
…… -
(
……- .
$str
……. g
,
……g h
ex
……i k
)
……k l
;
……l m
}
   
}
ÀÀ 	
public
ÕÕ 
void
ÕÕ 
Save
ÕÕ 
(
ÕÕ 
)
ÕÕ 
{
ŒŒ 	
_context
œœ 
.
œœ 
SaveChanges
œœ  
(
œœ  !
)
œœ! "
;
œœ" #
}
–– 	
public
““ 
void
““ 
SendFriendRequest
““ %
(
““% &
int
““& )
senderPlayerId
““* 8
,
““8 9
int
““: =
receiverPlayerId
““> N
)
““N O
{
”” 	
try
‘‘ 
{
’’ 
var
÷÷ 

newRequest
÷÷ 
=
÷÷  
new
÷÷! $
FriendRequest
÷÷% 2
{
◊◊ 
SenderPlayerID
ÿÿ "
=
ÿÿ# $
senderPlayerId
ÿÿ% 3
,
ÿÿ3 4
ReceiverPlayerID
ŸŸ $
=
ŸŸ% &
receiverPlayerId
ŸŸ' 7
,
ŸŸ7 8
RequestStatus
⁄⁄ !
=
⁄⁄" #
$str
⁄⁄$ -
}
€€ 
;
€€ 
_context
›› 
.
›› 
FriendRequest
›› &
.
››& '
Add
››' *
(
››* +

newRequest
››+ 5
)
››5 6
;
››6 7
}
ﬁﬁ 
catch
ﬂﬂ 
(
ﬂﬂ 
DbUpdateException
ﬂﬂ $
ex
ﬂﬂ% '
)
ﬂﬂ' (
{
‡‡ 
throw
·· 
new
·· !
DataAccessException
·· -
(
··- .
$str
··. z
,
··z {
ex
··| ~
)
··~ 
;·· Ä
}
‚‚ 
catch
„„ 
(
„„ 
SqlException
„„ 
)
„„  
{
‰‰ 
throw
ÂÂ 
;
ÂÂ 
}
ÊÊ 
catch
ÁÁ 
(
ÁÁ 
	Exception
ÁÁ 
ex
ÁÁ 
)
ÁÁ  
{
ËË 
throw
ÈÈ 
new
ÈÈ !
DataAccessException
ÈÈ -
(
ÈÈ- .
$str
ÈÈ. o
,
ÈÈo p
ex
ÈÈq s
)
ÈÈs t
;
ÈÈt u
}
ÍÍ 
}
ÎÎ 	
}
ÏÏ 
}ÌÌ ì
hC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\DataAccess\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str %
)% &
]& '
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
$str '
)' (
]( )
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
]!!) *