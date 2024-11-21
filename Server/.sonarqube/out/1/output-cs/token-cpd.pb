¥
~C:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Validators\ValidationFriendshipService.cs
	namespace 	
Service
 
. 
	Utilities 
. 

Validators &
{ 
public 

class '
ValidationFriendshipService ,
{ 
private		 
readonly		 
IPlayerRepository		 *
_playerRepository		+ <
;		< =
private

 
readonly

 $
IFriendRequestRepository

 1$
_friendRequestRepository

2 J
;

J K
public '
ValidationFriendshipService *
(* +
IPlayerRepository+ <
playerRepository= M
,M N$
IFriendRequestRepositoryO g#
friendRequestRepositoryh 
)	 Ä
{ 	
_playerRepository 
= 
playerRepository  0
;0 1$
_friendRequestRepository $
=% &#
friendRequestRepository' >
;> ?
} 	
public 
OperationResponse  -
!ValidateFriendRequestDoesNotExist! B
(B C
intC F
senderPlayerIdG U
,U V
intW Z
receiverPlayerId[ k
)k l
{ 	
if 
( $
_friendRequestRepository (
.( )"
IsFriendRequestPending) ?
(? @
senderPlayerId@ N
,N O
receiverPlayerIdP `
)` a
)a b
{ 
return 
OperationResponse (
.( )
Failure) 0
(0 1
$str1 k
)k l
;l m
} 
return 
OperationResponse $
.$ %
SuccessResult% 2
(2 3
)3 4
;4 5
} 	
public 
OperationResponse  
ValidateUserExists! 3
(3 4
string4 :
username; C
)C D
{ 	
var 
player 
= 
_playerRepository *
.* +
GetByUsername+ 8
(8 9
username9 A
)A B
;B C
if 
( 
player 
== 
null 
) 
{ 
return   
OperationResponse   (
.  ( )
Failure  ) 0
(  0 1
ErrorMessages  1 >
.  > ?
UserNotFound  ? K
)  K L
;  L M
}!! 
return"" 
OperationResponse"" $
.""$ %
SuccessResult""% 2
(""2 3
)""3 4
;""4 5
}## 	
public%% 
OperationResponse%%  '
ValidateFriendRequestExists%%! <
(%%< =
int%%= @
	requestId%%A J
)%%J K
{&& 	
var'' 
receivedRequests''  
=''! "$
_friendRequestRepository''# ;
.''; <
GetReceivedRequests''< O
(''O P
	requestId''P Y
)''Y Z
;''Z [
var(( 
sentRequests(( 
=(( $
_friendRequestRepository(( 7
.((7 8
GetSentRequests((8 G
(((G H
	requestId((H Q
)((Q R
;((R S
if** 
(** 
receivedRequests**  
==**! #
null**$ (
&&**) +
sentRequests**, 8
==**9 ;
null**< @
)**@ A
{++ 
return,, 
OperationResponse,, (
.,,( )
Failure,,) 0
(,,0 1
$str,,1 L
),,L M
;,,M N
}-- 
return.. 
OperationResponse.. $
...$ %
SuccessResult..% 2
(..2 3
)..3 4
;..4 5
}// 	
}00 
}11 Ä
{C:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Validators\ValidationAccountService.cs
	namespace 	
Service
 
. 
	Utilities 
. 

Validators &
{ 
public 

class $
ValidationAccountService )
{ 
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
public $
ValidationAccountService '
(' (
IPlayerRepository( 9
playerRepository: J
)J K
{ 	
_playerRepository 
= 
playerRepository  0
;0 1
} 	
public 
OperationResponse  &
ValidatePlayerRegistration! ;
(; <
	PlayerDTO< E
playerF L
)L M
{ 	
if 
( 
_playerRepository !
.! "
GetByUsername" /
(/ 0
player0 6
.6 7
Username7 ?
)? @
!=A C
nullD H
)H I
{ 
return 
OperationResponse (
.( )
Failure) 0
(0 1
ErrorMessages1 >
.> ?
DuplicateUsername? P
)P Q
;Q R
} 
if 
( 
_playerRepository !
.! "

GetByEmail" ,
(, -
player- 3
.3 4
Email4 9
)9 :
!=; =
null> B
)B C
{ 
return   
OperationResponse   (
.  ( )
Failure  ) 0
(  0 1
ErrorMessages  1 >
.  > ?
DuplicateEmail  ? M
)  M N
;  N O
}!! 
return## 
OperationResponse## $
.##$ %
SuccessResult##% 2
(##2 3
)##3 4
;##4 5
}$$ 	
public&& 
OperationResponse&&  
ValidatePlayerLogin&&! 4
(&&4 5
string&&5 ;
username&&< D
,&&D E
string&&F L
password&&M U
)&&U V
{'' 	
var(( 
player(( 
=(( 
_playerRepository(( *
.((* +
GetByUsername((+ 8
(((8 9
username((9 A
)((A B
;((B C
if** 
(** 
player** 
==** 
null** 
)** 
{++ 
return,, 
OperationResponse,, (
.,,( )
Failure,,) 0
(,,0 1
ErrorMessages,,1 >
.,,> ?
UserNotFound,,? K
),,K L
;,,L M
}-- 
if// 
(// 
!// 
PasswordHelper// 
.//  
VerifyPassword//  .
(//. /
password/// 7
,//7 8
player//9 ?
.//? @
PasswordHash//@ L
)//L M
)//M N
{00 
return11 
OperationResponse11 (
.11( )
Failure11) 0
(110 1
ErrorMessages111 >
.11> ?
InvalidPassword11? N
)11N O
;11O P
}22 
return44 
OperationResponse44 $
.44$ %
SuccessResult44% 2
(442 3
player443 9
)449 :
;44: ;
}55 	
}66 
}77 á
oC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Results\ProfileResponse.cs
	namespace		 	
Service		
 
.		 
	Utilities		 
.		 
Results		 #
{

 
[ 
DataContract 
] 
public 

class 
ProfileResponse  
{ 
[ 	

DataMember	 
] 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
ErrorKey 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
PlayerProfileDTO 
Profile  '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 
static 
ProfileResponse %
SuccessResult& 3
(3 4
PlayerProfileDTO4 D
profileE L
)L M
{ 	
return 
new 
ProfileResponse &
{' (
	IsSuccess) 2
=3 4
true5 9
,9 :
Profile; B
=C D
profileE L
}M N
;N O
} 	
public 
static 
ProfileResponse %
Failure& -
(- .
string. 4
errorKey5 =
)= >
{ 	
return 
new 
ProfileResponse &
{' (
	IsSuccess) 2
=3 4
false5 :
,: ;
ErrorKey< D
=E F
errorKeyG O
}P Q
;Q R
} 	
}   
}!! ü
tC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Results\PlayerScoresResponse.cs
	namespace		 	
Service		
 
.		 
	Utilities		 
.		 
Results		 #
{

 
[ 
DataContract 
] 
public 

class  
PlayerScoresResponse %
{ 
[ 	

DataMember	 
] 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
ErrorKey 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
PlayerScoresDTO 
Scores %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 
static  
PlayerScoresResponse *
SuccessResult+ 8
(8 9
PlayerScoresDTO9 H
scoresI O
)O P
{ 	
return 
new  
PlayerScoresResponse +
{, -
	IsSuccess. 7
=8 9
true: >
,> ?
Scores@ F
=G H
scoresI O
}P Q
;Q R
} 	
public 
static  
PlayerScoresResponse *
Failure+ 2
(2 3
string3 9
errorKey: B
)B C
{ 	
return 
new  
PlayerScoresResponse +
{, -
	IsSuccess. 7
=8 9
false: ?
,? @
ErrorKeyA I
=J K
errorKeyL T
}U V
;V W
} 	
}   
}!! Ü
uC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Results\PlayerProfileResponse.cs
	namespace		 	
Service		
 
.		 
	Utilities		 
.		 
Results		 #
{

 
public 

class !
PlayerProfileResponse &
{ 
[ 	

DataMember	 
] 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
ErrorKey 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
List 
< 
PlayerProfileDTO $
>$ %
Profile& -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
] 
public 
List 
< 
	PlayerDTO 
> 
Player %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 
static !
PlayerProfileResponse +
SuccessResult, 9
(9 :
List: >
<> ?
PlayerProfileDTO? O
>O P
profileQ X
,X Y
ListZ ^
<^ _
	PlayerDTO_ h
>h i
playerj p
)p q
{ 	
return 
new !
PlayerProfileResponse ,
{- .
	IsSuccess/ 8
=9 :
true; ?
,? @
ProfileA H
=I J
profileK R
,R S
PlayerT Z
=[ \
player] c
}d e
;e f
} 	
public 
static !
PlayerProfileResponse +
Failure, 3
(3 4
string4 :
errorKey; C
)C D
{ 	
return   
new   !
PlayerProfileResponse   ,
{  - .
	IsSuccess  / 8
=  9 :
false  ; @
,  @ A
ErrorKey  B J
=  K L
errorKey  M U
}  V W
;  W X
}!! 	
}"" 
}## Ω
kC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\NotificationService.cs
	namespace 	
Service
 
. 
	Utilities 
{ 
public		 

class		 
NotificationService		 $
{

 
} 
} ñ
kC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Mapper\PlayerMapper.cs
	namespace		 	
Service		
 
.		 
	Utilities		 
.		 
Mapper		 "
{

 
public 

class 
PlayerMapper 
{ 
public 
static 
	PlayerDTO 
ToDTO  %
(% &
Player& ,
player- 3
)3 4
{ 	
return 
new 
	PlayerDTO  
{ 
PlayerID 
= 
player !
.! "
PlayerID" *
,* +
Username 
= 
player !
.! "
Username" *
,* +
Email 
= 
player 
. 
Email $
} 
; 
} 	
public 
static 
Player 
ToEntity %
(% &
	PlayerDTO& /
	playerDTO0 9
,9 :
string; A
passwordHashB N
)N O
{ 	
return 
new 
Player 
{ 
PlayerID 
= 
	playerDTO $
.$ %
PlayerID% -
,- .
Username 
= 
	playerDTO $
.$ %
Username% -
,- .
Email 
= 
	playerDTO !
.! "
Email" '
,' (
PasswordHash 
= 
passwordHash +
} 
; 
}   	
}!! 
}"" ≈ 
dC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\CustomLogger.cs
	namespace 	
Service
 
. 
	Utilities 
{ 
public 

static 
class 
CustomLogger $
{		 
private

 
static

 
readonly

 
ILog

  $
logger

% +
=

, -

LogManager

. 8
.

8 9
	GetLogger

9 B
(

B C
typeof

C I
(

I J
CustomLogger

J V
)

V W
)

W X
;

X Y
static 
CustomLogger 
( 
) 
{ 	
XmlConfigurator 
. 
	Configure %
(% &
)& '
;' (
} 	
public 
static 
void 
Info 
(  
string  &
message' .
). /
{ 	
if 
( 
logger 
. 
IsInfoEnabled $
)$ %
{ 
logger 
. 
Info 
( 
message #
)# $
;$ %
} 
} 	
public 
static 
void 
Warn 
(  
string  &
message' .
). /
{ 	
if 
( 
logger 
. 
IsWarnEnabled $
)$ %
{ 
logger 
. 
Warn 
( 
message #
)# $
;$ %
} 
} 	
public!! 
static!! 
void!! 
Error!!  
(!!  !
string!!! '
message!!( /
,!!/ 0
	Exception!!1 :
ex!!; =
=!!> ?
null!!@ D
)!!D E
{"" 	
if## 
(## 
logger## 
.## 
IsErrorEnabled## %
)##% &
{$$ 
if%% 
(%% 
ex%% 
!=%% 
null%% 
)%% 
{&& 
logger'' 
.'' 
Error''  
(''  !
$"''! #
{''# $
message''$ +
}''+ ,
$str'', :
{'': ;
ex''; =
.''= >
Message''> E
}''E F
"''F G
,''G H
ex''I K
)''K L
;''L M
}(( 
else)) 
{** 
logger++ 
.++ 
Error++  
(++  !
message++! (
)++( )
;++) *
},, 
}-- 
}.. 	
public00 
static00 
void00 
Debug00  
(00  !
string00! '
message00( /
)00/ 0
{11 	
if22 
(22 
logger22 
.22 
IsDebugEnabled22 %
)22% &
{33 
logger44 
.44 
Debug44 
(44 
message44 $
)44$ %
;44% &
}55 
}66 	
public88 
static88 
void88 
Fatal88  
(88  !
string88! '
message88( /
,88/ 0
	Exception881 :
ex88; =
=88> ?
null88@ D
)88D E
{99 	
if:: 
(:: 
logger:: 
.:: 
IsFatalEnabled:: %
)::% &
{;; 
if<< 
(<< 
ex<< 
!=<< 
null<< 
)<< 
{== 
logger>> 
.>> 
Fatal>>  
(>>  !
$">>! #
{>># $
message>>$ +
}>>+ ,
$str>>, :
{>>: ;
ex>>; =
.>>= >
Message>>> E
}>>E F
">>F G
,>>G H
ex>>I K
)>>K L
;>>L M
}?? 
else@@ 
{AA 
loggerBB 
.BB 
FatalBB  
(BB  !
messageBB! (
)BB( )
;BB) *
}CC 
}DD 
}EE 	
}FF 
}GG ∞	
oC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Helpers\SqlErrorHandler.cs
	namespace 	
Service
 
. 
	Utilities 
. 
Helpers #
{		 
public

 

static

 
class

 
SqlErrorHandler

 '
{ 
public 
static 
string 
GetErrorMessage ,
(, -
SqlException- 9
ex: <
)< =
{ 	
switch 
( 
ex 
. 
Number 
) 
{ 
case 
$num 
: 
return 
$str 1
;1 2
case 
$num 
: 
return 
$str /
;/ 0
case 
$num 
: 
return 
$str 2
;2 3
case 
$num 
: 
return 
$str &
;& '
default 
: 
return 
$str +
;+ ,
} 
} 	
}   
}!! ı
nC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Helpers\PasswordHelper.cs
	namespace 	
Service
 
. 
	Utilities 
. 
Helpers #
{ 
public 

static 
class 
PasswordHelper &
{ 
public		 
static		 
string		 
HashPassword		 )
(		) *
string		* 0
password		1 9
)		9 :
{

 	
using 
( 
SHA256 
sha256  
=! "
SHA256# )
.) *
Create* 0
(0 1
)1 2
)2 3
{ 
byte 
[ 
] 
bytes 
= 
sha256 %
.% &
ComputeHash& 1
(1 2
Encoding2 :
.: ;
UTF8; ?
.? @
GetBytes@ H
(H I
passwordI Q
)Q R
)R S
;S T
return 
Convert 
. 
ToBase64String -
(- .
bytes. 3
)3 4
;4 5
} 
} 	
public 
static 
bool 
VerifyPassword )
() *
string* 0
password1 9
,9 :
string; A
hashedPasswordB P
)P Q
{ 	
string 
hashedInputPassword &
=' (
HashPassword) 5
(5 6
password6 >
)> ?
;? @
return 
hashedInputPassword &
==' )
hashedPassword* 8
;8 9
} 	
} 
} ñ
aC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Email\IEmailService.cs
	namespace 	
Service
 
. 
Email 
{ 
public 

	interface 
IEmailService "
{ 
void 
Send 
( 
string 
	toAddress "
," #
string$ *
subject+ 2
,2 3
string4 :
body; ?
)? @
;@ A
} 
} Ú
gC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Email\EmailServiceFactory.cs
	namespace 	
Service
 
. 
Email 
{ 
public 

static 
class 
EmailServiceFactory +
{ 
public 
static 
IEmailService #
CreateEmailService$ 6
(6 7
)7 8
{ 	
var 

smtpClient 
= 
EmailConfigHelper .
.. /
GetSmtpClient/ <
(< =
)= >
;> ?
var 
fromAddress 
= 
EmailConfigHelper /
./ 0
GetFromAddress0 >
(> ?
)? @
;@ A
return

 
new

 
EmailService

 #
(

# $

smtpClient

$ .
,

. /
fromAddress

0 ;
)

; <
;

< =
} 	
} 
} ≠
`C:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Email\EmailService.cs
	namespace 	
Service
 
. 
Email 
{ 
public 

class 
EmailService 
: 
IEmailService  -
{ 
private		 
readonly		 

SmtpClient		 #
_smtpClient		$ /
;		/ 0
private

 
readonly

 
string

 
_fromAddress

  ,
;

, -
public 
EmailService 
( 

SmtpClient &

smtpClient' 1
,1 2
string3 9
fromAddress: E
)E F
{ 	
_smtpClient 
= 

smtpClient $
;$ %
_fromAddress 
= 
fromAddress &
;& '
} 	
public 
void 
Send 
( 
string 
to  "
," #
string$ *
subject+ 2
,2 3
string4 :
body; ?
)? @
{ 	
var 
mailMessage 
= 
new !
MailMessage" -
(- .
_fromAddress. :
,: ;
to< >
,> ?
subject@ G
,G H
bodyI M
)M N
;N O
_smtpClient 
. 
Send 
( 
mailMessage (
)( )
;) *
} 	
} 
} ı
eC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Email\EmailConfigHelper.cs
	namespace 	
Service
 
. 
Email 
{ 
public 

static 
class 
EmailConfigHelper )
{ 
public		 
static		 
string		 
GetFromAddress		 +
(		+ ,
)		, -
{

 	
return  
ConfigurationManager '
.' (
AppSettings( 3
[3 4
$str4 F
]F G
;G H
} 	
public 
static 

SmtpClient  
GetSmtpClient! .
(. /
)/ 0
{ 	
var 

smtpClient 
= 
new  

SmtpClient! +
{ 
Host 
=  
ConfigurationManager +
.+ ,
AppSettings, 7
[7 8
$str8 B
]B C
,C D
Port 
= 
int 
. 
Parse  
(  ! 
ConfigurationManager! 5
.5 6
AppSettings6 A
[A B
$strB L
]L M
)M N
,N O
	EnableSsl 
= 
bool  
.  !
Parse! &
(& ' 
ConfigurationManager' ;
.; <
AppSettings< G
[G H
$strH S
]S T
)T U
,U V
Credentials 
= 
new !
NetworkCredential" 3
(3 4 
ConfigurationManager (
.( )
AppSettings) 4
[4 5
$str5 C
]C D
,D E 
ConfigurationManager (
.( )
AppSettings) 4
[4 5
$str5 C
]C D
) 
} 
; 
return 

smtpClient 
; 
} 	
} 
} î
qC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Results\OperationResponse.cs
	namespace 	
Service
 
. 
Results 
{ 
[ 
DataContract 
] 
public 

class 
OperationResponse "
{ 
[ 	

DataMember	 
] 
public		 
bool		 
	IsSuccess		 
{		 
get		  #
;		# $
set		% (
;		( )
}		* +
[ 	

DataMember	 
] 
public 
string 
ErrorKey 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
object 
Data 
{ 
get  
;  !
set" %
;% &
}' (
public 
static 
OperationResponse '
SuccessResult( 5
(5 6
)6 7
{ 	
return 
new 
OperationResponse (
{) *
	IsSuccess+ 4
=5 6
true7 ;
}< =
;= >
} 	
public 
static 
OperationResponse '
SuccessResult( 5
(5 6
object6 <
data= A
)A B
{ 	
return 
new 
OperationResponse (
{) *
	IsSuccess+ 4
=5 6
true7 ;
,; <
Data= A
=B C
dataD H
}I J
;J K
} 	
public 
static 
OperationResponse '
Failure( /
(/ 0
string0 6
errorKey7 ?
)? @
{ 	
return 
new 
OperationResponse (
{) *
	IsSuccess+ 4
=5 6
false7 <
,< =
ErrorKey> F
=G H
errorKeyI Q
}R S
;S T
} 	
} 
}   „
mC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Results\LobbyResponse.cs
	namespace		 	
Service		
 
.		 
	Utilities		 
.		 
Results		 #
{

 
[ 
DataContract 
] 
public 

class 
LobbyResponse 
{ 
[ 	

DataMember	 
] 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
ErrorKey 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
LobbyDTO 
Lobby 
{ 
get  #
;# $
set% (
;( )
}* +
public 
static 
LobbyResponse #
SuccessResult$ 1
(1 2
LobbyDTO2 :
lobby; @
)@ A
{ 	
return 
new 
LobbyResponse $
{% &
	IsSuccess' 0
=1 2
true3 7
,7 8
Lobby9 >
=? @
lobbyA F
}G H
;H I
} 	
public 
static 
LobbyResponse #
Failure$ +
(+ ,
string, 2
errorKey3 ;
); <
{ 	
return 
new 
LobbyResponse $
{% &
	IsSuccess' 0
=1 2
false3 8
,8 9
ErrorKey: B
=C D
errorKeyE M
}N O
;O P
} 	
}   
}!! •
mC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Results\ImageResponse.cs
	namespace 	
Service
 
. 
Results 
{ 
[ 
DataContract 
] 
public 

class 
ImageResponse 
{ 
[ 	

DataMember	 
] 
public		 
bool		 
	IsSuccess		 
{		 
get		  #
;		# $
set		% (
;		( )
}		* +
[

 	

DataMember

	 
]

 
public 
string 
ErrorKey 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
byte 
[ 
] 
	ImageData 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
string 
FileName 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
string 
MimeType 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
static 
ImageResponse #
Success$ +
(+ ,
byte, 0
[0 1
]1 2
	imageData3 <
,< =
string> D
fileNameE M
,M N
stringO U
mimeTypeV ^
)^ _
{ 	
return 
new 
ImageResponse $
{% &
	IsSuccess' 0
=1 2
true3 7
,7 8
	ImageData9 B
=C D
	imageDataE N
,N O
FileNameP X
=Y Z
fileName[ c
,c d
MimeTypee m
=n o
mimeTypep x
}y z
;z {
} 	
public 
static 
ImageResponse #
Failure$ +
(+ ,
string, 2
errorKey3 ;
); <
{ 	
return 
new 
ImageResponse $
{% &
	IsSuccess' 0
=1 2
false3 8
,8 9
ErrorKey: B
=C D
errorKeyE M
}N O
;O P
} 	
} 
} Å
xC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Results\FriendRequestListReponse.cs
	namespace		 	
Service		
 
.		 
	Utilities		 
.		 
Results		 #
{

 
public 

class $
FriendRequestListReponse )
{ 
[ 	

DataMember	 
] 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
ErrorKey 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
List 
< 
FriendRequestDTO $
>$ %
FriendRequests& 4
{5 6
get7 :
;: ;
set< ?
;? @
}A B
public 
static $
FriendRequestListReponse .
SuccessResult/ <
(< =
List= A
<A B
FriendRequestDTOB R
>R S
friendRequestsT b
)b c
{ 	
return 
new $
FriendRequestListReponse /
{0 1
	IsSuccess2 ;
=< =
true> B
,B C
FriendRequestsD R
=S T
friendRequestsU c
}d e
;e f
} 	
public 
static $
FriendRequestListReponse .
Failure/ 6
(6 7
string7 =
errorKey> F
)F G
{ 	
return 
new $
FriendRequestListReponse /
{0 1
	IsSuccess2 ;
=< =
false> C
,C D
ErrorKeyE M
=N O
errorKeyP X
}Y Z
;Z [
} 	
}   
}!! Î
rC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Results\FriendListResponse.cs
	namespace		 	
Service		
 
.		 
	Utilities		 
.		 
Results		 #
{

 
[ 
DataContract 
] 
public 

class 
FriendListResponse #
{ 
[ 	

DataMember	 
] 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
ErrorKey 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
List 
< 
	PlayerDTO 
> 
Friends &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
public 
static 
FriendListResponse (
SuccessResult) 6
(6 7
List7 ;
<; <
	PlayerDTO< E
>E F
friendsG N
)N O
{ 	
return 
new 
FriendListResponse )
{* +
	IsSuccess, 5
=6 7
true8 <
,< =
Friends> E
=F G
friendsH O
}P Q
;Q R
} 	
public 
static 
FriendListResponse (
Failure) 0
(0 1
string1 7
errorKey8 @
)@ A
{ 	
return 
new 
FriendListResponse )
{* +
	IsSuccess, 5
=6 7
false8 =
,= >
ErrorKey? G
=H I
errorKeyJ R
}S T
;T U
} 	
}   
}!! ú
rC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Results\ChatFriendResponse.cs
	namespace 	
Service
 
. 
	Utilities 
. 
Results #
{ 
public 

class 
ChatFriendResponse #
:$ %
OperationResponse& 7
{ 
public 
List 
< 
MessageFriendDTO $
>$ %
Messages& .
{/ 0
get1 4
;4 5
private6 =
set> A
;A B
}C D
public

 
static

 
ChatFriendResponse

 (
SuccessResult

) 6
(

6 7
List

7 ;
<

; <
MessageFriendDTO

< L
>

L M
messages

N V
)

V W
=>

X Z
new

[ ^
ChatFriendResponse

_ q
{ 	
	IsSuccess 
= 
true 
, 
Messages 
= 
messages 
} 	
;	 

public 
static 
ChatFriendResponse (
Failure) 0
(0 1
string1 7
errorKey8 @
)@ A
=>B D
newE H
ChatFriendResponseI [
{ 	
	IsSuccess 
= 
false 
, 
ErrorKey 
= 
errorKey 
,  
Messages 
= 
new 
List 
<  
MessageFriendDTO  0
>0 1
(1 2
)2 3
} 	
;	 

} 
} —
xC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Enumerations\FriendRequestStatus.cs
	namespace 	
Service
 
. 
	Utilities 
. 
Enumerations (
{ 
public		 

enum		 
FriendRequestStatus		 #
{

 
Pending 
, 
Accepted 
, 
Rejected 
} 
} Â
nC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Constans\ErrorMessages.cs
	namespace 	
Service
 
. 
	Utilities 
. 
Constans $
{ 
public 

static 
class 
ErrorMessages %
{ 
public 
const 
string 
GeneralException ,
=- .
$str/ G
;G H
public 
const 
string 
DuplicateUsername -
=. /
$str0 I
;I J
public 
const 
string 
DuplicateEmail *
=+ ,
$str- C
;C D
public 
const 
string 
UserNotFound (
=) *
$str+ ?
;? @
public		 
const		 
string		 
InvalidPassword		 +
=		, -
$str		. E
;		E F
public

 
const

 
string

 
DifferentPassword

 -
=

. /
$str

0 I
;

I J
public 
const 
string 
ProfileNotFound +
=, -
$str. E
;E F
public 
const 
string 
InvalidEmail (
=) *
$str+ ?
;? @
public 
const 
string 
InvalidUsername +
=, -
$str. E
;E F
public 
const 
string 
ImageNotFound )
=* +
$str, A
;A B
public 
const 
string 

EmptyImage &
=' (
$str) ;
;; <
public 
const 
string 
InvalidProfileData .
=/ 0
$str1 K
;K L
public 
const 
string %
ErrorWhileUpdatingProfile 5
=6 7
$str8 Y
;Y Z
public 
const 
string ,
 ErrorWhileUpdatingProfilePicture <
== >
$str? g
;g h
public 
const 
string 

InvalidBio &
=' (
$str) ;
;; <
public 
const 
string  
UserAlreadyConnected 0
=1 2
$str3 O
;O P
public 
const 
string 
LobbyNotFound )
=* +
$str, A
;A B
public 
const 
string 
	LobbyFull %
=& '
$str( 9
;9 :
public 
const 
string  
InvalidLobbyPassword 0
=1 2
$str3 O
;O P
public 
const 
string 
LobbyAlreadyExists .
=/ 0
$str1 K
;K L
public 
const 
string 
UnauthorizedAccess .
=/ 0
$str1 K
;K L
public 
const 
string 
DuplicateLobbyName .
=/ 0
$str1 K
;K L
public 
const 
string 
IncorrectPassword -
=. /
$str0 I
;I J
public 
const 
string 
UserNotConnected ,
=- .
$str/ G
;G H
public 
const 
string 
NotLobbyHost (
=) *
$str+ ?
;? @
public 
const 
string 
PlayerNotInLobby ,
=- .
$str/ G
;G H
public!! 
const!! 
string!! 
ScoreNotFound!! )
=!!* +
$str!!, A
;!!A B
}## 
}$$ ˝8
[C:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\ServiceModule.cs
	namespace		 	
Service		
 
{

 
public 

class 
ServiceModule 
:  
Module! '
{ 
	protected 
override 
void 
Load  $
($ %
ContainerBuilder% 5
builder6 =
)= >
{ 	
builder 
. 
RegisterType  
<  !
ProfileService! /
>/ 0
(0 1
)1 2
.2 3
As3 5
<5 6
IProfileService6 E
>E F
(F G
)G H
.H I$
InstancePerLifetimeScopeI a
(a b
)b c
;c d
builder 
. 
RegisterType  
<  !
AccountService! /
>/ 0
(0 1
)1 2
.2 3
As3 5
<5 6
IAccountService6 E
>E F
(F G
)G H
.H I$
InstancePerLifetimeScopeI a
(a b
)b c
;c d
builder 
. 
RegisterType  
<  !
FriendshipService! 2
>2 3
(3 4
)4 5
.5 6
As6 8
<8 9
IFriendshipService9 K
>K L
(L M
)M N
.N O$
InstancePerLifetimeScopeO g
(g h
)h i
;i j
builder 
. 
RegisterType  
<  !
ChatService! ,
>, -
(- .
). /
./ 0
As0 2
<2 3
IChatService3 ?
>? @
(@ A
)A B
.B C
SingleInstanceC Q
(Q R
)R S
;S T
builder 
. 
RegisterType  
<  !
LobbyService! -
>- .
(. /
)/ 0
.0 1
As1 3
<3 4
ILobbyService4 A
>A B
(B C
)C D
.D E
SingleInstanceE S
(S T
)T U
;U V
builder 
. 
RegisterType  
<  !
ChatFriendService! 2
>2 3
(3 4
)4 5
.5 6
As6 8
<8 9
IChatFriendService9 K
>K L
(L M
)M N
.N O
SingleInstanceO ]
(] ^
)^ _
;_ `
builder 
. 
RegisterType  
<  !
PlayerScoresService! 4
>4 5
(5 6
)6 7
.7 8
As8 :
<: ; 
IPlayerScoresService; O
>O P
(P Q
)Q R
.R S$
InstancePerLifetimeScopeS k
(k l
)l m
;m n
builder 
. 
RegisterType  
<  !
GameService! ,
>, -
(- .
). /
./ 0
As0 2
<2 3
IGameService3 ?
>? @
(@ A
)A B
.B C
SingleInstanceC Q
(Q R
)R S
;S T
builder 
. 
RegisterType  
<  !
ChatLobbyService! 1
>1 2
(2 3
)3 4
.4 5
As5 7
<7 8
IChatLobbyService8 I
>I J
(J K
)K L
.L M
SingleInstanceM [
([ \
)\ ]
;] ^
builder 
. 
RegisterType  
<  !
PlayerRepository! 1
>1 2
(2 3
)3 4
.4 5
As5 7
<7 8
IPlayerRepository8 I
>I J
(J K
)K L
.L M$
InstancePerLifetimeScopeM e
(e f
)f g
;g h
builder 
. 
RegisterType  
<  !
ProfileRepository! 2
>2 3
(3 4
)4 5
.5 6
As6 8
<8 9
IProfileRepository9 K
>K L
(L M
)M N
.N O$
InstancePerLifetimeScopeO g
(g h
)h i
;i j
builder 
. 
RegisterType  
<  !"
PlayerScoresRepository! 7
>7 8
(8 9
)9 :
.: ;
As; =
<= >#
IPlayerScoresRepository> U
>U V
(V W
)W X
.X Y$
InstancePerLifetimeScopeY q
(q r
)r s
;s t
builder 
. 
RegisterType  
<  !#
FriendRequestRepository! 8
>8 9
(9 :
): ;
.; <
As< >
<> ?$
IFriendRequestRepository? W
>W X
(X Y
)Y Z
.Z [$
InstancePerLifetimeScope[ s
(s t
)t u
;u v
builder 
. 
RegisterType  
<  !"
ChatMessagesRepository! 7
>7 8
(8 9
)9 :
.: ;
As; =
<= >#
IChatMessagesRepository> U
>U V
(V W
)W X
.X Y$
InstancePerLifetimeScopeY q
(q r
)r s
;s t
builder 
. 
RegisterType  
<  !"
PlayerScoresRepository! 7
>7 8
(8 9
)9 :
.: ;
As; =
<= >#
IPlayerScoresRepository> U
>U V
(V W
)W X
.X Y$
InstancePerLifetimeScopeY q
(q r
)r s
;s t
builder"" 
."" 
RegisterType""  
<""  !'
ValidationFriendshipService""! <
>""< =
(""= >
)""> ?
.""? @
AsSelf""@ F
(""F G
)""G H
.""H I$
InstancePerLifetimeScope""I a
(""a b
)""b c
;""c d
builder$$ 
.$$ 
RegisterType$$  
<$$  !
BMCEntities$$! ,
>$$, -
($$- .
)$$. /
.$$/ 0
AsSelf$$0 6
($$6 7
)$$7 8
.$$8 9$
InstancePerLifetimeScope$$9 Q
($$Q R
)$$R S
;$$S T
builder&& 
.&& 
RegisterType&&  
<&&  !
ConnectionManager&&! 2
>&&2 3
(&&3 4
)&&4 5
.&&5 6
AsSelf&&6 <
(&&< =
)&&= >
.&&> ?
SingleInstance&&? M
(&&M N
)&&N O
;&&O P
builder(( 
.(( 
RegisterType((  
<((  !"
ConnectionEventHandler((! 7
>((7 8
(((8 9
)((9 :
.((: ;
AsSelf((; A
(((A B
)((B C
.((C D
SingleInstance((D R
(((R S
)((S T
;((T U
})) 	
}** 
}++ ê
eC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str "
)" #
]# $
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
$str $
)$ %
]% &
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
]!!) *≈
nC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\UserConnectionManager.cs
	namespace 	
Service
 
. 

Implements 
{ 
internal

 
class

 !
UserConnectionManager

 (
{ 
} 
} õ’
gC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\ProfileService.cs
	namespace 	
Service
 
. 

Implements 
{ 
public 

class 
ProfileService 
:  !
IProfileService" 1
{ 
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
private 
readonly 
IProfileRepository +
_profileRepository, >
;> ?
private 
readonly 
string 
_imageFolderPath  0
;0 1
public 
ProfileService 
( 
IPlayerRepository /
playerRepository0 @
,@ A
IProfileRepositoryB T
profileRepositoryU f
)f g
{ 	
_playerRepository 
= 
playerRepository  0
;0 1
_profileRepository 
=  
profileRepository! 2
;2 3
_imageFolderPath 
= 
Path #
.# $
Combine$ +
(+ ,
	AppDomain, 5
.5 6
CurrentDomain6 C
.C D
BaseDirectoryD Q
,Q R
$strS \
,\ ]
$str^ g
)g h
;h i
if 
( 
! 
	Directory 
. 
Exists !
(! "
_imageFolderPath" 2
)2 3
)3 4
{ 
	Directory 
. 
CreateDirectory )
() *
_imageFolderPath* :
): ;
;; <
}   
}!! 	
public## 
OperationResponse##  
UpdatePassword##! /
(##/ 0
string##0 6
username##7 ?
,##? @
string##A G
newPassword##H S
,##S T
string##U [
oldPassword##\ g
)##g h
{$$ 	
try%% 
{&& 
var'' 
player'' 
='' 
_playerRepository'' .
.''. /
GetByUsername''/ <
(''< =
username''= E
)''E F
;''F G
bool(( 
isPasswordValid(( $
=((% &
PasswordHelper((' 5
.((5 6
VerifyPassword((6 D
(((D E
oldPassword((E P
,((P Q
player((R X
.((X Y
PasswordHash((Y e
)((e f
;((f g
if)) 
()) 
!)) 
isPasswordValid)) $
)))$ %
{** 
return++ 
OperationResponse++ ,
.++, -
Failure++- 4
(++4 5
ErrorMessages++5 B
.++B C
DifferentPassword++C T
)++T U
;++U V
},, 
string.. 
passwordHash.. #
=..$ %
PasswordHelper..& 4
...4 5
HashPassword..5 A
(..A B
newPassword..B M
)..M N
;..N O
_playerRepository// !
.//! "
UpdatePasswordHash//" 4
(//4 5
username//5 =
,//= >
passwordHash//? K
)//K L
;//L M
return00 
OperationResponse00 (
.00( )
SuccessResult00) 6
(006 7
)007 8
;008 9
}11 
catch22 
(22 
SqlException22 
ex22  "
)22" #
{33 
CustomLogger44 
.44 
Error44 "
(44" #
$str44# %
,44% &
ex44' )
)44) *
;44* +
string55 
errorMessage55 #
=55$ %
SqlErrorHandler55& 5
.555 6
GetErrorMessage556 E
(55E F
ex55F H
)55H I
;55I J
return66 
OperationResponse66 (
.66( )
Failure66) 0
(660 1
errorMessage661 =
)66= >
;66> ?
}77 
catch88 
(88 
	Exception88 
ex88 
)88  
{99 
CustomLogger:: 
.:: 
Error:: "
(::" #
$str::# %
,::% &
ex::' )
)::) *
;::* +
return;; 
OperationResponse;; (
.;;( )
Failure;;) 0
(;;0 1
ErrorMessages;;1 >
.;;> ?
GeneralException;;? O
);;O P
;;;P Q
}<< 
}== 	
public?? 
OperationResponse??   
UpdateProfilePicture??! 5
(??5 6
string??6 <
username??= E
,??E F
byte??G K
[??K L
]??L M

imageBytes??N X
,??X Y
string??Z `
fileName??a i
)??i j
{@@ 	
tryAA 
{BB 
varCC 
playerCC 
=CC 
_playerRepositoryCC .
.CC. /
GetByUsernameCC/ <
(CC< =
usernameCC= E
)CCE F
;CCF G
ifDD 
(DD 
playerDD 
==DD 
nullDD "
)DD" #
{EE 
returnFF 
OperationResponseFF ,
.FF, -
FailureFF- 4
(FF4 5
ErrorMessagesFF5 B
.FFB C
UserNotFoundFFC O
)FFO P
;FFP Q
}GG 
varII 
profileII 
=II 
_profileRepositoryII 0
.II0 1 
GetProfileByPlayerIdII1 E
(IIE F
playerIIF L
.IIL M
PlayerIDIIM U
)IIU V
;IIV W
ifJJ 
(JJ 
profileJJ 
==JJ 
nullJJ #
)JJ# $
{KK 
returnLL 
OperationResponseLL ,
.LL, -
FailureLL- 4
(LL4 5
ErrorMessagesLL5 B
.LLB C
ProfileNotFoundLLC R
)LLR S
;LLS T
}MM 
stringOO 
uniqueFileNameOO %
=OO& '
$"OO( *
{OO* +
playerOO+ 1
.OO1 2
UsernameOO2 :
}OO: ;
$strOO; <
{OO< =
GuidOO= A
.OOA B
NewGuidOOB I
(OOI J
)OOJ K
}OOK L
{OOL M
PathOOM Q
.OOQ R
GetExtensionOOR ^
(OO^ _
fileNameOO_ g
)OOg h
}OOh i
"OOi j
;OOj k
stringPP 
filePathPP 
=PP  !
PathPP" &
.PP& '
CombinePP' .
(PP. /
_imageFolderPathPP/ ?
,PP? @
uniqueFileNamePPA O
)PPO P
;PPP Q
FileRR 
.RR 
WriteAllBytesRR "
(RR" #
filePathRR# +
,RR+ ,

imageBytesRR- 7
)RR7 8
;RR8 9
stringTT 
imageUrlTT 
=TT  !
PathTT" &
.TT& '
CombineTT' .
(TT. /
$strTT/ A
,TTA B
uniqueFileNameTTC Q
)TTQ R
;TTR S
stringUU 
absolutePathUU #
=UU$ %
PathUU& *
.UU* +
CombineUU+ 2
(UU2 3
	AppDomainUU3 <
.UU< =
CurrentDomainUU= J
.UUJ K
BaseDirectoryUUK X
,UUX Y
imageUrlUUZ b
.UUb c
ReplaceUUc j
(UUj k
$charUUk o
,UUo p
$charUUq t
)UUt u
)UUu v
;UUv w
profileXX 
.XX 
	AvatarURLXX !
=XX" #
absolutePathXX$ 0
;XX0 1
_profileRepositoryYY "
.YY" #
UpdateYY# )
(YY) *
profileYY* 1
)YY1 2
;YY2 3
_profileRepositoryZZ "
.ZZ" #
SaveZZ# '
(ZZ' (
)ZZ( )
;ZZ) *
return\\ 
OperationResponse\\ (
.\\( )
SuccessResult\\) 6
(\\6 7
)\\7 8
;\\8 9
}]] 
catch^^ 
(^^ 
SqlException^^ 
ex^^  "
)^^" #
{__ 
CustomLogger`` 
.`` 
Error`` "
(``" #
$str``# %
,``% &
ex``' )
)``) *
;``* +
stringaa 
errorMessageaa #
=aa$ %
SqlErrorHandleraa& 5
.aa5 6
GetErrorMessageaa6 E
(aaE F
exaaF H
)aaH I
;aaI J
returnbb 
OperationResponsebb (
.bb( )
Failurebb) 0
(bb0 1
errorMessagebb1 =
)bb= >
;bb> ?
}cc 
catchdd 
(dd 
	Exceptiondd 
exdd 
)dd  
{ee 
CustomLoggerff 
.ff 
Errorff "
(ff" #
$strff# %
,ff% &
exff' )
)ff) *
;ff* +
returngg 
OperationResponsegg (
.gg( )
Failuregg) 0
(gg0 1
ErrorMessagesgg1 >
.gg> ?,
 ErrorWhileUpdatingProfilePicturegg? _
)gg_ `
;gg` a
}hh 
}ii 	
publickk 
OperationResponsekk  
UpdateUsernamekk! /
(kk/ 0
stringkk0 6
currentUsernamekk7 F
,kkF G
stringkkH N
newUsernamekkO Z
)kkZ [
{ll 	
trymm 
{nn 
ifoo 
(oo 
_playerRepositoryoo %
.oo% &
GetByUsernameoo& 3
(oo3 4
newUsernameoo4 ?
)oo? @
!=ooA C
nullooD H
)ooH I
{pp 
returnqq 
OperationResponseqq ,
.qq, -
Failureqq- 4
(qq4 5
ErrorMessagesqq5 B
.qqB C
DuplicateUsernameqqC T
)qqT U
;qqU V
}rr 
vartt 
playertt 
=tt 
_playerRepositorytt .
.tt. /
GetByUsernamett/ <
(tt< =
currentUsernamett= L
)ttL M
;ttM N
ifuu 
(uu 
playeruu 
==uu 
nulluu "
)uu" #
{vv 
returnww 
OperationResponseww ,
.ww, -
Failureww- 4
(ww4 5
ErrorMessagesww5 B
.wwB C
UserNotFoundwwC O
)wwO P
;wwP Q
}xx 
playerzz 
.zz 
Usernamezz 
=zz  !
newUsernamezz" -
;zz- .
_playerRepository{{ !
.{{! "
Update{{" (
({{( )
player{{) /
){{/ 0
;{{0 1
_playerRepository|| !
.||! "
Save||" &
(||& '
)||' (
;||( )
return~~ 
OperationResponse~~ (
.~~( )
SuccessResult~~) 6
(~~6 7
)~~7 8
;~~8 9
} 
catch
ÄÄ 
(
ÄÄ 
	Exception
ÄÄ 
ex
ÄÄ 
)
ÄÄ  
{
ÅÅ 
CustomLogger
ÇÇ 
.
ÇÇ 
Error
ÇÇ "
(
ÇÇ" #
$str
ÇÇ# %
,
ÇÇ% &
ex
ÇÇ' )
)
ÇÇ) *
;
ÇÇ* +
return
ÉÉ 
OperationResponse
ÉÉ (
.
ÉÉ( )
Failure
ÉÉ) 0
(
ÉÉ0 1
ErrorMessages
ÉÉ1 >
.
ÉÉ> ?
GeneralException
ÉÉ? O
)
ÉÉO P
;
ÉÉP Q
}
ÑÑ 
}
ÖÖ 	
public
áá 
OperationResponse
áá  
UpdateProfile
áá! .
(
áá. /
string
áá/ 5
username
áá6 >
,
áá> ?
Profile
áá@ G
profile
ááH O
)
ááO P
{
àà 	
try
ââ 
{
ää 
if
ãã 
(
ãã 
profile
ãã 
==
ãã 
null
ãã #
)
ãã# $
{
åå 
return
çç 
OperationResponse
çç ,
.
çç, -
Failure
çç- 4
(
çç4 5
ErrorMessages
çç5 B
.
ççB C
UserNotFound
ççC O
)
ççO P
;
ççP Q
}
éé 
var
êê 
player
êê 
=
êê 
_playerRepository
êê .
.
êê. /
GetByUsername
êê/ <
(
êê< =
username
êê= E
)
êêE F
;
êêF G
if
ëë 
(
ëë 
player
ëë 
==
ëë 
null
ëë "
)
ëë" #
{
íí 
return
ìì 
OperationResponse
ìì ,
.
ìì, -
Failure
ìì- 4
(
ìì4 5
ErrorMessages
ìì5 B
.
ììB C
ProfileNotFound
ììC R
)
ììR S
;
ììS T
}
îî 
profile
ññ 
.
ññ 
PlayerID
ññ  
=
ññ! "
player
ññ# )
.
ññ) *
PlayerID
ññ* 2
;
ññ2 3 
_profileRepository
òò "
.
òò" #
Update
òò# )
(
òò) *
profile
òò* 1
)
òò1 2
;
òò2 3
return
öö 
OperationResponse
öö (
.
öö( )
SuccessResult
öö) 6
(
öö6 7
)
öö7 8
;
öö8 9
}
õõ 
catch
úú 
(
úú 
	Exception
úú 
ex
úú 
)
úú  
{
ùù 
CustomLogger
ûû 
.
ûû 
Error
ûû "
(
ûû" #
$str
ûû# I
,
ûûI J
ex
ûûK M
)
ûûM N
;
ûûN O
return
üü 
OperationResponse
üü (
.
üü( )
Failure
üü) 0
(
üü0 1
ErrorMessages
üü1 >
.
üü> ?
GeneralException
üü? O
)
üüO P
;
üüP Q
}
†† 
}
°° 	
public
££ 
ProfileResponse
££ "
GetProfileByUsername
££ 3
(
££3 4
string
££4 :
username
££; C
)
££C D
{
§§ 	
try
•• 
{
¶¶ 
var
ßß 
player
ßß 
=
ßß 
_playerRepository
ßß .
.
ßß. /
GetByUsername
ßß/ <
(
ßß< =
username
ßß= E
)
ßßE F
;
ßßF G
if
®® 
(
®® 
player
®® 
==
®® 
null
®® "
)
®®" #
{
©© 
return
™™ 
ProfileResponse
™™ *
.
™™* +
Failure
™™+ 2
(
™™2 3
ErrorMessages
™™3 @
.
™™@ A
UserNotFound
™™A M
)
™™M N
;
™™N O
}
´´ 
var
≠≠ 
profile
≠≠ 
=
≠≠  
_profileRepository
≠≠ 0
.
≠≠0 1"
GetProfileByPlayerId
≠≠1 E
(
≠≠E F
player
≠≠F L
.
≠≠L M
PlayerID
≠≠M U
)
≠≠U V
;
≠≠V W
if
ÆÆ 
(
ÆÆ 
profile
ÆÆ 
==
ÆÆ 
null
ÆÆ #
)
ÆÆ# $
{
ØØ 
return
∞∞ 
ProfileResponse
∞∞ *
.
∞∞* +
Failure
∞∞+ 2
(
∞∞2 3
ErrorMessages
∞∞3 @
.
∞∞@ A
ProfileNotFound
∞∞A P
)
∞∞P Q
;
∞∞Q R
}
±± 
byte
≥≥ 
[
≥≥ 
]
≥≥ 

imageBytes
≥≥ !
=
≥≥" #$
ConvertImageUrlToBytes
≥≥$ :
(
≥≥: ;
profile
≥≥; B
.
≥≥B C
	AvatarURL
≥≥C L
)
≥≥L M
??
≥≥N P
Array
≥≥Q V
.
≥≥V W
Empty
≥≥W \
<
≥≥\ ]
byte
≥≥] a
>
≥≥a b
(
≥≥b c
)
≥≥c d
;
≥≥d e
var
µµ 

profileDTO
µµ 
=
µµ  
new
µµ! $
PlayerProfileDTO
µµ% 5
{
∂∂ 
FullName
∑∑ 
=
∑∑ 
profile
∑∑ &
.
∑∑& '
FullName
∑∑' /
??
∑∑0 2
$str
∑∑3 >
,
∑∑> ?
Bio
∏∏ 
=
∏∏ 
profile
∏∏ !
.
∏∏! "
Bio
∏∏" %
??
∏∏& (
$str
∏∏) ;
,
∏∏; <
JoinDate
ππ 
=
ππ 
profile
ππ &
.
ππ& '
JoinDate
ππ' /
??
ππ0 2
DateTime
ππ3 ;
.
ππ; <
MinValue
ππ< D
,
ππD E

SingUpDate
∫∫ 
=
∫∫  
profile
∫∫! (
.
∫∫( )

SignUpDate
∫∫) 3
??
∫∫4 6
DateTime
∫∫7 ?
.
∫∫? @
MinValue
∫∫@ H
,
∫∫H I
	LastVisit
ªª 
=
ªª 
profile
ªª  '
.
ªª' (
	LastVisit
ªª( 1
??
ªª2 4
DateTime
ªª5 =
.
ªª= >
MinValue
ªª> F
,
ªªF G
ProfileImage
ºº  
=
ºº! "

imageBytes
ºº# -
}
ΩΩ 
;
ΩΩ 
return
øø 
ProfileResponse
øø &
.
øø& '
SuccessResult
øø' 4
(
øø4 5

profileDTO
øø5 ?
)
øø? @
;
øø@ A
}
¿¿ 
catch
¡¡ 
(
¡¡ 
	Exception
¡¡ 
ex
¡¡ 
)
¡¡  
{
¬¬ 
CustomLogger
√√ 
.
√√ 
Error
√√ "
(
√√" #
$str
√√# I
,
√√I J
ex
√√K M
)
√√M N
;
√√N O
return
ƒƒ 
ProfileResponse
ƒƒ &
.
ƒƒ& '
Failure
ƒƒ' .
(
ƒƒ. /
ErrorMessages
ƒƒ/ <
.
ƒƒ< =
GeneralException
ƒƒ= M
)
ƒƒM N
;
ƒƒN O
}
≈≈ 
}
∆∆ 	
public
»» 
ImageResponse
»» 
GetProfileImage
»» ,
(
»», -
string
»»- 3
username
»»4 <
)
»»< =
{
…… 	
try
   
{
ÀÀ 
var
ÃÃ 
player
ÃÃ 
=
ÃÃ 
_playerRepository
ÃÃ .
.
ÃÃ. /
GetByUsername
ÃÃ/ <
(
ÃÃ< =
username
ÃÃ= E
)
ÃÃE F
;
ÃÃF G
if
ÕÕ 
(
ÕÕ 
player
ÕÕ 
==
ÕÕ 
null
ÕÕ "
)
ÕÕ" #
{
ŒŒ 
return
œœ 
ImageResponse
œœ (
.
œœ( )
Failure
œœ) 0
(
œœ0 1
ErrorMessages
œœ1 >
.
œœ> ?
UserNotFound
œœ? K
)
œœK L
;
œœL M
}
–– 
var
““ 
profile
““ 
=
““  
_profileRepository
““ 0
.
““0 1"
GetProfileByPlayerId
““1 E
(
““E F
player
““F L
.
““L M
PlayerID
““M U
)
““U V
;
““V W
if
”” 
(
”” 
profile
”” 
==
”” 
null
”” #
||
””$ &
string
””' -
.
””- .
IsNullOrEmpty
””. ;
(
””; <
profile
””< C
.
””C D
	AvatarURL
””D M
)
””M N
)
””N O
{
‘‘ 
return
’’ 
ImageResponse
’’ (
.
’’( )
Failure
’’) 0
(
’’0 1
ErrorMessages
’’1 >
.
’’> ?
ProfileNotFound
’’? N
)
’’N O
;
’’O P
}
÷÷ 
string
ÿÿ !
normalizedAvatarUrl
ÿÿ *
=
ÿÿ+ ,
profile
ÿÿ- 4
.
ÿÿ4 5
	AvatarURL
ÿÿ5 >
.
ÿÿ> ?
Replace
ÿÿ? F
(
ÿÿF G
$char
ÿÿG K
,
ÿÿK L
$char
ÿÿM P
)
ÿÿP Q
;
ÿÿQ R
string
ŸŸ 
fileName
ŸŸ 
=
ŸŸ  !
Path
ŸŸ" &
.
ŸŸ& '
GetFileName
ŸŸ' 2
(
ŸŸ2 3!
normalizedAvatarUrl
ŸŸ3 F
)
ŸŸF G
;
ŸŸG H
string
⁄⁄ 
	imagePath
⁄⁄  
=
⁄⁄! "
Path
⁄⁄# '
.
⁄⁄' (
Combine
⁄⁄( /
(
⁄⁄/ 0
_imageFolderPath
⁄⁄0 @
,
⁄⁄@ A
fileName
⁄⁄B J
)
⁄⁄J K
;
⁄⁄K L
if
‹‹ 
(
‹‹ 
!
‹‹ 
File
‹‹ 
.
‹‹ 
Exists
‹‹  
(
‹‹  !
	imagePath
‹‹! *
)
‹‹* +
)
‹‹+ ,
{
›› 
return
ﬁﬁ 
ImageResponse
ﬁﬁ (
.
ﬁﬁ( )
Failure
ﬁﬁ) 0
(
ﬁﬁ0 1
ErrorMessages
ﬁﬁ1 >
.
ﬁﬁ> ?
ImageNotFound
ﬁﬁ? L
)
ﬁﬁL M
;
ﬁﬁM N
}
ﬂﬂ 
var
·· 

imageBytes
·· 
=
··  
File
··! %
.
··% &
ReadAllBytes
··& 2
(
··2 3
	imagePath
··3 <
)
··< =
;
··= >
if
„„ 
(
„„ 

imageBytes
„„ 
==
„„ !
null
„„" &
||
„„' )

imageBytes
„„* 4
.
„„4 5
Length
„„5 ;
==
„„< >
$num
„„? @
)
„„@ A
{
‰‰ 
return
ÂÂ 
ImageResponse
ÂÂ (
.
ÂÂ( )
Failure
ÂÂ) 0
(
ÂÂ0 1
ErrorMessages
ÂÂ1 >
.
ÂÂ> ?

EmptyImage
ÂÂ? I
)
ÂÂI J
;
ÂÂJ K
}
ÊÊ 
return
ËË 
ImageResponse
ËË $
.
ËË$ %
Success
ËË% ,
(
ËË, -

imageBytes
ËË- 7
,
ËË7 8
fileName
ËË9 A
,
ËËA B
$str
ËËC O
)
ËËO P
;
ËËP Q
}
ÈÈ 
catch
ÍÍ 
(
ÍÍ 
	Exception
ÍÍ 
ex
ÍÍ 
)
ÍÍ  
{
ÎÎ 
CustomLogger
ÏÏ 
.
ÏÏ 
Error
ÏÏ "
(
ÏÏ" #
$str
ÏÏ# C
,
ÏÏC D
ex
ÏÏE G
)
ÏÏG H
;
ÏÏH I
return
ÌÌ 
ImageResponse
ÌÌ $
.
ÌÌ$ %
Failure
ÌÌ% ,
(
ÌÌ, -
ErrorMessages
ÌÌ- :
.
ÌÌ: ;
GeneralException
ÌÌ; K
)
ÌÌK L
;
ÌÌL M
}
ÓÓ 
}
ÔÔ 	
public
ÚÚ 
byte
ÚÚ 
[
ÚÚ 
]
ÚÚ $
ConvertImageUrlToBytes
ÚÚ ,
(
ÚÚ, -
string
ÚÚ- 3
imageUrl
ÚÚ4 <
)
ÚÚ< =
{
ÛÛ 	
try
ÙÙ 
{
ıı 
string
ˆˆ 
filePath
ˆˆ 
=
ˆˆ  !
Path
ˆˆ" &
.
ˆˆ& '
Combine
ˆˆ' .
(
ˆˆ. /
	AppDomain
ˆˆ/ 8
.
ˆˆ8 9
CurrentDomain
ˆˆ9 F
.
ˆˆF G
BaseDirectory
ˆˆG T
,
ˆˆT U
imageUrl
ˆˆV ^
)
ˆˆ^ _
;
ˆˆ_ `
if
˜˜ 
(
˜˜ 
File
˜˜ 
.
˜˜ 
Exists
˜˜ 
(
˜˜  
filePath
˜˜  (
)
˜˜( )
)
˜˜) *
{
¯¯ 
return
˘˘ 
File
˘˘ 
.
˘˘  
ReadAllBytes
˘˘  ,
(
˘˘, -
filePath
˘˘- 5
)
˘˘5 6
;
˘˘6 7
}
˙˙ 
else
˚˚ 
{
¸¸ 
throw
˝˝ 
new
˝˝ #
FileNotFoundException
˝˝ 3
(
˝˝3 4
ErrorMessages
˝˝4 A
.
˝˝A B
ImageNotFound
˝˝B O
)
˝˝O P
;
˝˝P Q
}
˛˛ 
}
ˇˇ 
catch
ÄÄ 
(
ÄÄ 
	Exception
ÄÄ 
ex
ÄÄ 
)
ÄÄ  
{
ÅÅ 
CustomLogger
ÇÇ 
.
ÇÇ 
Error
ÇÇ "
(
ÇÇ" #
$str
ÇÇ# D
,
ÇÇD E
ex
ÇÇF H
)
ÇÇH I
;
ÇÇI J
throw
ÉÉ 
new
ÉÉ 
	Exception
ÉÉ #
(
ÉÉ# $
ErrorMessages
ÉÉ$ 1
.
ÉÉ1 2
GeneralException
ÉÉ2 B
)
ÉÉB C
;
ÉÉC D
}
ÑÑ 
}
ÖÖ 	
public
áá 
OperationResponse
áá  
	UpdateBio
áá! *
(
áá* +
string
áá+ 1
bio
áá2 5
,
áá5 6
string
áá7 =
username
áá> F
)
ááF G
{
àà 	
try
ââ 
{
ää 
var
ãã 
player
ãã 
=
ãã 
_playerRepository
ãã .
.
ãã. /
GetByUsername
ãã/ <
(
ãã< =
username
ãã= E
)
ããE F
;
ããF G
var
åå 
profile
åå 
=
åå  
_profileRepository
åå 0
.
åå0 1"
GetProfileByPlayerId
åå1 E
(
ååE F
player
ååF L
.
ååL M
PlayerID
ååM U
)
ååU V
;
ååV W
if
çç 
(
çç 
player
çç 
==
çç 
null
çç "
)
çç" #
{
éé 
return
èè 
OperationResponse
èè ,
.
èè, -
Failure
èè- 4
(
èè4 5
ErrorMessages
èè5 B
.
èèB C
UserNotFound
èèC O
)
èèO P
;
èèP Q
}
êê 
profile
íí 
.
íí 
Bio
íí 
=
íí 
bio
íí !
;
íí! " 
_profileRepository
ìì "
.
ìì" #
Update
ìì# )
(
ìì) *
profile
ìì* 1
)
ìì1 2
;
ìì2 3 
_profileRepository
îî "
.
îî" #
Save
îî# '
(
îî' (
)
îî( )
;
îî) *
return
ññ 
OperationResponse
ññ (
.
ññ( )
SuccessResult
ññ) 6
(
ññ6 7
)
ññ7 8
;
ññ8 9
}
óó 
catch
òò 
(
òò 
	Exception
òò 
ex
òò 
)
òò  
{
ôô 
CustomLogger
öö 
.
öö 
Error
öö "
(
öö" #
$str
öö# %
,
öö% &
ex
öö' )
)
öö) *
;
öö* +
return
õõ 
OperationResponse
õõ (
.
õõ( )
Failure
õõ) 0
(
õõ0 1
ErrorMessages
õõ1 >
.
õõ> ?
GeneralException
õõ? O
)
õõO P
;
õõP Q
}
úú 
}
ùù 	
public
üü 
string
üü 
GetBioByUsername
üü &
(
üü& '
string
üü' -
username
üü. 6
)
üü6 7
{
†† 	
try
°° 
{
¢¢ 
var
§§ 
player
§§ 
=
§§ 
_playerRepository
§§ .
.
§§. /
GetByUsername
§§/ <
(
§§< =
username
§§= E
)
§§E F
;
§§F G
if
•• 
(
•• 
player
•• 
==
•• 
null
•• "
)
••" #
{
¶¶ 
return
ßß 
$str
ßß ,
;
ßß, -
}
®® 
var
´´ 
profile
´´ 
=
´´  
_profileRepository
´´ 0
.
´´0 1"
GetProfileByPlayerId
´´1 E
(
´´E F
player
´´F L
.
´´L M
PlayerID
´´M U
)
´´U V
;
´´V W
if
¨¨ 
(
¨¨ 
profile
¨¨ 
==
¨¨ 
null
¨¨ #
)
¨¨# $
{
≠≠ 
return
ÆÆ 
$str
ÆÆ /
;
ÆÆ/ 0
}
ØØ 
return
≤≤ 
profile
≤≤ 
.
≤≤ 
Bio
≤≤ "
??
≤≤# %
$str
≤≤& ?
;
≤≤? @
}
≥≥ 
catch
¥¥ 
(
¥¥ 
	Exception
¥¥ 
ex
¥¥ 
)
¥¥  
{
µµ 
CustomLogger
∑∑ 
.
∑∑ 
Error
∑∑ "
(
∑∑" #
$str
∑∑# ?
,
∑∑? @
ex
∑∑A C
)
∑∑C D
;
∑∑D E
return
∏∏ 
$str
∏∏ 4
;
∏∏4 5
}
ππ 
}
∫∫ 	
}
ΩΩ 
}ææ éB
lC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\PlayerScoresService.cs
	namespace 	
Service
 
. 

Implements 
{ 
public 

class 
PlayerScoresService $
:% & 
IPlayerScoresService' ;
{ 
private 
readonly #
IPlayerScoresRepository 0
_scoreRepository1 A
;A B
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
public 
PlayerScoresService "
(" ##
IPlayerScoresRepository #
scoreRepository$ 3
,3 4
IPlayerRepository 
playerRepository .
). /
{ 	
_scoreRepository 
= 
scoreRepository .
;. /
_playerRepository 
= 
playerRepository  0
;0 1
} 	
public  
PlayerScoresResponse #
GetScoresByUsername$ 7
(7 8
string8 >
username? G
)G H
{ 	
try   
{!! 
var"" 
player"" 
="" 
_playerRepository"" .
."". /
GetByUsername""/ <
(""< =
username""= E
)""E F
;""F G
if## 
(## 
player## 
==## 
null## "
)##" #
{$$ 
return%%  
PlayerScoresResponse%% /
.%%/ 0
Failure%%0 7
(%%7 8
ErrorMessages%%8 E
.%%E F
UserNotFound%%F R
)%%R S
;%%S T
}&& 
var(( 
scores(( 
=(( 
_scoreRepository(( -
.((- .
GetScoresByPlayerId((. A
(((A B
player((B H
.((H I
PlayerID((I Q
)((Q R
;((R S
if)) 
()) 
scores)) 
==)) 
null)) "
)))" #
{** 
return++  
PlayerScoresResponse++ /
.++/ 0
Failure++0 7
(++7 8
ErrorMessages++8 E
.++E F
ScoreNotFound++F S
)++S T
;++T U
},, 
var.. 
	scoresDto.. 
=.. 
new..  #
PlayerScoresDTO..$ 3
{// 
PlayerId00 
=00 
scores00 %
.00% &
PlayerID00& .
,00. /
Wins11 
=11 
scores11 !
.11! "
Wins11" &
,11& '
Losses22 
=22 
scores22 #
.22# $
Losses22$ *
}33 
;33 
return55  
PlayerScoresResponse55 +
.55+ ,
SuccessResult55, 9
(559 :
	scoresDto55: C
)55C D
;55D E
}66 
catch77 
(77 
SqlException77 
ex77  "
)77" #
{88 
string99 
errorMessage99 #
=99$ %
SqlErrorHandler99& 5
.995 6
GetErrorMessage996 E
(99E F
ex99F H
)99H I
;99I J
return::  
PlayerScoresResponse:: +
.::+ ,
Failure::, 3
(::3 4
errorMessage::4 @
)::@ A
;::A B
};; 
catch<< 
(<< 
	Exception<< 
ex<< 
)<<  
{== 
Console>> 
.>> 
	WriteLine>> !
(>>! "
$">>" $
$str>>$ 6
{>>6 7
ex>>7 9
.>>9 :
Message>>: A
}>>A B
">>B C
)>>C D
;>>D E
return??  
PlayerScoresResponse?? +
.??+ ,
Failure??, 3
(??3 4
ErrorMessages??4 A
.??A B
GeneralException??B R
)??R S
;??S T
}@@ 
}AA 	
publicCC 
OperationResponseCC  
IncrementWinsCC! .
(CC. /
stringCC/ 5
usernameCC6 >
)CC> ?
{DD 	
tryEE 
{FF 
varGG 
playerGG 
=GG 
_playerRepositoryGG .
.GG. /
GetByUsernameGG/ <
(GG< =
usernameGG= E
)GGE F
;GGF G
ifHH 
(HH 
playerHH 
==HH 
nullHH "
)HH" #
{II 
returnJJ 
OperationResponseJJ ,
.JJ, -
FailureJJ- 4
(JJ4 5
ErrorMessagesJJ5 B
.JJB C
UserNotFoundJJC O
)JJO P
;JJP Q
}KK 
_scoreRepositoryMM  
.MM  !
IncrementWinsMM! .
(MM. /
playerMM/ 5
.MM5 6
PlayerIDMM6 >
)MM> ?
;MM? @
_scoreRepositoryNN  
.NN  !
SaveNN! %
(NN% &
)NN& '
;NN' (
returnPP 
OperationResponsePP (
.PP( )
SuccessResultPP) 6
(PP6 7
$strPP7 V
)PPV W
;PPW X
}QQ 
catchRR 
(RR 
SqlExceptionRR 
exRR  "
)RR" #
{SS 
stringTT 
errorMessageTT #
=TT$ %
SqlErrorHandlerTT& 5
.TT5 6
GetErrorMessageTT6 E
(TTE F
exTTF H
)TTH I
;TTI J
returnUU 
OperationResponseUU (
.UU( )
FailureUU) 0
(UU0 1
errorMessageUU1 =
)UU= >
;UU> ?
}VV 
catchWW 
(WW 
	ExceptionWW 
exWW 
)WW  
{XX 
ConsoleYY 
.YY 
	WriteLineYY !
(YY! "
$"YY" $
$strYY$ 6
{YY6 7
exYY7 9
.YY9 :
MessageYY: A
}YYA B
"YYB C
)YYC D
;YYD E
returnZZ 
OperationResponseZZ (
.ZZ( )
FailureZZ) 0
(ZZ0 1
ErrorMessagesZZ1 >
.ZZ> ?
GeneralExceptionZZ? O
)ZZO P
;ZZP Q
}[[ 
}\\ 	
public^^ 
OperationResponse^^  
IncrementLosses^^! 0
(^^0 1
string^^1 7
username^^8 @
)^^@ A
{__ 	
try`` 
{aa 
varbb 
playerbb 
=bb 
_playerRepositorybb .
.bb. /
GetByUsernamebb/ <
(bb< =
usernamebb= E
)bbE F
;bbF G
ifcc 
(cc 
playercc 
==cc 
nullcc "
)cc" #
{dd 
returnee 
OperationResponseee ,
.ee, -
Failureee- 4
(ee4 5
ErrorMessagesee5 B
.eeB C
UserNotFoundeeC O
)eeO P
;eeP Q
}ff 
_scoreRepositoryhh  
.hh  !
IncrementLosseshh! 0
(hh0 1
playerhh1 7
.hh7 8
PlayerIDhh8 @
)hh@ A
;hhA B
_scoreRepositoryii  
.ii  !
Saveii! %
(ii% &
)ii& '
;ii' (
returnkk 
OperationResponsekk (
.kk( )
SuccessResultkk) 6
(kk6 7
$strkk7 W
)kkW X
;kkX Y
}ll 
catchmm 
(mm 
SqlExceptionmm 
exmm  "
)mm" #
{nn 
stringoo 
errorMessageoo #
=oo$ %
SqlErrorHandleroo& 5
.oo5 6
GetErrorMessageoo6 E
(ooE F
exooF H
)ooH I
;ooI J
returnpp 
OperationResponsepp (
.pp( )
Failurepp) 0
(pp0 1
errorMessagepp1 =
)pp= >
;pp> ?
}qq 
catchrr 
(rr 
	Exceptionrr 
exrr 
)rr  
{ss 
Consolett 
.tt 
	WriteLinett !
(tt! "
$"tt" $
$strtt$ 6
{tt6 7
extt7 9
.tt9 :
Messagett: A
}ttA B
"ttB C
)ttC D
;ttD E
returnuu 
OperationResponseuu (
.uu( )
Failureuu) 0
(uu0 1
ErrorMessagesuu1 >
.uu> ?
GeneralExceptionuu? O
)uuO P
;uuP Q
}vv 
}ww 	
}xx 
}yy Ó€
eC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\LobbyService.cs
	namespace 	
Service
 
. 

Implements 
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
,I J
ConcurrencyModeK Z
=[ \
ConcurrencyMode] l
.l m
Multiplem u
)u v
]v w
public 

class 
LobbyService 
: 
ILobbyService  -
{ 
private 
static 
readonly 

Dictionary  *
<* +
string+ 1
,1 2
Lobby3 8
>8 9
_activeLobbies: H
=I J
newK N

DictionaryO Y
<Y Z
stringZ `
,` a
Lobbyb g
>g h
(h i
)i j
;j k
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
string5 ;
,; <
ILobbyCallback= K
>K L
_connectedPlayersM ^
=_ `
newa d 
ConcurrentDictionarye y
<y z
string	z Ä
,
Ä Å
ILobbyCallback
Ç ê
>
ê ë
(
ë í
)
í ì
;
ì î
public 
LobbyResponse 
CreateLobby (
(( )!
CreateLobbyRequestDTO) >
request? F
)F G
{ 	
if 
( 
_activeLobbies 
. 
Values %
.% &
Any& )
() *
l* +
=>, .
l/ 0
.0 1
Name1 5
==6 8
request9 @
.@ A
NameA E
)E F
)F G
{ 
return 
LobbyResponse $
.$ %
Failure% ,
(, -
ErrorMessages- :
.: ;
DuplicateLobbyName; M
)M N
;N O
} 
var 
lobby 
= 
new 
Lobby !
{ 
Name 
= 
request 
. 
Name #
,# $
	IsPrivate 
= 
request #
.# $
	IsPrivate$ -
,- .
Password   
=   
request   "
.  " #
	IsPrivate  # ,
?  - .
request  / 6
.  6 7
Password  7 ?
:  @ A
null  B F
,  F G
Host!! 
=!! 
request!! 
.!! 
Username!! '
}"" 
;"" 
RegisterCallback$$ 
($$ 
request$$ $
.$$$ %
Username$$% -
)$$- .
;$$. /
lobby&& 
.&& 
	AddPlayer&& 
(&& 
request&& #
.&&# $
Username&&$ ,
)&&, -
;&&- .
_activeLobbies'' 
['' 
lobby''  
.''  !
LobbyId''! (
]''( )
=''* +
lobby'', 1
;''1 2
Console)) 
.)) 
	WriteLine)) 
()) 
$"))  
$str))  )
{))) *
request))* 1
.))1 2
Username))2 :
})): ;
$str)); d
{))d e
lobby))e j
.))j k
Name))k o
}))o p
$str	))p Å
"
))Å Ç
)
))Ç É
;
))É Ñ
var++ 
lobbyDto++ 
=++ 
new++ 
LobbyDTO++ '
{,, 
LobbyId-- 
=-- 
lobby-- 
.--  
LobbyId--  '
,--' (
Name.. 
=.. 
lobby.. 
... 
Name.. !
,..! "
	IsPrivate// 
=// 
lobby// !
.//! "
	IsPrivate//" +
,//+ ,
CurrentPlayers00 
=00  
lobby00! &
.00& '
Players00' .
.00. /
Count00/ 4
,004 5

MaxPlayers11 
=11 
lobby11 "
.11" #

MaxPlayers11# -
,11- .
Host22 
=22 
lobby22 
.22 
Host22 !
,22! "
Players33 
=33 
new33 
List33 "
<33" #
string33# )
>33) *
(33* +
lobby33+ 0
.330 1
Players331 8
)338 9
}44 
;44 
return66 
LobbyResponse66  
.66  !
SuccessResult66! .
(66. /
lobbyDto66/ 7
)667 8
;668 9
}77 	
public:: 
LobbyResponse:: 
	JoinLobby:: &
(::& '
JoinLobbyRequestDTO::' :
request::; B
)::B C
{;; 	
if<< 
(<< 
!<< 
_activeLobbies<< 
.<<  
TryGetValue<<  +
(<<+ ,
request<<, 3
.<<3 4
LobbyId<<4 ;
,<<; <
out<<= @
var<<A D
lobby<<E J
)<<J K
)<<K L
{== 
return>> 
LobbyResponse>> $
.>>$ %
Failure>>% ,
(>>, -
ErrorMessages>>- :
.>>: ;
LobbyNotFound>>; H
)>>H I
;>>I J
}?? 
ifAA 
(AA 
lobbyAA 
.AA 
	IsPrivateAA 
&&AA  "
lobbyAA# (
.AA( )
PasswordAA) 1
!=AA2 4
requestAA5 <
.AA< =
PasswordAA= E
)AAE F
{BB 
returnCC 
LobbyResponseCC $
.CC$ %
FailureCC% ,
(CC, -
ErrorMessagesCC- :
.CC: ; 
InvalidLobbyPasswordCC; O
)CCO P
;CCP Q
}DD 
ifFF 
(FF 
!FF 
lobbyFF 
.FF 
CanJoinFF 
(FF 
requestFF &
.FF& '
UsernameFF' /
,FF/ 0
requestFF1 8
.FF8 9
PasswordFF9 A
)FFA B
)FFB C
{GG 
returnHH 
LobbyResponseHH $
.HH$ %
FailureHH% ,
(HH, -
ErrorMessagesHH- :
.HH: ;
	LobbyFullHH; D
)HHD E
;HHE F
}II 
lobbyKK 
.KK 
	AddPlayerKK 
(KK 
requestKK #
.KK# $
UsernameKK$ ,
)KK, -
;KK- .
RegisterCallbackLL 
(LL 
requestLL $
.LL$ %
UsernameLL% -
)LL- .
;LL. / 
NotifyPlayersInLobbyNN  
(NN  !
lobbyNN! &
,NN& '
requestNN( /
.NN/ 0
UsernameNN0 8
)NN8 9
;NN9 :
varPP 
lobbyDtoPP 
=PP 
newPP 
LobbyDTOPP '
{QQ 
LobbyIdRR 
=RR 
lobbyRR 
.RR  
LobbyIdRR  '
,RR' (
NameSS 
=SS 
lobbySS 
.SS 
NameSS !
,SS! "
	IsPrivateTT 
=TT 
lobbyTT !
.TT! "
	IsPrivateTT" +
,TT+ ,
CurrentPlayersUU 
=UU  
lobbyUU! &
.UU& '
PlayersUU' .
.UU. /
CountUU/ 4
,UU4 5

MaxPlayersVV 
=VV 
lobbyVV "
.VV" #

MaxPlayersVV# -
,VV- .
HostWW 
=WW 
lobbyWW 
.WW 
HostWW !
,WW! "
PlayersXX 
=XX 
newXX 
ListXX "
<XX" #
stringXX# )
>XX) *
(XX* +
lobbyXX+ 0
.XX0 1
PlayersXX1 8
)XX8 9
}YY 
;YY 
return[[ 
LobbyResponse[[  
.[[  !
SuccessResult[[! .
([[. /
lobbyDto[[/ 7
)[[7 8
;[[8 9
}\\ 	
public^^ 
LobbyResponse^^ 

LeaveLobby^^ '
(^^' (
string^^( .
lobbyId^^/ 6
,^^6 7
string^^8 >
username^^? G
)^^G H
{__ 	
if`` 
(`` 
!`` 
_activeLobbies`` 
.``  
TryGetValue``  +
(``+ ,
lobbyId``, 3
,``3 4
out``5 8
var``9 <
lobby``= B
)``B C
)``C D
{aa 
returnbb 
LobbyResponsebb $
.bb$ %
Failurebb% ,
(bb, -
ErrorMessagesbb- :
.bb: ;
LobbyNotFoundbb; H
)bbH I
;bbI J
}cc 
lobbyee 
.ee 
RemovePlayeree 
(ee 
usernameee '
)ee' (
;ee( )
_connectedPlayersff 
.ff 
	TryRemoveff '
(ff' (
usernameff( 0
,ff0 1
outff2 5
_ff6 7
)ff7 8
;ff8 9
NotifyPlayerLefthh 
(hh 
lobbyhh "
,hh" #
usernamehh$ ,
)hh, -
;hh- .
ifjj 
(jj 
lobbyjj 
.jj 
IsEmptyjj 
(jj 
)jj 
)jj  
{kk 
_activeLobbiesll 
.ll 
Removell %
(ll% &
lobbyIdll& -
)ll- .
;ll. /
}mm 
varoo 
lobbyDtooo 
=oo 
newoo 
LobbyDTOoo '
{pp 
LobbyIdqq 
=qq 
lobbyqq 
.qq  
LobbyIdqq  '
,qq' (
Namerr 
=rr 
lobbyrr 
.rr 
Namerr !
,rr! "
	IsPrivatess 
=ss 
lobbyss !
.ss! "
	IsPrivatess" +
,ss+ ,
CurrentPlayerstt 
=tt  
lobbytt! &
.tt& '
Playerstt' .
.tt. /
Counttt/ 4
,tt4 5

MaxPlayersuu 
=uu 
lobbyuu "
.uu" #

MaxPlayersuu# -
,uu- .
Hostvv 
=vv 
lobbyvv 
.vv 
Hostvv !
,vv! "
Playersww 
=ww 
newww 
Listww "
<ww" #
stringww# )
>ww) *
(ww* +
lobbyww+ 0
.ww0 1
Playersww1 8
)ww8 9
}xx 
;xx 
returnzz 
LobbyResponsezz  
.zz  !
SuccessResultzz! .
(zz. /
lobbyDtozz/ 7
)zz7 8
;zz8 9
}{{ 	
private}} 
void}} 
RegisterCallback}} %
(}}% &
string}}& ,
username}}- 5
)}}5 6
{~~ 	
var 
callback 
= 
OperationContext +
.+ ,
Current, 3
.3 4
GetCallbackChannel4 F
<F G
ILobbyCallbackG U
>U V
(V W
)W X
;X Y
_connectedPlayers
ÄÄ 
.
ÄÄ 
TryAdd
ÄÄ $
(
ÄÄ$ %
username
ÄÄ% -
,
ÄÄ- .
callback
ÄÄ/ 7
)
ÄÄ7 8
;
ÄÄ8 9
var
ÇÇ 
contextChannel
ÇÇ 
=
ÇÇ  
(
ÇÇ! "
IContextChannel
ÇÇ" 1
)
ÇÇ1 2
callback
ÇÇ2 :
;
ÇÇ: ;
contextChannel
ÉÉ 
.
ÉÉ 
Closed
ÉÉ !
+=
ÉÉ" $
(
ÉÉ% &
sender
ÉÉ& ,
,
ÉÉ, -
args
ÉÉ. 2
)
ÉÉ2 3
=>
ÉÉ4 6$
HandleClientDisconnect
ÉÉ7 M
(
ÉÉM N
username
ÉÉN V
)
ÉÉV W
;
ÉÉW X
contextChannel
ÑÑ 
.
ÑÑ 
Faulted
ÑÑ "
+=
ÑÑ# %
(
ÑÑ& '
sender
ÑÑ' -
,
ÑÑ- .
args
ÑÑ/ 3
)
ÑÑ3 4
=>
ÑÑ5 7$
HandleClientDisconnect
ÑÑ8 N
(
ÑÑN O
username
ÑÑO W
)
ÑÑW X
;
ÑÑX Y
}
ÖÖ 	
private
áá 
void
áá $
HandleClientDisconnect
áá +
(
áá+ ,
string
áá, 2
username
áá3 ;
)
áá; <
{
àà 	
if
ââ 
(
ââ 
_connectedPlayers
ââ !
.
ââ! "
	TryRemove
ââ" +
(
ââ+ ,
username
ââ, 4
,
ââ4 5
out
ââ6 9
_
ââ: ;
)
ââ; <
)
ââ< =
{
ää 
var
ãã 
lobby
ãã 
=
ãã 
_activeLobbies
ãã *
.
ãã* +
Values
ãã+ 1
.
ãã1 2
FirstOrDefault
ãã2 @
(
ãã@ A
l
ããA B
=>
ããC E
l
ããF G
.
ããG H
Players
ããH O
.
ããO P
Contains
ããP X
(
ããX Y
username
ããY a
)
ããa b
)
ããb c
;
ããc d
if
åå 
(
åå 
lobby
åå 
!=
åå 
null
åå !
)
åå! "
{
çç 
lobby
éé 
.
éé 
RemovePlayer
éé &
(
éé& '
username
éé' /
)
éé/ 0
;
éé0 1
NotifyPlayerLeft
èè $
(
èè$ %
lobby
èè% *
,
èè* +
username
èè, 4
)
èè4 5
;
èè5 6
if
ëë 
(
ëë 
lobby
ëë 
.
ëë 
IsEmpty
ëë %
(
ëë% &
)
ëë& '
)
ëë' (
{
íí 
_activeLobbies
ìì &
.
ìì& '
Remove
ìì' -
(
ìì- .
lobby
ìì. 3
.
ìì3 4
LobbyId
ìì4 ;
)
ìì; <
;
ìì< =
}
îî 
}
ïï 
}
ññ 
}
óó 	
private
ôô 
void
ôô "
NotifyPlayersInLobby
ôô )
(
ôô) *
Lobby
ôô* /
lobby
ôô0 5
,
ôô5 6
string
ôô7 =
	newPlayer
ôô> G
)
ôôG H
{
öö 	
string
õõ 
joinMessage
õõ 
=
õõ  
$"
õõ! #
{
õõ# $
	newPlayer
õõ$ -
}
õõ- .
$str
õõ. D
{
õõD E
lobby
õõE J
.
õõJ K
Name
õõK O
}
õõO P
$str
õõP Q
"
õõQ R
;
õõR S
Console
úú 
.
úú 
	WriteLine
úú 
(
úú 
joinMessage
úú )
)
úú) *
;
úú* +
foreach
ûû 
(
ûû 
var
ûû 
player
ûû 
in
ûû  "
lobby
ûû# (
.
ûû( )
Players
ûû) 0
)
ûû0 1
{
üü 
if
†† 
(
†† 
player
†† 
!=
†† 
	newPlayer
†† '
&&
††( *
_connectedPlayers
††+ <
.
††< =
TryGetValue
††= H
(
††H I
player
††I O
,
††O P
out
††Q T
var
††U X
callback
††Y a
)
††a b
)
††b c
{
°° 
try
¢¢ 
{
££ 
callback
§§  
.
§§  ! 
NotifyPlayerJoined
§§! 3
(
§§3 4
	newPlayer
§§4 =
,
§§= >
lobby
§§? D
.
§§D E
LobbyId
§§E L
)
§§L M
;
§§M N
callback
••  
.
••  !'
NotifyPlayerJoinedMessage
••! :
(
••: ;
joinMessage
••; F
)
••F G
;
••G H
}
¶¶ 
catch
ßß 
(
ßß 
	Exception
ßß $
ex
ßß% '
)
ßß' (
{
®® 
Console
©© 
.
©©  
	WriteLine
©©  )
(
©©) *
$"
©©* ,
$str
©©, C
{
©©C D
player
©©D J
}
©©J K
$str
©©K M
{
©©M N
ex
©©N P
.
©©P Q
Message
©©Q X
}
©©X Y
"
©©Y Z
)
©©Z [
;
©©[ \$
HandleClientDisconnect
™™ .
(
™™. /
player
™™/ 5
)
™™5 6
;
™™6 7
}
´´ 
}
¨¨ 
}
≠≠ 
}
ÆÆ 	
private
∞∞ 
void
∞∞ 
NotifyPlayerLeft
∞∞ %
(
∞∞% &
Lobby
∞∞& +
lobby
∞∞, 1
,
∞∞1 2
string
∞∞3 9

playerLeft
∞∞: D
)
∞∞D E
{
±± 	
string
≤≤ 
leaveMessage
≤≤ 
=
≤≤  !
$"
≤≤" $
{
≤≤$ %

playerLeft
≤≤% /
}
≤≤/ 0
$str
≤≤0 D
{
≤≤D E
lobby
≤≤E J
.
≤≤J K
Name
≤≤K O
}
≤≤O P
$str
≤≤P Q
"
≤≤Q R
;
≤≤R S
Console
≥≥ 
.
≥≥ 
	WriteLine
≥≥ 
(
≥≥ 
leaveMessage
≥≥ *
)
≥≥* +
;
≥≥+ ,
foreach
µµ 
(
µµ 
var
µµ 
player
µµ 
in
µµ  "
lobby
µµ# (
.
µµ( )
Players
µµ) 0
)
µµ0 1
{
∂∂ 
if
∑∑ 
(
∑∑ 
player
∑∑ 
!=
∑∑ 

playerLeft
∑∑ (
&&
∑∑) +
_connectedPlayers
∑∑, =
.
∑∑= >
TryGetValue
∑∑> I
(
∑∑I J
player
∑∑J P
,
∑∑P Q
out
∑∑R U
var
∑∑V Y
callback
∑∑Z b
)
∑∑b c
)
∑∑c d
{
∏∏ 
try
ππ 
{
∫∫ 
callback
ªª  
.
ªª  !
NotifyPlayerLeft
ªª! 1
(
ªª1 2

playerLeft
ªª2 <
,
ªª< =
lobby
ªª> C
.
ªªC D
LobbyId
ªªD K
)
ªªK L
;
ªªL M
callback
ºº  
.
ºº  !%
NotifyPlayerLeftMessage
ºº! 8
(
ºº8 9
leaveMessage
ºº9 E
)
ººE F
;
ººF G
}
ΩΩ 
catch
ææ 
(
ææ 
	Exception
ææ $
ex
ææ% '
)
ææ' (
{
øø 
Console
¿¿ 
.
¿¿  
	WriteLine
¿¿  )
(
¿¿) *
$"
¿¿* ,
$str
¿¿, C
{
¿¿C D
player
¿¿D J
}
¿¿J K
$str
¿¿K M
{
¿¿M N
ex
¿¿N P
.
¿¿P Q
Message
¿¿Q X
}
¿¿X Y
"
¿¿Y Z
)
¿¿Z [
;
¿¿[ \$
HandleClientDisconnect
¡¡ .
(
¡¡. /
player
¡¡/ 5
)
¡¡5 6
;
¡¡6 7
}
¬¬ 
}
√√ 
}
ƒƒ 
}
≈≈ 	
public
«« 
List
«« 
<
«« 
LobbyDTO
«« 
>
«« 
GetAllLobbies
«« +
(
««+ ,
)
««, -
{
»» 	
return
…… 
_activeLobbies
…… !
.
……! "
Values
……" (
.
……( )
Select
……) /
(
……/ 0
lobby
……0 5
=>
……6 8
new
……9 <
LobbyDTO
……= E
{
   
LobbyId
ÀÀ 
=
ÀÀ 
lobby
ÀÀ 
.
ÀÀ  
LobbyId
ÀÀ  '
,
ÀÀ' (
Name
ÃÃ 
=
ÃÃ 
lobby
ÃÃ 
.
ÃÃ 
Name
ÃÃ !
,
ÃÃ! "
	IsPrivate
ÕÕ 
=
ÕÕ 
lobby
ÕÕ !
.
ÕÕ! "
	IsPrivate
ÕÕ" +
,
ÕÕ+ ,
CurrentPlayers
ŒŒ 
=
ŒŒ  
lobby
ŒŒ! &
.
ŒŒ& '
Players
ŒŒ' .
.
ŒŒ. /
Count
ŒŒ/ 4
,
ŒŒ4 5

MaxPlayers
œœ 
=
œœ 
lobby
œœ "
.
œœ" #

MaxPlayers
œœ# -
,
œœ- .
Host
–– 
=
–– 
lobby
–– 
.
–– 
Host
–– !
,
––! "
Players
—— 
=
—— 
new
—— 
List
—— "
<
——" #
string
——# )
>
——) *
(
——* +
lobby
——+ 0
.
——0 1
Players
——1 8
)
——8 9
}
““ 
)
““ 
.
““ 
ToList
““ 
(
““ 
)
““ 
;
““ 
}
”” 	
public
’’ 
LobbyResponse
’’ 

KickPlayer
’’ '
(
’’' (
string
’’( .
lobbyId
’’/ 6
,
’’6 7
string
’’8 >
hostUsername
’’? K
,
’’K L
string
’’M S
targetUsername
’’T b
)
’’b c
{
÷÷ 	
if
◊◊ 
(
◊◊ 
!
◊◊ 
_activeLobbies
◊◊ 
.
◊◊  
TryGetValue
◊◊  +
(
◊◊+ ,
lobbyId
◊◊, 3
,
◊◊3 4
out
◊◊5 8
var
◊◊9 <
lobby
◊◊= B
)
◊◊B C
)
◊◊C D
{
ÿÿ 
return
ŸŸ 
LobbyResponse
ŸŸ $
.
ŸŸ$ %
Failure
ŸŸ% ,
(
ŸŸ, -
ErrorMessages
ŸŸ- :
.
ŸŸ: ;
LobbyNotFound
ŸŸ; H
)
ŸŸH I
;
ŸŸI J
}
⁄⁄ 
if
‹‹ 
(
‹‹ 
lobby
‹‹ 
.
‹‹ 
Host
‹‹ 
!=
‹‹ 
hostUsername
‹‹ *
)
‹‹* +
{
›› 
return
ﬁﬁ 
LobbyResponse
ﬁﬁ $
.
ﬁﬁ$ %
Failure
ﬁﬁ% ,
(
ﬁﬁ, -
ErrorMessages
ﬁﬁ- :
.
ﬁﬁ: ;
NotLobbyHost
ﬁﬁ; G
)
ﬁﬁG H
;
ﬁﬁH I
}
ﬂﬂ 
if
·· 
(
·· 
!
·· 
lobby
·· 
.
·· 
Players
·· 
.
·· 
Contains
·· '
(
··' (
targetUsername
··( 6
)
··6 7
)
··7 8
{
‚‚ 
return
„„ 
LobbyResponse
„„ $
.
„„$ %
Failure
„„% ,
(
„„, -
ErrorMessages
„„- :
.
„„: ;
PlayerNotInLobby
„„; K
)
„„K L
;
„„L M
}
‰‰ 
lobby
ÊÊ 
.
ÊÊ 
RemovePlayer
ÊÊ 
(
ÊÊ 
targetUsername
ÊÊ -
)
ÊÊ- .
;
ÊÊ. /
_connectedPlayers
ÁÁ 
.
ÁÁ 
	TryRemove
ÁÁ '
(
ÁÁ' (
targetUsername
ÁÁ( 6
,
ÁÁ6 7
out
ÁÁ8 ;
_
ÁÁ< =
)
ÁÁ= >
;
ÁÁ> ?
NotifyPlayerLeft
ÈÈ 
(
ÈÈ 
lobby
ÈÈ "
,
ÈÈ" #
targetUsername
ÈÈ$ 2
)
ÈÈ2 3
;
ÈÈ3 4
var
ÎÎ 
lobbyDto
ÎÎ 
=
ÎÎ 
new
ÎÎ 
LobbyDTO
ÎÎ '
{
ÏÏ 
LobbyId
ÌÌ 
=
ÌÌ 
lobby
ÌÌ 
.
ÌÌ  
LobbyId
ÌÌ  '
,
ÌÌ' (
Name
ÓÓ 
=
ÓÓ 
lobby
ÓÓ 
.
ÓÓ 
Name
ÓÓ !
,
ÓÓ! "
	IsPrivate
ÔÔ 
=
ÔÔ 
lobby
ÔÔ !
.
ÔÔ! "
	IsPrivate
ÔÔ" +
,
ÔÔ+ ,
CurrentPlayers
 
=
  
lobby
! &
.
& '
Players
' .
.
. /
Count
/ 4
,
4 5

MaxPlayers
ÒÒ 
=
ÒÒ 
lobby
ÒÒ "
.
ÒÒ" #

MaxPlayers
ÒÒ# -
,
ÒÒ- .
Host
ÚÚ 
=
ÚÚ 
lobby
ÚÚ 
.
ÚÚ 
Host
ÚÚ !
,
ÚÚ! "
Players
ÛÛ 
=
ÛÛ 
new
ÛÛ 
List
ÛÛ "
<
ÛÛ" #
string
ÛÛ# )
>
ÛÛ) *
(
ÛÛ* +
lobby
ÛÛ+ 0
.
ÛÛ0 1
Players
ÛÛ1 8
)
ÛÛ8 9
}
ÙÙ 
;
ÙÙ 
return
ˆˆ 
LobbyResponse
ˆˆ  
.
ˆˆ  !
SuccessResult
ˆˆ! .
(
ˆˆ. /
lobbyDto
ˆˆ/ 7
)
ˆˆ7 8
;
ˆˆ8 9
}
˜˜ 	
public
¯¯ 
OperationResponse
¯¯  
	StartGame
¯¯! *
(
¯¯* +
string
¯¯+ 1
lobbyId
¯¯2 9
,
¯¯9 :
string
¯¯; A
hostUsername
¯¯B N
)
¯¯N O
{
˘˘ 	
if
˙˙ 
(
˙˙ 
!
˙˙ 
_activeLobbies
˙˙ 
.
˙˙  
TryGetValue
˙˙  +
(
˙˙+ ,
lobbyId
˙˙, 3
,
˙˙3 4
out
˙˙5 8
var
˙˙9 <
lobby
˙˙= B
)
˙˙B C
)
˙˙C D
{
˚˚ 
return
¸¸ 
OperationResponse
¸¸ (
.
¸¸( )
Failure
¸¸) 0
(
¸¸0 1
$str
¸¸1 C
)
¸¸C D
;
¸¸D E
}
˝˝ 
if
ˇˇ 
(
ˇˇ 
lobby
ˇˇ 
.
ˇˇ 
Host
ˇˇ 
!=
ˇˇ 
hostUsername
ˇˇ *
)
ˇˇ* +
{
ÄÄ 
return
ÅÅ 
OperationResponse
ÅÅ (
.
ÅÅ( )
Failure
ÅÅ) 0
(
ÅÅ0 1
$str
ÅÅ1 T
)
ÅÅT U
;
ÅÅU V
}
ÇÇ 
if
ÑÑ 
(
ÑÑ 
lobby
ÑÑ 
.
ÑÑ 
Players
ÑÑ 
.
ÑÑ 
Count
ÑÑ #
<
ÑÑ$ %
$num
ÑÑ& '
)
ÑÑ' (
{
ÖÖ 
return
ÜÜ 
OperationResponse
ÜÜ (
.
ÜÜ( )
Failure
ÜÜ) 0
(
ÜÜ0 1
$str
ÜÜ1 X
)
ÜÜX Y
;
ÜÜY Z
}
áá 
bool
ââ 
success
ââ 
=
ââ $
NotifyPlayersStartGame
ââ 1
(
ââ1 2
lobby
ââ2 7
)
ââ7 8
;
ââ8 9
if
ãã 
(
ãã 
!
ãã 
success
ãã 
)
ãã 
{
åå 
return
çç 
OperationResponse
çç (
.
çç( )
Failure
çç) 0
(
çç0 1
$str
çç1 t
)
ççt u
;
ççu v
}
éé 
return
êê 
OperationResponse
êê $
.
êê$ %
SuccessResult
êê% 2
(
êê2 3
$str
êê3 O
)
êêO P
;
êêP Q
}
ëë 	
private
ìì 
bool
ìì $
NotifyPlayersStartGame
ìì +
(
ìì+ ,
Lobby
ìì, 1
lobby
ìì2 7
)
ìì7 8
{
îî 	
bool
ïï (
allNotificationsSuccessful
ïï +
=
ïï, -
true
ïï. 2
;
ïï2 3
foreach
óó 
(
óó 
var
óó 
player
óó 
in
óó  "
lobby
óó# (
.
óó( )
Players
óó) 0
)
óó0 1
{
òò 
if
ôô 
(
ôô 
player
ôô 
==
ôô 
lobby
ôô #
.
ôô# $
Host
ôô$ (
)
ôô( )
continue
ôô* 2
;
ôô2 3
if
õõ 
(
õõ 
_connectedPlayers
õõ %
.
õõ% &
TryGetValue
õõ& 1
(
õõ1 2
player
õõ2 8
,
õõ8 9
out
õõ: =
var
õõ> A
callback
õõB J
)
õõJ K
)
õõK L
{
úú 
try
ùù 
{
ûû 
Console
üü 
.
üü  
	WriteLine
üü  )
(
üü) *
$"
üü* ,
$str
üü, =
{
üü= >
player
üü> D
}
üüD E
$str
üüE a
{
üüa b
lobby
üüb g
.
üüg h
LobbyId
üüh o
}
üüo p
"
üüp q
)
üüq r
;
üür s
callback
††  
.
††  !#
StartGameNotification
††! 6
(
††6 7
lobby
††7 <
.
††< =
LobbyId
††= D
)
††D E
;
††E F
}
°° 
catch
¢¢ 
(
¢¢ 
	Exception
¢¢ $
ex
¢¢% '
)
¢¢' (
{
££ 
Console
§§ 
.
§§  
	WriteLine
§§  )
(
§§) *
$"
§§* ,
$str
§§, C
{
§§C D
player
§§D J
}
§§J K
$str
§§K [
{
§§[ \
ex
§§\ ^
.
§§^ _
Message
§§_ f
}
§§f g
"
§§g h
)
§§h i
;
§§i j$
HandleClientDisconnect
•• .
(
••. /
player
••/ 5
)
••5 6
;
••6 7(
allNotificationsSuccessful
¶¶ 2
=
¶¶3 4
false
¶¶5 :
;
¶¶: ;
}
ßß 
}
®® 
}
©© 
return
´´ (
allNotificationsSuccessful
´´ -
;
´´- .
}
¨¨ 	
}
ÆÆ 
}ØØ èK
dC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\GameService.cs
	namespace 	
Service
 
. 

Implements 
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
,I J
ConcurrencyModeK Z
=[ \
ConcurrencyMode] l
.l m
Multiplem u
)u v
]v w
public 

class 
GameService 
: 
IGameService +
{ 
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
string5 ;
,; <
GameSession= H
>H I
_activeGamesJ V
=W X
newY \ 
ConcurrentDictionary] q
<q r
stringr x
,x y
GameSession	z Ö
>
Ö Ü
(
Ü á
)
á à
;
à â
public 
OperationResponse  
InitializeGame! /
(/ 0
string0 6
lobbyId7 >
,> ?
List@ D
<D E
stringE K
>K L
playersM T
)T U
{ 	
CustomLogger 
. 
Info 
( 
$"  
$str  O
{O P
lobbyIdP W
}W X
$strX h
{h i
stringi o
.o p
Joinp t
(t u
$stru y
,y z
players	{ Ç
)
Ç É
}
É Ñ
"
Ñ Ö
)
Ö Ü
;
Ü á
if 
( 
_activeGames 
. 
ContainsKey (
(( )
lobbyId) 0
)0 1
)1 2
{ 
CustomLogger 
. 
Warn !
(! "
$"" $
$str$ Y
{Y Z
lobbyIdZ a
}a b
"b c
)c d
;d e
return 
OperationResponse (
.( )
Failure) 0
(0 1
$str1 V
)V W
;W X
} 
var 
gameSession 
= 
new !
GameSession" -
(- .
). /
;/ 0
foreach 
( 
var 
player 
in  "
players# *
)* +
{ 
try 
{   
gameSession!! 
.!!  
	AddPlayer!!  )
(!!) *
player!!* 0
)!!0 1
;!!1 2
CustomLogger""  
.""  !
Info""! %
(""% &
$"""& (
$str""( J
{""J K
player""K Q
}""Q R
$str""R _
{""_ `
lobbyId""` g
}""g h
"""h i
)""i j
;""j k
}$$ 
catch%% 
(%% 
	Exception%%  
ex%%! #
)%%# $
{&& 
return'' 
OperationResponse'' ,
.'', -
Failure''- 4
(''4 5
$"''5 7
$str''7 K
{''K L
player''L R
}''R S
$str''S U
{''U V
ex''V X
.''X Y
Message''Y `
}''` a
"''a b
)''b c
;''c d
}(( 
})) 
_activeGames++ 
[++ 
lobbyId++  
]++  !
=++" #
gameSession++$ /
;++/ 0"
PrintGameSessionsState,, "
(,," #
),,# $
;,,$ %
return.. 
OperationResponse.. $
...$ %
SuccessResult..% 2
(..2 3
)..3 4
;..4 5
}// 	
public11 
OperationResponse11  
SubmitInitialMatrix11! 4
(114 5
string115 ;
lobbyId11< C
,11C D
string11E K
player11L R
,11R S
GameBoardDTO11T `
board11a f
)11f g
{22 	
CustomLogger33 
.33 
Info33 
(33 
$"33  
$str33  ]
{33] ^
player33^ d
}33d e
$str33e r
{33r s
lobbyId33s z
}33z {
"33{ |
)33| }
;33} ~
if44 
(44 
!44 
_activeGames44 
.44 
TryGetValue44 )
(44) *
lobbyId44* 1
,441 2
out443 6
var447 :
gameSession44; F
)44F G
)44G H
{55 
CustomLogger66 
.66 
Warn66 !
(66! "
$"66" $
$str66$ e
{66e f
lobbyId66f m
}66m n
"66n o
)66o p
;66p q
return77 
OperationResponse77 (
.77( )
Failure77) 0
(770 1
$str771 J
)77J K
;77K L
}88 
try:: 
{;; 
gameSession<< 
.<< 
	SetMatrix<< %
(<<% &
player<<& ,
,<<, -
board<<. 3
)<<3 4
;<<4 5
CustomLogger== 
.== 
Info== !
(==! "
$"==" $
$str==$ V
{==V W
player==W ]
}==] ^
$str==^ m
{==m n
lobbyId==n u
}==u v
"==v w
)==w x
;==x y
}?? 
catch@@ 
(@@ 
	Exception@@ 
ex@@ 
)@@  
{AA 
CustomLoggerBB 
.BB 
ErrorBB "
(BB" #
$"BB# %
$strBB% b
{BBb c
playerBBc i
}BBi j
$strBBj w
{BBw x
lobbyIdBBx 
}	BB Ä
"
BBÄ Å
,
BBÅ Ç
ex
BBÉ Ö
)
BBÖ Ü
;
BBÜ á
returnCC 
OperationResponseCC (
.CC( )
FailureCC) 0
(CC0 1
$"CC1 3
$strCC3 S
{CCS T
playerCCT Z
}CCZ [
$strCC[ ]
{CC] ^
exCC^ `
.CC` a
MessageCCa h
}CCh i
"CCi j
)CCj k
;CCk l
}DD "
PrintGameSessionsStateFF "
(FF" #
)FF# $
;FF$ %
returnII 
OperationResponseII $
.II$ %
SuccessResultII% 2
(II2 3
)II3 4
;II4 5
}JJ 	
publicLL 
OperationResponseLL  
	StartGameLL! *
(LL* +
stringLL+ 1
lobbyIdLL2 9
)LL9 :
{MM 	
ifNN 
(NN 
!NN 
_activeGamesNN 
.NN 
TryGetValueNN )
(NN) *
lobbyIdNN* 1
,NN1 2
outNN3 6
varNN7 :
gameSessionNN; F
)NNF G
)NNG H
{OO 
returnPP 
OperationResponsePP (
.PP( )
FailurePP) 0
(PP0 1
$strPP1 J
)PPJ K
;PPK L
}QQ 
ifSS 
(SS 
!SS 
gameSessionSS 
.SS 
AreAllBoardsSetSS ,
(SS, -
)SS- .
)SS. /
{TT 
returnUU 
OperationResponseUU (
.UU( )
FailureUU) 0
(UU0 1
$strUU1 _
)UU_ `
;UU` a
}VV 
returnXX 
OperationResponseXX $
.XX$ %
SuccessResultXX% 2
(XX2 3
)XX3 4
;XX4 5
}YY 	
private[[ 
void[[ "
PrintGameSessionsState[[ +
([[+ ,
)[[, -
{\\ 	
Console]] 
.]] 
	WriteLine]] 
(]] 
$str]] E
)]]E F
;]]F G
if__ 
(__ 
_activeGames__ 
.__ 
IsEmpty__ $
)__$ %
{`` 
Consoleaa 
.aa 
	WriteLineaa !
(aa! "
$straa" <
)aa< =
;aa= >
returnbb 
;bb 
}cc 
foreachee 
(ee 
varee 
lobbyee 
inee !
_activeGamesee" .
)ee. /
{ff 
Consolegg 
.gg 
	WriteLinegg !
(gg! "
$"gg" $
$strgg$ -
{gg- .
lobbygg. 3
.gg3 4
Keygg4 7
}gg7 8
"gg8 9
)gg9 :
;gg: ;
varhh 
gameSessionhh 
=hh  !
lobbyhh" '
.hh' (
Valuehh( -
;hh- .
foreachjj 
(jj 
varjj 
playerjj #
injj$ &
gameSessionjj' 2
.jj2 3

GetPlayersjj3 =
(jj= >
)jj> ?
)jj? @
{kk 
varll 
hasBoardll  
=ll! "
gameSessionll# .
.ll. /
GetPlayerBoardll/ =
(ll= >
playerll> D
)llD E
!=llF H
nullllI M
?llN O
$strllP T
:llU V
$strllW [
;ll[ \
Consolemm 
.mm 
	WriteLinemm %
(mm% &
$"mm& (
$strmm( 3
{mm3 4
playermm4 :
}mm: ;
$strmm; P
{mmP Q
hasBoardmmQ Y
}mmY Z
"mmZ [
)mm[ \
;mm\ ]
}nn 
}oo 
Consoleqq 
.qq 
	WriteLineqq 
(qq 
$strqq E
)qqE F
;qqF G
}rr 	
}tt 
}uu §∫
jC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\FriendshipService.cs
	namespace 	
Service
 
. 

Implements 
{ 
public 

class 
FriendshipService "
:# $
IFriendshipService% 7
{ 
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
private 
readonly $
IFriendRequestRepository 1$
_friendRequestRepository2 J
;J K
private 
readonly '
ValidationFriendshipService 4
_validationService5 G
;G H
private 
readonly 
IProfileRepository +
_profileRepository, >
;> ?
public 
FriendshipService  
(  !
IPlayerRepository! 2
playerRepository3 C
,C D$
IFriendRequestRepositoryE ]#
friendRequestRepository^ u
,u v(
ValidationFriendshipService	w í
validationService
ì §
,
§ • 
IProfileRepository
¶ ∏
profileRepository
π  
)
  À
{ 	
_playerRepository 
= 
playerRepository  0
;0 1$
_friendRequestRepository $
=% &#
friendRequestRepository' >
;> ?
_validationService 
=  
validationService! 2
;2 3
_profileRepository 
=  
profileRepository! 2
;2 3
} 	
public!! 
OperationResponse!!  
AcceptFriendRequest!!! 4
(!!4 5
int!!5 8
	idRequest!!9 B
)!!B C
{"" 	
try## 
{$$ $
_friendRequestRepository%% (
.%%( )
AcceptRequest%%) 6
(%%6 7
	idRequest%%7 @
)%%@ A
;%%A B$
_friendRequestRepository&& (
.&&( )
Save&&) -
(&&- .
)&&. /
;&&/ 0
return(( 
OperationResponse(( (
.((( )
SuccessResult(() 6
(((6 7
)((7 8
;((8 9
})) 
catch** 
(** 
	Exception** 
ex** 
)**  
{++ 
CustomLogger,, 
.,, 
Error,, "
(,," #
$str,,# %
,,,% &
ex,,' )
),,) *
;,,* +
return-- 
OperationResponse-- (
.--( )
Failure--) 0
(--0 1
ErrorMessages--1 >
.--> ?
GeneralException--? O
)--O P
;--P Q
}.. 
}// 	
public11 
FriendListResponse11 !
GetFriendList11" /
(11/ 0
string110 6
username117 ?
)11? @
{22 	
try33 
{44 
var55 
player55 
=55 
_playerRepository55 .
.55. /
GetByUsername55/ <
(55< =
username55= E
)55E F
;55F G
if66 
(66 
player66 
==66 
null66 "
)66" #
{77 
return88 
FriendListResponse88 -
.88- .
Failure88. 5
(885 6
$str886 D
)88D E
;88E F
}99 
var;; 
friends;; 
=;; $
_friendRequestRepository;; 6
.;;6 7
GetAcceptedFriends;;7 I
(;;I J
player;;J P
.;;P Q
PlayerID;;Q Y
);;Y Z
;;;Z [
if== 
(== 
friends== 
==== 
null== #
||==$ &
!==' (
friends==( /
.==/ 0
Any==0 3
(==3 4
)==4 5
)==5 6
{>> 
return?? 
FriendListResponse?? -
.??- .
SuccessResult??. ;
(??; <
new??< ?
List??@ D
<??D E
	PlayerDTO??E N
>??N O
(??O P
)??P Q
)??Q R
;??R S
}@@ 
varBB 

friendDTOsBB 
=BB  
friendsBB! (
.BB( )
SelectBB) /
(BB/ 0
friendBB0 6
=>BB7 9
newBB: =
	PlayerDTOBB> G
{CC 
PlayerIDDD 
=DD 
friendDD %
.DD% &
PlayerIDDD& .
,DD. /
UsernameEE 
=EE 
friendEE %
.EE% &
UsernameEE& .
,EE. /
EmailFF 
=FF 
friendFF "
.FF" #
EmailFF# (
}GG 
)GG 
.GG 
ToListGG 
(GG 
)GG 
;GG 
returnII 
FriendListResponseII )
.II) *
SuccessResultII* 7
(II7 8

friendDTOsII8 B
)IIB C
;IIC D
}JJ 
catchKK 
(KK 
	ExceptionKK 
exKK 
)KK  
{LL 
CustomLoggerMM 
.MM 
ErrorMM "
(MM" #
$"MM# %
$strMM% b
{MMb c
usernameMMc k
}MMk l
$strMMl o
{MMo p
exMMp r
.MMr s
MessageMMs z
}MMz {
"MM{ |
,MM| }
ex	MM~ Ä
)
MMÄ Å
;
MMÅ Ç
returnNN 
FriendListResponseNN )
.NN) *
FailureNN* 1
(NN1 2
ErrorMessagesNN2 ?
.NN? @
GeneralExceptionNN@ P
)NNP Q
;NNQ R
}OO 
}PP 	
publicTT $
FriendRequestListReponseTT ' 
GetFriendRequestListTT( <
(TT< =
stringTT= C
usernameTTD L
)TTL M
{UU 	
tryVV 
{WW 
varXX 
playerXX 
=XX 
_playerRepositoryXX .
.XX. /
GetByUsernameXX/ <
(XX< =
usernameXX= E
)XXE F
;XXF G
ifYY 
(YY 
playerYY 
==YY 
nullYY "
)YY" #
{ZZ 
return[[ $
FriendRequestListReponse[[ 3
.[[3 4
Failure[[4 ;
([[; <
$str[[< M
)[[M N
;[[N O
}\\ 
var^^ 
requests^^ 
=^^ $
_friendRequestRepository^^ 7
.^^7 8
GetReceivedRequests^^8 K
(^^K L
player^^L R
.^^R S
PlayerID^^S [
)^^[ \
;^^\ ]
var`` 
requestDTOs`` 
=``  !
requests``" *
.``* +
Select``+ 1
(``1 2
request``2 9
=>``: <
new``= @
FriendRequestDTO``A Q
{aa 
	RequestIDbb 
=bb 
requestbb  '
.bb' (
	RequestIDbb( 1
,bb1 2
SenderUsernamecc "
=cc# $
requestcc% ,
.cc, -
Playercc- 3
.cc3 4
Usernamecc4 <
,cc< =
ReceiverUsernamedd $
=dd% &
requestdd' .
.dd. /
Player1dd/ 6
.dd6 7
Usernamedd7 ?
,dd? @
Statusee 
=ee 
requestee $
.ee$ %
RequestStatusee% 2
.ee2 3
ToStringee3 ;
(ee; <
)ee< =
}ff 
)ff 
.ff 
ToListff 
(ff 
)ff 
;ff 
returnhh $
FriendRequestListReponsehh /
.hh/ 0
SuccessResulthh0 =
(hh= >
requestDTOshh> I
)hhI J
;hhJ K
}ii 
catchjj 
(jj 
	Exceptionjj 
exjj 
)jj  
{kk 
CustomLoggerll 
.ll 
Errorll "
(ll" #
$strll# %
,ll% &
exll' )
)ll) *
;ll* +
returnmm $
FriendRequestListReponsemm /
.mm/ 0
Failuremm0 7
(mm7 8
ErrorMessagesmm8 E
.mmE F
GeneralExceptionmmF V
)mmV W
;mmW X
}nn 
}oo 	
publicqq 
OperationResponseqq   
RejectFriendResponseqq! 5
(qq5 6
intqq6 9

idResponseqq: D
)qqD E
{rr 	
tryss 
{tt $
_friendRequestRepositoryuu (
.uu( )
RejectRequestuu) 6
(uu6 7

idResponseuu7 A
)uuA B
;uuB C$
_friendRequestRepositoryvv (
.vv( )
Savevv) -
(vv- .
)vv. /
;vv/ 0
returnxx 
OperationResponsexx (
.xx( )
SuccessResultxx) 6
(xx6 7
)xx7 8
;xx8 9
}yy 
catchzz 
(zz 
	Exceptionzz 
exzz 
)zz  
{{{ 
CustomLogger|| 
.|| 
Error|| "
(||" #
$str||# %
,||% &
ex||' )
)||) *
;||* +
return}} 
OperationResponse}} (
.}}( )
Failure}}) 0
(}}0 1
ErrorMessages}}1 >
.}}> ?
GeneralException}}? O
)}}O P
;}}P Q
}~~ 
} 	
public
ÅÅ 
OperationResponse
ÅÅ  
SendFriendRequest
ÅÅ! 2
(
ÅÅ2 3
string
ÅÅ3 9
senderUsername
ÅÅ: H
,
ÅÅH I
string
ÅÅJ P
receiverUsername
ÅÅQ a
)
ÅÅa b
{
ÇÇ 	
var
ÉÉ 
senderValidation
ÉÉ  
=
ÉÉ! " 
_validationService
ÉÉ# 5
.
ÉÉ5 6 
ValidateUserExists
ÉÉ6 H
(
ÉÉH I
senderUsername
ÉÉI W
)
ÉÉW X
;
ÉÉX Y
if
ÑÑ 
(
ÑÑ 
!
ÑÑ 
senderValidation
ÑÑ !
.
ÑÑ! "
	IsSuccess
ÑÑ" +
)
ÑÑ+ ,
{
ÑÑ- .
return
ÖÖ 
senderValidation
ÖÖ '
;
ÖÖ' (
}
ÜÜ 
var
àà  
receiverValidation
àà "
=
àà# $ 
_validationService
àà% 7
.
àà7 8 
ValidateUserExists
àà8 J
(
ààJ K
receiverUsername
ààK [
)
àà[ \
;
àà\ ]
if
ââ 
(
ââ 
!
ââ  
receiverValidation
ââ #
.
ââ# $
	IsSuccess
ââ$ -
)
ââ- .
{
ââ/ 0
return
ää  
receiverValidation
ää )
;
ää) *
}
ãã 
var
çç 
sender
çç 
=
çç 
_playerRepository
çç *
.
çç* +
GetByUsername
çç+ 8
(
çç8 9
senderUsername
çç9 G
)
ççG H
;
ççH I
var
éé 
receiver
éé 
=
éé 
_playerRepository
éé ,
.
éé, -
GetByUsername
éé- :
(
éé: ;
receiverUsername
éé; K
)
ééK L
;
ééL M
var
èè 
requestValidation
èè !
=
èè" # 
_validationService
èè$ 6
.
èè6 7/
!ValidateFriendRequestDoesNotExist
èè7 X
(
èèX Y
sender
èèY _
.
èè_ `
PlayerID
èè` h
,
èèh i
receiver
èèj r
.
èèr s
PlayerID
èès {
)
èè{ |
;
èè| }
if
êê 
(
êê 
!
êê 
requestValidation
êê "
.
êê" #
	IsSuccess
êê# ,
)
êê, -
{
ëë 
return
íí 
requestValidation
íí (
;
íí( )
}
ìì 
try
îî 
{
ïï &
_friendRequestRepository
ññ (
.
ññ( )
SendFriendRequest
ññ) :
(
ññ: ;
sender
ññ; A
.
ññA B
PlayerID
ññB J
,
ññJ K
receiver
ññL T
.
ññT U
PlayerID
ññU ]
)
ññ] ^
;
ññ^ _&
_friendRequestRepository
óó (
.
óó( )
Save
óó) -
(
óó- .
)
óó. /
;
óó/ 0
return
òò 
OperationResponse
òò (
.
òò( )
SuccessResult
òò) 6
(
òò6 7
)
òò7 8
;
òò8 9
}
ôô 
catch
öö 
(
öö 
	Exception
öö 
ex
öö 
)
öö  
{
õõ 
CustomLogger
úú 
.
úú 
Error
úú "
(
úú" #
$str
úú# C
,
úúC D
ex
úúE G
)
úúG H
;
úúH I
return
ùù 
OperationResponse
ùù (
.
ùù( )
Failure
ùù) 0
(
ùù0 1
ErrorMessages
ùù1 >
.
ùù> ?
GeneralException
ùù? O
)
ùùO P
;
ùùP Q
}
ûû 
}
üü 	
public
°° #
PlayerProfileResponse
°° $&
GetPlayersListByUsername
°°% =
(
°°= >
string
°°> D
playerUsername
°°E S
,
°°S T
string
°°U [
ownerUsername
°°\ i
)
°°i j
{
¢¢ 	
try
££ 
{
§§ 
var
•• 
player
•• 
=
•• 
_playerRepository
•• .
.
••. /
GetByUsername
••/ <
(
••< =
ownerUsername
••= J
)
••J K
;
••K L
if
¶¶ 
(
¶¶ 
player
¶¶ 
==
¶¶ 
null
¶¶ "
)
¶¶" #
{
ßß 
return
®® #
PlayerProfileResponse
®® 0
.
®®0 1
Failure
®®1 8
(
®®8 9
$str
®®9 H
)
®®H I
;
®®I J
}
©© 
var
´´ 
players
´´ 
=
´´ 
_playerRepository
´´ /
.
´´/ 0"
GetPlayersByUsername
´´0 D
(
´´D E
playerUsername
´´E S
,
´´S T
player
´´U [
.
´´[ \
PlayerID
´´\ d
)
´´d e
;
´´e f
if
≠≠ 
(
≠≠ 
players
≠≠ 
==
≠≠ 
null
≠≠ #
||
≠≠$ &
!
≠≠' (
players
≠≠( /
.
≠≠/ 0
Any
≠≠0 3
(
≠≠3 4
)
≠≠4 5
)
≠≠5 6
{
ÆÆ 
return
ØØ #
PlayerProfileResponse
ØØ 0
.
ØØ0 1
SuccessResult
ØØ1 >
(
ØØ> ?
new
ØØ? B
List
ØØC G
<
ØØG H
PlayerProfileDTO
ØØH X
>
ØØX Y
(
ØØY Z
)
ØØZ [
,
ØØ[ \
new
ØØ] `
List
ØØa e
<
ØØe f
	PlayerDTO
ØØf o
>
ØØo p
(
ØØp q
)
ØØq r
)
ØØr s
;
ØØs t
}
∞∞ 
var
≤≤ 

playerDtos
≤≤ 
=
≤≤  
new
≤≤! $
List
≤≤% )
<
≤≤) *
	PlayerDTO
≤≤* 3
>
≤≤3 4
(
≤≤4 5
)
≤≤5 6
;
≤≤6 7
var
≥≥ 
profileDtos
≥≥ 
=
≥≥  !
new
≥≥" %
List
≥≥& *
<
≥≥* +
PlayerProfileDTO
≥≥+ ;
>
≥≥; <
(
≥≥< =
)
≥≥= >
;
≥≥> ?
foreach
µµ 
(
µµ 
var
µµ 
friend
µµ #
in
µµ$ &
players
µµ' .
)
µµ. /
{
∂∂ 
var
∑∑ 
	playerDto
∑∑ !
=
∑∑" #
new
∑∑$ '
	PlayerDTO
∑∑( 1
{
∏∏ 
PlayerID
ππ  
=
ππ! "
friend
ππ# )
.
ππ) *
PlayerID
ππ* 2
,
ππ2 3
Username
∫∫  
=
∫∫! "
friend
∫∫# )
.
∫∫) *
Username
∫∫* 2
,
∫∫2 3
Email
ªª 
=
ªª 
friend
ªª  &
.
ªª& '
Email
ªª' ,
}
ºº 
;
ºº 

playerDtos
ΩΩ 
.
ΩΩ 
Add
ΩΩ "
(
ΩΩ" #
	playerDto
ΩΩ# ,
)
ΩΩ, -
;
ΩΩ- .
var
øø 
profile
øø 
=
øø  ! 
_profileRepository
øø" 4
.
øø4 5"
GetProfileByPlayerId
øø5 I
(
øøI J
friend
øøJ P
.
øøP Q
PlayerID
øøQ Y
)
øøY Z
;
øøZ [
if
¿¿ 
(
¿¿ 
profile
¿¿ 
!=
¿¿  "
null
¿¿# '
)
¿¿' (
{
¡¡ 
byte
¬¬ 
[
¬¬ 
]
¬¬ 

imageBytes
¬¬ )
=
¬¬* +$
ConvertImageUrlToBytes
¬¬, B
(
¬¬B C
profile
¬¬C J
.
¬¬J K
	AvatarURL
¬¬K T
)
¬¬T U
??
¬¬V X
Array
¬¬Y ^
.
¬¬^ _
Empty
¬¬_ d
<
¬¬d e
byte
¬¬e i
>
¬¬i j
(
¬¬j k
)
¬¬k l
;
¬¬l m
var
ƒƒ 

profileDto
ƒƒ &
=
ƒƒ' (
new
ƒƒ) ,
PlayerProfileDTO
ƒƒ- =
{
≈≈ 
FullName
∆∆ $
=
∆∆% &
profile
∆∆' .
.
∆∆. /
FullName
∆∆/ 7
??
∆∆8 :
$str
∆∆; F
,
∆∆F G
Bio
«« 
=
««  !
profile
««" )
.
««) *
Bio
««* -
??
««. 0
$str
««1 C
,
««C D
JoinDate
»» $
=
»»% &
profile
»»' .
.
»». /
JoinDate
»»/ 7
??
»»8 :
DateTime
»»; C
.
»»C D
MinValue
»»D L
,
»»L M

SingUpDate
…… &
=
……' (
profile
……) 0
.
……0 1

SignUpDate
……1 ;
??
……< >
DateTime
……? G
.
……G H
MinValue
……H P
,
……P Q
	LastVisit
   %
=
  & '
profile
  ( /
.
  / 0
	LastVisit
  0 9
??
  : <
DateTime
  = E
.
  E F
MinValue
  F N
,
  N O
ProfileImage
ÀÀ (
=
ÀÀ) *

imageBytes
ÀÀ+ 5
}
ÃÃ 
;
ÃÃ 
profileDtos
ŒŒ #
.
ŒŒ# $
Add
ŒŒ$ '
(
ŒŒ' (

profileDto
ŒŒ( 2
)
ŒŒ2 3
;
ŒŒ3 4
}
œœ 
}
–– 
return
—— #
PlayerProfileResponse
—— ,
.
——, -
SuccessResult
——- :
(
——: ;
profileDtos
——; F
,
——F G

playerDtos
——H R
)
——R S
;
——S T
}
““ 
catch
”” 
(
”” 
	Exception
”” 
ex
”” 
)
””  
{
‘‘ 
CustomLogger
’’ 
.
’’ 
Error
’’ "
(
’’" #
$"
’’# %
$str
’’% i
{
’’i j
ownerUsername
’’j w
}
’’w x
$str
’’x {
{
’’{ |
ex
’’| ~
.
’’~ 
Message’’ Ü
}’’Ü á
"’’á à
,’’à â
ex’’ä å
)’’å ç
;’’ç é
return
÷÷ #
PlayerProfileResponse
÷÷ ,
.
÷÷, -
Failure
÷÷- 4
(
÷÷4 5
ErrorMessages
÷÷5 B
.
÷÷B C
GeneralException
÷÷C S
)
÷÷S T
;
÷÷T U
}
◊◊ 
}
ÿÿ 	
public
€€  
FriendListResponse
€€ !
GetPlayersList
€€" 0
(
€€0 1
string
€€1 7
username
€€8 @
)
€€@ A
{
‹‹ 	
try
›› 
{
ﬁﬁ 
var
ﬂﬂ 
player
ﬂﬂ 
=
ﬂﬂ 
_playerRepository
ﬂﬂ .
.
ﬂﬂ. /
GetByUsername
ﬂﬂ/ <
(
ﬂﬂ< =
username
ﬂﬂ= E
)
ﬂﬂE F
;
ﬂﬂF G
if
‡‡ 
(
‡‡ 
player
‡‡ 
==
‡‡ 
null
‡‡ "
)
‡‡" #
{
·· 
return
‚‚  
FriendListResponse
‚‚ -
.
‚‚- .
Failure
‚‚. 5
(
‚‚5 6
$str
‚‚6 D
)
‚‚D E
;
‚‚E F
}
„„ 
var
ÂÂ 
players
ÂÂ 
=
ÂÂ 
_playerRepository
ÂÂ /
.
ÂÂ/ 0

GetPlayers
ÂÂ0 :
(
ÂÂ: ;
username
ÂÂ; C
)
ÂÂC D
;
ÂÂD E
if
ÁÁ 
(
ÁÁ 
players
ÁÁ 
==
ÁÁ 
null
ÁÁ #
||
ÁÁ$ &
!
ÁÁ' (
players
ÁÁ( /
.
ÁÁ/ 0
Any
ÁÁ0 3
(
ÁÁ3 4
)
ÁÁ4 5
)
ÁÁ5 6
{
ËË 
return
ÈÈ  
FriendListResponse
ÈÈ -
.
ÈÈ- .
SuccessResult
ÈÈ. ;
(
ÈÈ; <
new
ÈÈ< ?
List
ÈÈ@ D
<
ÈÈD E
	PlayerDTO
ÈÈE N
>
ÈÈN O
(
ÈÈO P
)
ÈÈP Q
)
ÈÈQ R
;
ÈÈR S
}
ÍÍ 
var
ÏÏ 

playerDtos
ÏÏ 
=
ÏÏ  
players
ÏÏ! (
.
ÏÏ( )
Select
ÏÏ) /
(
ÏÏ/ 0
friend
ÏÏ0 6
=>
ÏÏ7 9
new
ÏÏ: =
	PlayerDTO
ÏÏ> G
{
ÌÌ 
PlayerID
ÓÓ 
=
ÓÓ 
friend
ÓÓ %
.
ÓÓ% &
PlayerID
ÓÓ& .
,
ÓÓ. /
Username
ÔÔ 
=
ÔÔ 
friend
ÔÔ %
.
ÔÔ% &
Username
ÔÔ& .
,
ÔÔ. /
Email
 
=
 
friend
 "
.
" #
Email
# (
}
ÒÒ 
)
ÒÒ 
.
ÒÒ 
ToList
ÒÒ 
(
ÒÒ 
)
ÒÒ 
;
ÒÒ 
return
ÛÛ  
FriendListResponse
ÛÛ )
.
ÛÛ) *
SuccessResult
ÛÛ* 7
(
ÛÛ7 8

playerDtos
ÛÛ8 B
)
ÛÛB C
;
ÛÛC D
}
ÙÙ 
catch
ıı 
(
ıı 
	Exception
ıı 
ex
ıı 
)
ıı  
{
ˆˆ 
CustomLogger
˜˜ 
.
˜˜ 
Error
˜˜ "
(
˜˜" #
$"
˜˜# %
$str
˜˜% b
{
˜˜b c
username
˜˜c k
}
˜˜k l
$str
˜˜l o
{
˜˜o p
ex
˜˜p r
.
˜˜r s
Message
˜˜s z
}
˜˜z {
"
˜˜{ |
,
˜˜| }
ex˜˜~ Ä
)˜˜Ä Å
;˜˜Å Ç
return
¯¯  
FriendListResponse
¯¯ )
.
¯¯) *
Failure
¯¯* 1
(
¯¯1 2
ErrorMessages
¯¯2 ?
.
¯¯? @
GeneralException
¯¯@ P
)
¯¯P Q
;
¯¯Q R
}
˘˘ 
}
˙˙ 	
public
¸¸ 
byte
¸¸ 
[
¸¸ 
]
¸¸ $
ConvertImageUrlToBytes
¸¸ ,
(
¸¸, -
string
¸¸- 3
imageUrl
¸¸4 <
)
¸¸< =
{
˝˝ 	
try
˛˛ 
{
ˇˇ 
string
ÄÄ 
filePath
ÄÄ 
=
ÄÄ  !
Path
ÄÄ" &
.
ÄÄ& '
Combine
ÄÄ' .
(
ÄÄ. /
	AppDomain
ÄÄ/ 8
.
ÄÄ8 9
CurrentDomain
ÄÄ9 F
.
ÄÄF G
BaseDirectory
ÄÄG T
,
ÄÄT U
imageUrl
ÄÄV ^
)
ÄÄ^ _
;
ÄÄ_ `
if
ÅÅ 
(
ÅÅ 
File
ÅÅ 
.
ÅÅ 
Exists
ÅÅ 
(
ÅÅ  
filePath
ÅÅ  (
)
ÅÅ( )
)
ÅÅ) *
{
ÇÇ 
return
ÉÉ 
File
ÉÉ 
.
ÉÉ  
ReadAllBytes
ÉÉ  ,
(
ÉÉ, -
filePath
ÉÉ- 5
)
ÉÉ5 6
;
ÉÉ6 7
}
ÑÑ 
else
ÖÖ 
{
ÜÜ 
throw
áá 
new
áá #
FileNotFoundException
áá 3
(
áá3 4
$str
áá4 K
)
ááK L
;
ááL M
}
àà 
}
ââ 
catch
ää 
(
ää 
	Exception
ää 
ex
ää 
)
ää  
{
ãã 
CustomLogger
åå 
.
åå 
Error
åå "
(
åå" #
$str
åå# D
,
ååD E
ex
ååF H
)
ååH I
;
ååI J
throw
çç 
new
çç 
	Exception
çç #
(
çç# $
$str
çç$ =
)
çç= >
;
çç> ?
}
éé 
}
èè 	
}
êê 
}ëë ’%
dC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\ChatService.cs
	namespace 	
Service
 
. 

Implements 
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?
Single? E
)E F
]F G
public 

class 
ChatService 
: 
IChatService +
{ 
private 
readonly 

Dictionary #
<# $
string$ *
,* + 
IChatServiceCallback, @
>@ A
_connectedUsersB Q
=R S
newT W

DictionaryX b
<b c
stringc i
,i j 
IChatServiceCallbackk 
>	 Ä
(
Ä Å
)
Å Ç
;
Ç É
public 
void 
RegisterUser  
(  !
string! '
username( 0
)0 1
{ 	
var 
callback 
= 
OperationContext +
.+ ,
Current, 3
.3 4
GetCallbackChannel4 F
<F G 
IChatServiceCallbackG [
>[ \
(\ ]
)] ^
;^ _
if 
( 
! 
_connectedUsers  
.  !
ContainsKey! ,
(, -
username- 5
)5 6
)6 7
{ 
_connectedUsers 
.  
Add  #
(# $
username$ ,
,, -
callback. 6
)6 7
;7 8
SendMessage 
( 
$str $
,$ %
$"& (
{( )
username) 1
}1 2
$str2 G
"G H
)H I
;I J
IContextChannel 
contextChannel  .
=/ 0
(1 2
IContextChannel2 A
)A B
callbackB J
;J K
contextChannel 
. 
Closed %
+=& (
() *
sender* 0
,0 1
args2 6
)6 7
=>8 :
DisconnectUser; I
(I J
usernameJ R
)R S
;S T
contextChannel 
. 
Faulted &
+=' )
(* +
sender+ 1
,1 2
args3 7
)7 8
=>9 ;
DisconnectUser< J
(J K
usernameK S
)S T
;T U
} 
}   	
public"" 
void"" 
DisconnectUser"" "
(""" #
string""# )
username""* 2
)""2 3
{## 	
if$$ 
($$ 
_connectedUsers$$ 
.$$  
ContainsKey$$  +
($$+ ,
username$$, 4
)$$4 5
)$$5 6
{%% 
_connectedUsers&& 
.&&  
Remove&&  &
(&&& '
username&&' /
)&&/ 0
;&&0 1
SendMessage(( 
((( 
$str(( $
,(($ %
$"((& (
{((( )
username(() 1
}((1 2
$str((2 E
"((E F
)((F G
;((G H
})) 
}** 	
public,, 
void,, 
SendMessage,, 
(,,  
string,,  &
username,,' /
,,,/ 0
string,,1 7
message,,8 ?
),,? @
{-- 	
string.. 
fullMessage.. 
=..  
$"..! #
{..# $
username..$ ,
}.., -
$str..- /
{../ 0
message..0 7
}..7 8
"..8 9
;..9 :
foreach00 
(00 
var00 
userCallback00 %
in00& (
_connectedUsers00) 8
)008 9
{11 
try33 
{44 
if55 
(55 
userCallback55 $
.55$ %
Key55% (
!=55) +
username55, 4
)554 5
{66 
userCallback99 $
.99$ %
Value99% *
.99* +
ReceiveMessage99+ 9
(999 :
fullMessage99: E
)99E F
;99F G
}:: 
};; 
catch<< 
(<< 
	Exception<< $
ex<<% '
)<<' (
{== 
Console>> 
.>>  
	WriteLine>>  )
(>>) *
$">>* ,
$str>>, E
{>>E F
username>>F N
}>>N O
$str>>O Q
{>>Q R
ex>>R T
.>>T U
Message>>U \
}>>\ ]
">>] ^
)>>^ _
;>>_ `
}?? 
}BB 
}CC 	
}DD 
}EE ¥
iC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\ChatLobbyService.cs
	namespace

 	
Service


 
.

 

Implements

 
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
,I J
ConcurrencyModeK Z
=[ \
ConcurrencyMode] l
.l m
Multiplem u
)u v
]v w
public 

class 
ChatLobbyService !
:" #
IChatLobbyService$ 5
{ 
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
string5 ;
,; < 
ConcurrentDictionary= Q
<Q R
stringR X
,X Y
IChatLobbyCallbackZ l
>l m
>m n
_lobbyUserso z
= 
new  
ConcurrentDictionary %
<% &
string& ,
,, - 
ConcurrentDictionary. B
<B C
stringC I
,I J
IChatLobbyCallbackK ]
>] ^
>^ _
(_ `
)` a
;a b
public 
void 
RegisterUser  
(  !
string! '
username( 0
,0 1
string2 8
lobbyId9 @
)@ A
{ 	
var 
callback 
= 
OperationContext +
.+ ,
Current, 3
.3 4
GetCallbackChannel4 F
<F G
IChatLobbyCallbackG Y
>Y Z
(Z [
)[ \
;\ ]
if 
( 
! 
_lobbyUsers 
. 
ContainsKey (
(( )
lobbyId) 0
)0 1
)1 2
{ 
_lobbyUsers 
[ 
lobbyId #
]# $
=% &
new' * 
ConcurrentDictionary+ ?
<? @
string@ F
,F G
IChatLobbyCallbackH Z
>Z [
([ \
)\ ]
;] ^
} 
_lobbyUsers 
[ 
lobbyId 
]  
[  !
username! )
]) *
=+ ,
callback- 5
;5 6
} 	
public 
void 
SendMessage 
(  
string  &
lobbyId' .
,. /
string0 6
username7 ?
,? @
stringA G
messageH O
)O P
{ 	
if   
(   
!   
_lobbyUsers   
.   
TryGetValue   (
(  ( )
lobbyId  ) 0
,  0 1
out  2 5
var  6 9
usersInLobby  : F
)  F G
)  G H
return!! 
;!! 
foreach## 
(## 
var## 
userCallback## %
in##& (
usersInLobby##) 5
.##5 6
Values##6 <
)##< =
{$$ 
try%% 
{&& 
userCallback''  
.''  !
ReceiveMessage''! /
(''/ 0
username''0 8
,''8 9
message'': A
)''A B
;''B C
}(( 
catch)) 
()) 
	Exception))  
ex))! #
)))# $
{** 
Console++ 
.++ 
	WriteLine++ %
(++% &
$"++& (
$str++( A
{++A B
username++B J
}++J K
$str++K M
{++M N
ex++N P
.++P Q
Message++Q X
}++X Y
"++Y Z
)++Z [
;++[ \
},, 
}-- 
}.. 	
}// 
}00 ·B
jC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\ChatFriendService.cs
	namespace 	
Service
 
. 

Implements 
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
)I J
]J K
public 

class 
ChatFriendService "
:# $
IChatFriendService% 7
{ 
private 
readonly #
IChatMessagesRepository 0#
_chatMessagesRepository1 H
;H I
private 
readonly $
IFriendRequestRepository 1$
_friendRequestRepository2 J
;J K
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
private 
readonly 
ConnectionManager *
_connectionManager+ =
;= >
public 
ChatFriendService  
(  !#
IChatMessagesRepository! 8"
chatMessagesRepository9 O
,O P$
IFriendRequestRepository! 9#
friendRequestRepository: Q
,Q R
IPlayerRepository! 2
playerRepository3 C
,C D
ConnectionManager! 2
connectionManager3 D
)D E
{ 	#
_chatMessagesRepository #
=$ %"
chatMessagesRepository& <
;< =$
_friendRequestRepository $
=% &#
friendRequestRepository' >
;> ?
_playerRepository 
= 
playerRepository  0
;0 1
_connectionManager 
=  
connectionManager! 2
;2 3
} 	
public!! 
OperationResponse!!  
SendMessageToFriend!!! 4
(!!4 5
string!!5 ;
senderUsername!!< J
,!!J K
string!!L R
receiverUsername!!S c
,!!c d
string!!e k
message!!l s
)!!s t
{"" 	
var## 
sender## 
=## 
_playerRepository## *
.##* +
GetByUsername##+ 8
(##8 9
senderUsername##9 G
)##G H
;##H I
var$$ 
receiver$$ 
=$$ 
_playerRepository$$ ,
.$$, -
GetByUsername$$- :
($$: ;
receiverUsername$$; K
)$$K L
;$$L M
if&& 
(&& 
sender&& 
==&& 
null&& 
||&& !
receiver&&" *
==&&+ -
null&&. 2
)&&2 3
{'' 
return(( 
OperationResponse(( (
.((( )
Failure(() 0
(((0 1
$str((1 P
)((P Q
;((Q R
})) 
if++ 
(++ 
!++ $
_friendRequestRepository++ )
.++) *

AreFriends++* 4
(++4 5
sender++5 ;
.++; <
PlayerID++< D
,++D E
receiver++F N
.++N O
PlayerID++O W
)++W X
)++X Y
{,, 
return-- 
OperationResponse-- (
.--( )
Failure--) 0
(--0 1
$str--1 I
)--I J
;--J K
}.. 
try00 
{11 #
_chatMessagesRepository22 '
.22' (

AddMessage22( 2
(222 3
sender223 9
.229 :
PlayerID22: B
,22B C
receiver22D L
.22L M
PlayerID22M U
,22U V
message22W ^
)22^ _
;22_ `
var44 

messageDto44 
=44  
new44! $
MessageFriendDTO44% 5
{55 
SenderUsername66 "
=66# $
senderUsername66% 3
,663 4
Message77 
=77 
message77 %
,77% &
	Timestamp88 
=88 
DateTime88  (
.88( )
Now88) ,
}99 
;99 
if;; 
(;; 
_connectionManager;; &
.;;& '
IsUserRegistered;;' 7
(;;7 8
receiverUsername;;8 H
);;H I
&&;;J L
_connectionManager<< &
.<<& '
GetActiveUsers<<' 5
(<<5 6
)<<6 7
.<<7 8
TryGetValue<<8 C
(<<C D
receiverUsername<<D T
,<<T U
out<<V Y
var<<Z ]
receiverChannel<<^ m
)<<m n
)<<n o
{== 
var>> 
receiverCallback>> (
=>>) *
receiverChannel>>+ :
.>>: ;
GetProperty>>; F
<>>F G
IChatFriendCallback>>G Z
>>>Z [
(>>[ \
)>>\ ]
;>>] ^
receiverCallback?? $
???$ %
.??% &
ReceiveMessage??& 4
(??4 5

messageDto??5 ?
)??? @
;??@ A
}@@ 
returnBB 
OperationResponseBB (
.BB( )
SuccessResultBB) 6
(BB6 7
)BB7 8
;BB8 9
}CC 
catchDD 
(DD 
	ExceptionDD 
exDD 
)DD  
{EE 
ConsoleFF 
.FF 
	WriteLineFF !
(FF! "
$"FF" $
$strFF$ =
{FF= >
receiverUsernameFF> N
}FFN O
$strFFO Q
{FFQ R
exFFR T
.FFT U
MessageFFU \
}FF\ ]
"FF] ^
)FF^ _
;FF_ `
returnGG 
OperationResponseGG (
.GG( )
FailureGG) 0
(GG0 1
$strGG1 I
)GGI J
;GGJ K
}HH 
}II 	
publicKK 
ChatFriendResponseKK !
GetChatHistoryKK" 0
(KK0 1
stringKK1 7
	username1KK8 A
,KKA B
stringKKC I
	username2KKJ S
)KKS T
{LL 	
varMM 
player1MM 
=MM 
_playerRepositoryMM +
.MM+ ,
GetByUsernameMM, 9
(MM9 :
	username1MM: C
)MMC D
;MMD E
varNN 
player2NN 
=NN 
_playerRepositoryNN +
.NN+ ,
GetByUsernameNN, 9
(NN9 :
	username2NN: C
)NNC D
;NND E
ifPP 
(PP 
player1PP 
==PP 
nullPP 
||PP  "
player2PP# *
==PP+ -
nullPP. 2
)PP2 3
{QQ 
returnRR 
ChatFriendResponseRR )
.RR) *
FailureRR* 1
(RR1 2
$strRR2 P
)RRP Q
;RRQ R
}SS 
tryUU 
{VV 
varWW 
messagesWW 
=WW #
_chatMessagesRepositoryWW 6
.WW6 7%
GetMessagesBetweenPlayersWW7 P
(WWP Q
player1WWQ X
.WWX Y
PlayerIDWWY a
,WWa b
player2WWc j
.WWj k
PlayerIDWWk s
)WWs t
;WWt u
varYY 
messageListYY 
=YY  !
messagesYY" *
.YY* +
SelectYY+ 1
(YY1 2
mYY2 3
=>YY4 6
newYY7 :
MessageFriendDTOYY; K
{ZZ 
SenderUsername[[ "
=[[# $
m[[% &
.[[& '
Player[[' -
.[[- .
Username[[. 6
,[[6 7
Message\\ 
=\\ 
m\\ 
.\\  
MessageText\\  +
,\\+ ,
	Timestamp]] 
=]] 
(]]  !
DateTime]]! )
)]]) *
m]]* +
.]]+ ,
	Timestamp]], 5
}^^ 
)^^ 
.^^ 
ToList^^ 
(^^ 
)^^ 
;^^ 
return`` 
ChatFriendResponse`` )
.``) *
SuccessResult``* 7
(``7 8
messageList``8 C
)``C D
;``D E
}aa 
catchbb 
(bb 
	Exceptionbb 
exbb 
)bb  
{cc 
Consoledd 
.dd 
	WriteLinedd !
(dd! "
$"dd" $
$strdd$ C
{ddC D
exddD F
.ddF G
MessageddG N
}ddN O
"ddO P
)ddP Q
;ddQ R
returnee 
ChatFriendResponseee )
.ee) *
Failureee* 1
(ee1 2
$stree2 R
)eeR S
;eeS T
}ff 
}gg 	
}hh 
}ii ≈e
gC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\AccountService.cs
	namespace 	
Service
 
. 

Implements 
{ 
public 

class 
AccountService 
:  !
IAccountService" 1
{ 
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
private 
readonly 
IProfileRepository +
_profileRepository, >
;> ?
private 
readonly #
IPlayerScoresRepository 0
_scoreRepository1 A
;A B
private 
readonly 
ConnectionManager *
_connectionManager+ =
;= >
private 
readonly "
ConnectionEventHandler /#
_connectionEventHandler0 G
;G H
public 
AccountService 
( 
IPlayerRepository 
playerRepository .
,. /
IProfileRepository 
profileRepository 0
,0 1#
IPlayerScoresRepository #
scoreRepository$ 3
,3 4
ConnectionManager 
connectionManager /
,/ 0"
ConnectionEventHandler ""
connectionEventHandler# 9
)9 :
{ 	
_playerRepository   
=   
playerRepository    0
;  0 1
_profileRepository!! 
=!!  
profileRepository!!! 2
;!!2 3
_scoreRepository"" 
="" 
scoreRepository"" .
;"". /
_connectionManager## 
=##  
connectionManager##! 2
;##2 3#
_connectionEventHandler$$ #
=$$$ %"
connectionEventHandler$$& <
;$$< =
}%% 	
public'' 
OperationResponse''  
Register''! )
('') *
	PlayerDTO''* 3
player''4 :
)'': ;
{(( 	
if++ 
(++ 
string++ 
.++ 
IsNullOrWhiteSpace++ )
(++) *
player++* 0
.++0 1
Username++1 9
)++9 :
)++: ;
{,, 
return-- 
OperationResponse-- (
.--( )
Failure--) 0
(--0 1
ErrorMessages--1 >
.--> ?
InvalidUsername--? N
)--N O
;--O P
}.. 
if11 
(11 
string11 
.11 
IsNullOrWhiteSpace11 )
(11) *
player11* 0
.110 1
Email111 6
)116 7
)117 8
{22 
return33 
OperationResponse33 (
.33( )
Failure33) 0
(330 1
ErrorMessages331 >
.33> ?
InvalidEmail33? K
)33K L
;33L M
}44 
if77 
(77 
string77 
.77 
IsNullOrWhiteSpace77 )
(77) *
player77* 0
.770 1
Password771 9
)779 :
)77: ;
{88 
return99 
OperationResponse99 (
.99( )
Failure99) 0
(990 1
ErrorMessages991 >
.99> ?
InvalidPassword99? N
)99N O
;99O P
}:: 
try;; 
{<< 
if== 
(== 
_playerRepository== %
.==% &
GetByUsername==& 3
(==3 4
player==4 :
.==: ;
Username==; C
)==C D
!===E G
null==H L
)==L M
{>> 
return?? 
OperationResponse?? ,
.??, -
Failure??- 4
(??4 5
ErrorMessages??5 B
.??B C
DuplicateUsername??C T
)??T U
;??U V
}@@ 
ifBB 
(BB 
_playerRepositoryBB %
.BB% &

GetByEmailBB& 0
(BB0 1
playerBB1 7
.BB7 8
EmailBB8 =
)BB= >
!=BB? A
nullBBB F
)BBF G
{CC 
returnDD 
OperationResponseDD ,
.DD, -
FailureDD- 4
(DD4 5
ErrorMessagesDD5 B
.DDB C
DuplicateEmailDDC Q
)DDQ R
;DDR S
}EE 
stringGG 
passwordHashGG #
=GG$ %
PasswordHelperGG& 4
.GG4 5
HashPasswordGG5 A
(GGA B
playerGGB H
.GGH I
PasswordGGI Q
)GGQ R
;GGR S
varII 
playerEntityII  
=II! "
EntityFactoryII# 0
.II0 1
CreatePlayerEntityII1 C
(IIC D
playerIID J
,IIJ K
passwordHashIIL X
)IIX Y
;IIY Z
varJJ 
profileEntityJJ !
=JJ" #
EntityFactoryJJ$ 1
.JJ1 2
CreateProfileEntityJJ2 E
(JJE F
playerEntityJJF R
.JJR S
PlayerIDJJS [
)JJ[ \
;JJ\ ]
varKK 
playerScoresEntityKK &
=KK' (
EntityFactoryKK) 6
.KK6 7$
CreatePlayerScoresEntityKK7 O
(KKO P
playerEntityKKP \
.KK\ ]
PlayerIDKK] e
)KKe f
;KKf g
_playerRepositoryMM !
.MM! "
AddMM" %
(MM% &
playerEntityMM& 2
)MM2 3
;MM3 4
_profileRepositoryNN "
.NN" #
AddNN# &
(NN& '
profileEntityNN' 4
)NN4 5
;NN5 6
_scoreRepositoryOO  
.OO  !
AddOO! $
(OO$ %
playerScoresEntityOO% 7
)OO7 8
;OO8 9
_playerRepositoryQQ !
.QQ! "
SaveQQ" &
(QQ& '
)QQ' (
;QQ( )
_profileRepositoryRR "
.RR" #
SaveRR# '
(RR' (
)RR( )
;RR) *
_scoreRepositorySS  
.SS  !
SaveSS! %
(SS% &
)SS& '
;SS' (
returnUU 
OperationResponseUU (
.UU( )
SuccessResultUU) 6
(UU6 7
)UU7 8
;UU8 9
}VV 
catchWW 
(WW 
SqlExceptionWW 
exWW  "
)WW" #
{XX 
stringYY 
errorMessageYY #
=YY$ %
SqlErrorHandlerYY& 5
.YY5 6
GetErrorMessageYY6 E
(YYE F
exYYF H
)YYH I
;YYI J
returnZZ 
OperationResponseZZ (
.ZZ( )
FailureZZ) 0
(ZZ0 1
errorMessageZZ1 =
)ZZ= >
;ZZ> ?
}[[ 
catch\\ 
(\\ 
	Exception\\ 
ex\\ 
)\\  
{]] 
CustomLogger^^ 
.^^ 
Fatal^^ "
(^^" #
$str^^# I
,^^I J
ex^^K M
)^^M N
;^^N O
return__ 
OperationResponse__ (
.__( )
Failure__) 0
(__0 1
ErrorMessages__1 >
.__> ?
GeneralException__? O
)__O P
;__P Q
}`` 
}aa 	
publiccc 
OperationResponsecc  
Logincc! &
(cc& '
stringcc' -
usernamecc. 6
,cc6 7
stringcc8 >
passwordcc? G
)ccG H
{dd 	
ifee 
(ee 
stringee 
.ee 
IsNullOrWhiteSpaceee )
(ee) *
usernameee* 2
)ee2 3
)ee3 4
returnff 
OperationResponseff (
.ff( )
Failureff) 0
(ff0 1
ErrorMessagesff1 >
.ff> ?
InvalidUsernameff? N
)ffN O
;ffO P
ifhh 
(hh 
stringhh 
.hh 
IsNullOrWhiteSpacehh )
(hh) *
passwordhh* 2
)hh2 3
)hh3 4
returnii 
OperationResponseii (
.ii( )
Failureii) 0
(ii0 1
ErrorMessagesii1 >
.ii> ?
InvalidPasswordii? N
)iiN O
;iiO P
ifkk 
(kk 
_connectionManagerkk "
.kk" #
IsUserRegisteredkk# 3
(kk3 4
usernamekk4 <
)kk< =
)kk= >
returnll 
OperationResponsell (
.ll( )
Failurell) 0
(ll0 1
ErrorMessagesll1 >
.ll> ? 
UserAlreadyConnectedll? S
)llS T
;llT U
trymm 
{nn 
varoo 
playeroo 
=oo 
_playerRepositoryoo .
.oo. /
GetByUsernameoo/ <
(oo< =
usernameoo= E
)ooE F
;ooF G
ifpp 
(pp 
playerpp 
==pp 
nullpp "
)pp" #
returnqq 
OperationResponseqq ,
.qq, -
Failureqq- 4
(qq4 5
ErrorMessagesqq5 B
.qqB C
UserNotFoundqqC O
)qqO P
;qqP Q
boolss 
isPasswordValidss $
=ss% &
PasswordHelperss' 5
.ss5 6
VerifyPasswordss6 D
(ssD E
passwordssE M
,ssM N
playerssO U
.ssU V
PasswordHashssV b
)ssb c
;ssc d
iftt 
(tt 
!tt 
isPasswordValidtt $
)tt$ %
returnuu 
OperationResponseuu ,
.uu, -
Failureuu- 4
(uu4 5
ErrorMessagesuu5 B
.uuB C
InvalidPassworduuC R
)uuR S
;uuS T
ifww 
(ww 
OperationContextww $
.ww$ %
Currentww% ,
?ww, -
.ww- .
Channelww. 5
isww6 8
IContextChannelww9 H
channelwwI P
)wwP Q
{xx 
boolyy 

registeredyy #
=yy$ %
_connectionManageryy& 8
.yy8 9
RegisterUseryy9 E
(yyE F
usernameyyF N
,yyN O
channelyyP W
)yyW X
;yyX Y
ifzz 
(zz 
!zz 

registeredzz #
)zz# $
return{{ 
OperationResponse{{ 0
.{{0 1
Failure{{1 8
({{8 9
ErrorMessages{{9 F
.{{F G 
UserAlreadyConnected{{G [
){{[ \
;{{\ ]#
_connectionEventHandler}} +
.}}+ ,!
RegisterChannelEvents}}, A
(}}A B
username}}B J
,}}J K
channel}}L S
)}}S T
;}}T U
}~~ 
return
ÄÄ 
OperationResponse
ÄÄ (
.
ÄÄ( )
SuccessResult
ÄÄ) 6
(
ÄÄ6 7
)
ÄÄ7 8
;
ÄÄ8 9
}
ÅÅ 
catch
ÇÇ 
(
ÇÇ 
SqlException
ÇÇ 
ex
ÇÇ  "
)
ÇÇ" #
{
ÉÉ 
CustomLogger
ÑÑ 
.
ÑÑ 
Error
ÑÑ "
(
ÑÑ" #
$str
ÑÑ# ;
,
ÑÑ; <
ex
ÑÑ= ?
)
ÑÑ? @
;
ÑÑ@ A
string
ÖÖ 
errorMessage
ÖÖ #
=
ÖÖ$ %
SqlErrorHandler
ÖÖ& 5
.
ÖÖ5 6
GetErrorMessage
ÖÖ6 E
(
ÖÖE F
ex
ÖÖF H
)
ÖÖH I
;
ÖÖI J
return
ÜÜ 
OperationResponse
ÜÜ (
.
ÜÜ( )
Failure
ÜÜ) 0
(
ÜÜ0 1
errorMessage
ÜÜ1 =
)
ÜÜ= >
;
ÜÜ> ?
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
ââ 
CustomLogger
ää 
.
ää 
Error
ää "
(
ää" #
$str
ää# B
,
ääB C
ex
ääD F
)
ääF G
;
ääG H
return
ãã 
OperationResponse
ãã (
.
ãã( )
Failure
ãã) 0
(
ãã0 1
ErrorMessages
ãã1 >
.
ãã> ?
GeneralException
ãã? O
)
ããO P
;
ããP Q
}
åå 
}
çç 	
public
èè 
OperationResponse
èè  
Logout
èè! '
(
èè' (
string
èè( .
username
èè/ 7
)
èè7 8
{
êê 	
if
ëë 
(
ëë  
_connectionManager
ëë "
.
ëë" #
IsUserRegistered
ëë# 3
(
ëë3 4
username
ëë4 <
)
ëë< =
)
ëë= >
{
íí  
_connectionManager
ìì "
.
ìì" #
UnregisterUser
ìì# 1
(
ìì1 2
username
ìì2 :
)
ìì: ;
;
ìì; <
return
îî 
OperationResponse
îî (
.
îî( )
SuccessResult
îî) 6
(
îî6 7
)
îî7 8
;
îî8 9
}
ïï 
else
ññ 
{
óó 
return
òò 
OperationResponse
òò (
.
òò( )
Failure
òò) 0
(
òò0 1
ErrorMessages
òò1 >
.
òò> ?
UserNotConnected
òò? O
)
òòO P
;
òòP Q
}
ôô 
}
öö 	
}
õõ 
}úú °
fC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Factories\IEntityFactory.cs
	namespace 	
Service
 
. 
	Factories 
{ 
public 

	interface 
IEntityFactory #
{ 
Player 
CreatePlayerEntity !
(! "
	PlayerDTO" +
	playerDto, 5
,5 6
string7 =
passwordHash> J
)J K
;K L
Profile		 
CreateProfileEntity		 #
(		# $
int		$ '
playerId		( 0
)		0 1
;		1 2

UserScores

 $
CreatePlayerScoresEntity

 +
(

+ ,
int

, /
playerId

0 8
)

8 9
;

9 :
FriendRequest 
CreateFriendRequest )
() *
int* -
senderId. 6
,6 7
int8 ;

receiverId< F
)F G
;G H
ChatMessages 
CreateChatMessage &
(& '
int' *
senderId+ 3
,3 4
int5 8

receiverId9 C
,C D
stringE K
messageTextL W
)W X
;X Y
	GameLobby 
CreateGameLobby !
(! "
string" (
	lobbyName) 2
,2 3
int4 7
hostId8 >
,> ?
string@ F
passwordG O
=P Q
nullR V
)V W
;W X
GuestPlayers 
CreateGuestPlayer &
(& '
string' -
username. 6
,6 7
int8 ;
statusId< D
)D E
;E F!
PasswordResetRequests &
CreatePasswordResetRequest 8
(8 9
int9 <
playerId= E
,E F
stringG M
	resetCodeN W
)W X
;X Y
} 
} ê,
eC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Factories\EntityFactory.cs
	namespace 	
Service
 
. 
	Factories 
{ 
public 

static 
class 
EntityFactory %
{		 
public

 
static

 
Player

 
CreatePlayerEntity

 /
(

/ 0
	PlayerDTO

0 9
	playerDto

: C
,

C D
string

E K
passwordHash

L X
)

X Y
{ 	
return 
new 
Player 
{ 
Username 
= 
	playerDto $
.$ %
Username% -
,- .
Email 
= 
	playerDto !
.! "
Email" '
,' (
PasswordHash 
= 
passwordHash +
} 
; 
} 	
public 
static 
Profile 
CreateProfileEntity 1
(1 2
int2 5
playerId6 >
)> ?
{ 	
return 
new 
Profile 
{ 
PlayerID 
= 
playerId #
,# $
FullName 
= 
$str )
,) *
	AvatarURL 
= 
$str 0
,0 1
Bio 
= 
$str #
,# $
JoinDate 
= 
DateTime #
.# $
Now$ '
,' (

SignUpDate 
= 
DateTime %
.% &
Now& )
,) *
	LastVisit 
= 
DateTime $
.$ %
Now% (
} 
; 
}   	
public"" 
static"" 

UserScores""  $
CreatePlayerScoresEntity""! 9
(""9 :
int"": =
playerId""> F
)""F G
{## 	
return$$ 
new$$ 

UserScores$$ !
{%% 
PlayerID&& 
=&& 
playerId&& #
,&&# $
Wins'' 
='' 
$num'' 
,'' 
Losses(( 
=(( 
$num(( 
})) 
;)) 
}** 	
public,, 
static,, 
FriendRequest,, #
CreateFriendRequest,,$ 7
(,,7 8
int,,8 ;
senderId,,< D
,,,D E
int,,F I

receiverId,,J T
),,T U
{-- 	
return.. 
new.. 
FriendRequest.. $
{// 
SenderPlayerID00 
=00  
senderId00! )
,00) *
ReceiverPlayerID11  
=11! "

receiverId11# -
,11- .
RequestStatus22 
=22 
$str22  )
}33 
;33 
}44 	
public66 
static66 
ChatMessages66 "
CreateChatMessage66# 4
(664 5
int665 8
senderId669 A
,66A B
int66C F

receiverId66G Q
,66Q R
string66S Y
messageText66Z e
)66e f
{77 	
return88 
new88 
ChatMessages88 #
{99 
SenderID:: 
=:: 
senderId:: #
,::# $

ReceiverID;; 
=;; 

receiverId;; '
,;;' (
MessageText<< 
=<< 
messageText<< )
,<<) *
	Timestamp== 
=== 
DateTime== $
.==$ %
Now==% (
}>> 
;>> 
}?? 	
publicAA 
staticAA 
	GameLobbyAA 
CreateGameLobbyAA  /
(AA/ 0
stringAA0 6
	lobbyNameAA7 @
,AA@ A
intAAB E
hostIdAAF L
,AAL M
stringAAN T
passwordAAU ]
=AA^ _
nullAA` d
)AAd e
{BB 	
returnCC 
newCC 
	GameLobbyCC  
{DD 
	LobbyNameEE 
=EE 
	lobbyNameEE %
,EE% &
HostIDFF 
=FF 
hostIdFF 
,FF  
PasswordGG 
=GG 
passwordGG #
}HH 
;HH 
}II 	
publicKK 
staticKK 
GuestPlayersKK "
CreateGuestPlayerKK# 4
(KK4 5
stringKK5 ;
usernameKK< D
,KKD E
intKKF I
statusIdKKJ R
)KKR S
{LL 	
returnMM 
newMM 
GuestPlayersMM #
{NN 
UsernameOO 
=OO 
usernameOO #
,OO# $
JoinDatePP 
=PP 
DateTimePP #
.PP# $
NowPP$ '
}QQ 
;QQ 
}RR 	
publicTT 
staticTT !
PasswordResetRequestsTT +&
CreatePasswordResetRequestTT, F
(TTF G
intTTG J
playerIdTTK S
,TTS T
stringTTU [
	resetCodeTT\ e
)TTe f
{UU 	
returnVV 
newVV !
PasswordResetRequestsVV ,
{WW 
PlayerIDXX 
=XX 
playerIdXX #
,XX# $
	ResetCodeYY 
=YY 
	resetCodeYY %
,YY% &
ExpirationDateZZ 
=ZZ  
DateTimeZZ! )
.ZZ) *
NowZZ* -
.ZZ- .
AddHoursZZ. 6
(ZZ6 7
$numZZ7 8
)ZZ8 9
,ZZ9 :
IsUsed[[ 
=[[ 
false[[ 
}\\ 
;\\ 
}]] 	
}^^ 
}__ ê
\C:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Entities\Lobby.cs
	namespace 	
Service
 
. 
Entities 
{ 
public		 

class		 
Lobby		 
{

 
public 
string 
LobbyId 
{ 
get  #
;# $
private% ,
set- 0
;0 1
}2 3
=4 5
Guid6 :
.: ;
NewGuid; B
(B C
)C D
.D E
ToStringE M
(M N
)N O
;O P
public 
string 
Name 
{ 
get  
;  !
set" %
;% &
}' (
public 
bool 
	IsPrivate 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
List 
< 
string 
> 
Players #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
new4 7
List8 <
<< =
string= C
>C D
(D E
)E F
;F G
public 
int 

MaxPlayers 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$num. /
;/ 0
public 
string 
Host 
{ 
get  
;  !
set" %
;% &
}' (
public 
bool 
CanJoin 
( 
string "
username# +
,+ ,
string- 3
password4 <
== >
null? C
)C D
{ 	
if 
( 
Players 
. 
Count 
>=  

MaxPlayers! +
)+ ,
return- 3
false4 9
;9 :
if 
( 
	IsPrivate 
&& 
Password %
!=& (
password) 1
)1 2
return3 9
false: ?
;? @
return 
! 
Players 
. 
Contains $
($ %
username% -
)- .
;. /
} 	
public 
void 
	AddPlayer 
( 
string $
username% -
)- .
{ 	
if 
( 
Players 
. 
Count 
< 

MaxPlayers  *
)* +
{ 
Players 
. 
Add 
( 
username $
)$ %
;% &
}   
}!! 	
public## 
void## 
RemovePlayer##  
(##  !
string##! '
username##( 0
)##0 1
{$$ 	
Players%% 
.%% 
Remove%% 
(%% 
username%% #
)%%# $
;%%$ %
}&& 	
public(( 
bool(( 
IsEmpty(( 
((( 
)(( 
{)) 	
return** 
Players** 
.** 
Count**  
==**! #
$num**$ %
;**% &
}++ 	
},, 
}-- µ
bC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Entities\GameSession.cs
	namespace 	
Service
 
. 
Entities 
{ 
public 

class 
GameSession 
{ 
private		 
readonly		 

Dictionary		 #
<		# $
string		$ *
,		* +
GameBoardDTO		, 8
>		8 9
_playerBoards		: G
=		H I
new		J M

Dictionary		N X
<		X Y
string		Y _
,		_ `
GameBoardDTO		a m
>		m n
(		n o
)		o p
;		p q
public 
void 
	AddPlayer 
( 
string $
player% +
)+ ,
{ 	
if 
( 
_playerBoards 
. 
ContainsKey )
() *
player* 0
)0 1
)1 2
throw 
new %
InvalidOperationException 3
(3 4
$"4 6
$str6 =
{= >
player> D
}D E
$strE `
"` a
)a b
;b c
_playerBoards 
[ 
player  
]  !
=" #
null$ (
;( )
} 	
public 
void 
	SetMatrix 
( 
string $
player% +
,+ ,
GameBoardDTO- 9
board: ?
)? @
{ 	
if 
( 
! 
_playerBoards 
. 
ContainsKey *
(* +
player+ 1
)1 2
)2 3
throw 
new %
InvalidOperationException 3
(3 4
$"4 6
$str6 =
{= >
player> D
}D E
$strE b
"b c
)c d
;d e
_playerBoards 
[ 
player  
]  !
=" #
board$ )
;) *
} 	
public 
GameBoardDTO 
GetPlayerBoard *
(* +
string+ 1
player2 8
)8 9
{ 	
if 
( 
! 
_playerBoards 
. 
TryGetValue *
(* +
player+ 1
,1 2
out3 6
var7 :
board; @
)@ A
)A B
throw 
new %
InvalidOperationException 3
(3 4
$"4 6
$str6 =
{= >
player> D
}D E
$strE b
"b c
)c d
;d e
return   
board   
;   
}!! 	
public## 
bool## 
AreAllBoardsSet## #
(### $
)##$ %
{$$ 	
foreach%% 
(%% 
var%% 
board%% 
in%% !
_playerBoards%%" /
.%%/ 0
Values%%0 6
)%%6 7
{&& 
if'' 
('' 
board'' 
=='' 
null'' !
)''! "
return(( 
false((  
;((  !
})) 
return** 
true** 
;** 
}++ 	
public-- 
IEnumerable-- 
<-- 
string-- !
>--! "

GetPlayers--# -
(--- .
)--. /
{.. 	
return// 
_playerBoards//  
.//  !
Keys//! %
;//% &
}00 	
}11 
}22 »
aC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\PlayerScoresDTO.cs
	namespace 	
Service
 
. 
DTO 
{ 
[ 
DataContract 
] 
public		 

class		 
PlayerScoresDTO		  
{

 
[ 	

DataMember	 
] 
public 
int 
PlayerId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
int 
Wins 
{ 
get 
; 
set "
;" #
}$ %
[ 	

DataMember	 
] 
public 
int 
Losses 
{ 
get 
;  
set! $
;$ %
}& '
} 
} Û
bC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\PlayerProfileDTO.cs
	namespace 	
Service
 
. 
DTO 
{		 
[

 
DataContract

 
]

 
public 

class 
PlayerProfileDTO !
{ 
[ 	

DataMember	 
] 
public 
string 
FullName 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
string 
Bio 
{ 
get 
;  
set! $
;$ %
}& '
[ 	

DataMember	 
] 
public 
DateTime 
JoinDate  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 	

DataMember	 
] 
public 
DateTime 

SingUpDate "
{# $
get% (
;( )
set* -
;- .
}/ 0
[ 	

DataMember	 
] 
public 
DateTime 
	LastVisit !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 	

DataMember	 
] 
public 
byte 
[ 
] 
ProfileImage "
{# $
get% (
;( )
set* -
;- .
}/ 0
} 
} ó	
[C:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\PlayerDTO.cs
	namespace 	
Service
 
. 
DTO 
{		 
[

 
DataContract

 
]

 
public 

class 
	PlayerDTO 
{ 
[ 	

DataMember	 
] 
public 
int 
PlayerID 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
} ª	
bC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\MessageFriendDTO.cs
	namespace 	
Service
 
. 
DTO 
{ 
[ 
DataContract 
] 
public 

class 
MessageFriendDTO !
{ 
[		 	

DataMember			 
]		 
public

 
string

 
SenderUsername

 $
{

% &
get

' *
;

* +
set

, /
;

/ 0
}

1 2
[ 	

DataMember	 
] 
public 
string 
ReceiverUsername &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
[ 	

DataMember	 
] 
public 
string 
Message 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
DateTime 
	Timestamp !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} ¯
\C:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\MessageDTO.cs
	namespace 	
Service
 
. 
DTO 
{		 
[

 
DataContract

 
]

 
public 

class 

MessageDTO 
{ 
[ 	

DataMember	 
] 
public 
string 
sender 
{ 
get "
;" #
set$ '
;' (
}) *
[ 	

DataMember	 
] 
public 
string 
message 
{ 
get  #
;# $
set% (
;( )
}* +
} 
} ˛

gC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\CreateLobbyRequestDTO.cs
	namespace 	
Service
 
. 
DTO 
{		 
[

 
DataContract

 
]

 
public 

class !
CreateLobbyRequestDTO &
{ 
[ 	

DataMember	 
] 
public 
string 
Name 
{ 
get  
;  !
set" %
;% &
}' (
[ 	

DataMember	 
] 
public 
bool 
	IsPrivate 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
string 
Host 
{ 
get  
;  !
set" %
;% &
}' (
} 
} ˘
ZC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\LobbyDTO.cs
	namespace 	
Service
 
. 
DTO 
{		 
[

 
DataContract

 
]

 
public 

class 
LobbyDTO 
{ 
[ 	

DataMember	 
] 
public 
string 
LobbyId 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
Name 
{ 
get  
;  !
set" %
;% &
}' (
[ 	

DataMember	 
] 
public 
bool 
	IsPrivate 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
int 
CurrentPlayers !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 	

DataMember	 
] 
public 
int 

MaxPlayers 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
$num. /
;/ 0
[ 	

DataMember	 
] 
public 
string 
Host 
{ 
get  
;  !
set" %
;% &
}' (
[ 	

DataMember	 
] 
public 
List 
< 
string 
> 
Players #
{$ %
get& )
;) *
set+ .
;. /
}0 1
=2 3
new4 7
List8 <
<< =
string= C
>C D
(D E
)E F
;F G
} 
} ﬁ
eC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\JoinLobbyRequestDTO.cs
	namespace 	
Service
 
. 
DTO 
{		 
[

 
DataContract

 
]

 
public 

class 
JoinLobbyRequestDTO $
{ 
[ 	

DataMember	 
] 
public 
string 
LobbyId 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
string 
Password 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
} ∞
^C:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\GameBoardDTO.cs
	namespace 	
Service
 
. 
DTO 
{		 
[

 
DataContract

 
]

 
public 

class 
GameBoardDTO 
{ 
[ 	

DataMember	 
] 
public 
int 
Rows 
{ 
get 
; 
private &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
int 
Columns 
{ 
get  
;  !
private" )
set* -
;- .
}/ 0
[ 	

DataMember	 
] 
public 
List 
< 
int 
> 
Data 
{ 
get  #
;# $
private% ,
set- 0
;0 1
}2 3
public 
GameBoardDTO 
( 
int 
[  
,  !
]! "
matrix# )
)) *
{ 	
Rows 
= 
matrix 
. 
	GetLength #
(# $
$num$ %
)% &
;& '
Columns 
= 
matrix 
. 
	GetLength &
(& '
$num' (
)( )
;) *
Data 
= 
new 
List 
< 
int 
>  
(  !
)! "
;" #
for 
( 
int 
i 
= 
$num 
; 
i 
< 
Rows  $
;$ %
i& '
++' )
)) *
{ 
for 
( 
int 
j 
= 
$num 
; 
j  !
<" #
Columns$ +
;+ ,
j- .
++. 0
)0 1
{ 
Data   
.   
Add   
(   
matrix   #
[  # $
i  $ %
,  % &
j  ' (
]  ( )
)  ) *
;  * +
}!! 
}"" 
}## 	
public%% 
int%% 
[%% 
,%% 
]%% 
ToMatrix%% 
(%% 
)%%  
{&& 	
int'' 
['' 
,'' 
]'' 
matrix'' 
='' 
new'' 
int''  #
[''# $
Rows''$ (
,''( )
Columns''* 1
]''1 2
;''2 3
for(( 
((( 
int(( 
i(( 
=(( 
$num(( 
;(( 
i(( 
<(( 
Rows((  $
;(($ %
i((& '
++((' )
)(() *
{)) 
for** 
(** 
int** 
j** 
=** 
$num** 
;** 
j**  !
<**" #
Columns**$ +
;**+ ,
j**- .
++**. 0
)**0 1
{++ 
matrix,, 
[,, 
i,, 
,,, 
j,, 
],,  
=,,! "
Data,,# '
[,,' (
i,,( )
*,,* +
Columns,,, 3
+,,4 5
j,,6 7
],,7 8
;,,8 9
}-- 
}.. 
return// 
matrix// 
;// 
}00 	
}11 
}22 µ	
bC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\FriendRequestDTO.cs
	namespace 	
Service
 
. 
DTO 
{		 
[

 
DataContract

 
]

 
public 

class 
FriendRequestDTO !
{ 
[ 	

DataMember	 
] 
public 
int 
	RequestID 
{ 
get "
;" #
set$ '
;' (
}) *
[ 	

DataMember	 
] 
public 
string 
SenderUsername $
{% &
get' *
;* +
set, /
;/ 0
}1 2
[ 	

DataMember	 
] 
public 
string 
ReceiverUsername &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
[ 	

DataMember	 
] 
public 
string 
Status 
{ 
get "
;" #
set$ '
;' (
}) *
} 
} ¶
nC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IUserConnectionManager.cs
	namespace 	
Service
 
. 
	Contracts 
{		 
[

 
ServiceContract

 
]

 
public 

	interface "
IUserConnectionManager +
{ 
[ 	
OperationContract	 
] 
void 
Connect 
( 
string 
username $
)$ %
;% &
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 

Disconnect 
( 
) 
; 
} 
} ï
gC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IProfileService.cs
	namespace 	
Service
 
. 
	Contracts 
{ 
[ 
ServiceContract 
] 
public 

	interface 
IProfileService $
{ 
[ 	
OperationContract	 
] 
OperationResponse 
UpdatePassword (
(( )
string) /
username0 8
,8 9
string: @
newPasswordA L
,L M
stringN T
oldPasswordU `
)` a
;a b
[ 	
OperationContract	 
] 
OperationResponse  
UpdateProfilePicture .
(. /
string/ 5
username6 >
,> ?
byte@ D
[D E
]E F

imageBytesG Q
,Q R
stringS Y
fileNameZ b
)b c
;c d
[ 	
OperationContract	 
] 
OperationResponse 
UpdateUsername (
(( )
string) /
currentUsername0 ?
,? @
stringA G
newUsernameH S
)S T
;T U
[ 	
OperationContract	 
] 
OperationResponse 
	UpdateBio #
(# $
string$ *
bio+ .
,. /
string0 6
username7 ?
)? @
;@ A
[ 	
OperationContract	 
] 
ProfileResponse  
GetProfileByUsername ,
(, -
string- 3
username4 <
)< =
;= >
[ 	
OperationContract	 
] 
ImageResponse 
GetProfileImage %
(% &
string& ,
username- 5
)5 6
;6 7
[ 	
OperationContract	 
] 
string 
GetBioByUsername 
(  
string  &
username' /
)/ 0
;0 1
} 
} Û
lC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IPlayerScoresService.cs
	namespace

 	
Service


 
.

 
	Contracts

 
{ 
[ 
ServiceContract 
] 
public 

	interface  
IPlayerScoresService )
{ 
[ 	
OperationContract	 
]  
PlayerScoresResponse 
GetScoresByUsername 0
(0 1
string1 7
username8 @
)@ A
;A B
[ 	
OperationContract	 
] 
OperationResponse 
IncrementWins '
(' (
string( .
username/ 7
)7 8
;8 9
[ 	
OperationContract	 
] 
OperationResponse 
IncrementLosses )
() *
string* 0
username1 9
)9 :
;: ;
} 
} ≠
eC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\ILobbyService.cs
	namespace 	
Service
 
. 
	Contracts 
{		 
[

 
ServiceContract

 
(

 
CallbackContract

 %
=

& '
typeof

( .
(

. /
ILobbyCallback

/ =
)

= >
)

> ?
]

? @
public 

	interface 
ILobbyService "
{ 
[ 	
OperationContract	 
] 
LobbyResponse 
CreateLobby !
(! "!
CreateLobbyRequestDTO" 7
request8 ?
)? @
;@ A
[ 	
OperationContract	 
] 
LobbyResponse 
	JoinLobby 
(  
JoinLobbyRequestDTO  3
request4 ;
); <
;< =
[ 	
OperationContract	 
] 
List 
< 
LobbyDTO 
> 
GetAllLobbies $
($ %
)% &
;& '
[ 	
OperationContract	 
] 
LobbyResponse 

LeaveLobby  
(  !
string! '
lobbyId( /
,/ 0
string1 7
username8 @
)@ A
;A B
[ 	
OperationContract	 
] 
LobbyResponse 

KickPlayer  
(  !
string! '
lobbyId( /
,/ 0
string1 7
hostUsername8 D
,D E
stringF L
targetUsernameM [
)[ \
;\ ]
[ 	
OperationContract	 
] 
OperationResponse 
	StartGame #
(# $
string$ *
lobbyId+ 2
,2 3
string4 :
hostUsername; G
)G H
;H I
} 
public 

	interface 
ILobbyCallback #
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
NotifyPlayerJoined 
(  
string  &

playerName' 1
,1 2
string3 9
lobbyId: A
)A B
;B C
[   	
OperationContract  	 
(   
IsOneWay   #
=  $ %
true  & *
)  * +
]  + ,
void!! 
NotifyPlayerLeft!! 
(!! 
string!! $

playerName!!% /
,!!/ 0
string!!1 7
lobbyId!!8 ?
)!!? @
;!!@ A
[## 	
OperationContract##	 
(## 
IsOneWay## #
=##$ %
true##& *
)##* +
]##+ ,
void$$ %
NotifyPlayerJoinedMessage$$ &
($$& '
string$$' -
message$$. 5
)$$5 6
;$$6 7
[&& 	
OperationContract&&	 
(&& 
IsOneWay&& #
=&&$ %
true&&& *
)&&* +
]&&+ ,
void'' #
NotifyPlayerLeftMessage'' $
(''$ %
string''% +
message'', 3
)''3 4
;''4 5
[)) 	
OperationContract))	 
()) 
IsOneWay)) #
=))$ %
true))& *
)))* +
]))+ ,
void** !
StartGameNotification** "
(**" #
string**# )
lobbyId*** 1
)**1 2
;**2 3
}++ 
},, õ
dC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IGameService.cs
	namespace

 	
Service


 
.

 
	Contracts

 
{ 
[ 
ServiceContract 
( 
CallbackContract %
=& '
typeof( .
(. /
IGameCallback/ <
)< =
)= >
]> ?
public 

	interface 
IGameService !
{ 
[ 	
OperationContract	 
] 
OperationResponse 
InitializeGame (
(( )
string) /
lobbyId0 7
,7 8
List9 =
<= >
string> D
>D E
playersF M
)M N
;N O
[ 	
OperationContract	 
] 
OperationResponse 
SubmitInitialMatrix -
(- .
string. 4
lobbyId5 <
,< =
string> D
playerE K
,K L
GameBoardDTOM Y
boardZ _
)_ `
;` a
[ 	
OperationContract	 
] 
OperationResponse 
	StartGame #
(# $
string$ *
lobbyId+ 2
)2 3
;3 4
} 
public 

	interface 
IGameCallback "
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
OnGameStarted 
( 
) 
; 
} 
} ª
hC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IGameplayService.cs
	namespace 	
Service
 
. 
	Contracts 
{ 
public		 

	interface		 
IGameplayService		 %
{

 
} 
} ‘
jC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IFriendshipService.cs
	namespace 	
Service
 
. 
	Contracts 
{ 
[ 
ServiceContract 
] 
public 

	interface 
IFriendshipService '
{ 
[ 	
OperationContract	 
] 
OperationResponse 
SendFriendRequest +
(+ ,
string, 2
senderUsername3 A
,A B
stringC I
reciveUsernameJ X
)X Y
;Y Z
[ 	
OperationContract	 
] 
OperationResponse 
AcceptFriendRequest -
(- .
int. 1
	idRequest2 ;
); <
;< =
[ 	
OperationContract	 
] 
OperationResponse  
RejectFriendResponse .
(. /
int/ 2

idResponse3 =
)= >
;> ?
[ 	
OperationContract	 
] 
FriendListResponse 
GetFriendList (
() *
string* 0
username1 9
)9 :
;: ;
[ 	
OperationContract	 
] $
FriendRequestListReponse   
GetFriendRequestList! 5
(5 6
string6 <
username= E
)E F
;F G
[ 	
OperationContract	 
] 
FriendListResponse 
GetPlayersList )
() *
string* 0
username1 9
)9 :
;: ;
[ 	
OperationContract	 
] !
PlayerProfileResponse $
GetPlayersListByUsername 6
(6 7
string7 =
playerUsername> L
,L M
stringN T
loggedUsernameU c
)c d
;d e
} 
} ¡
dC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IChatService.cs
	namespace		 	
Service		
 
.		 
	Contracts		 
{

 
[ 
ServiceContract 
( 
CallbackContract %
=& '
typeof( .
(. / 
IChatServiceCallback/ C
)C D
)D E
]E F
public 

	interface 
IChatService !
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SendMessage 
( 
string 
username  (
,( )
string* 0
message1 8
)8 9
;9 :
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
RegisterUser 
( 
string  
username! )
)) *
;* +
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
DisconnectUser 
( 
string "
username# +
)+ ,
;, -
} 
[ 
ServiceContract 
] 
public 

	interface  
IChatServiceCallback )
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
ReceiveMessage 
( 
string "
message# *
)* +
;+ ,
} 
} …
iC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IChatLobbyService.cs
	namespace 	
Service
 
. 
	Contracts 
{		 
[

 
ServiceContract

 
(

 
CallbackContract

 %
=

& '
typeof

( .
(

. /
IChatLobbyCallback

/ A
)

A B
)

B C
]

C D
public 

	interface 
IChatLobbyService &
{ 
[ 	
OperationContract	 
] 
void 
RegisterUser 
( 
string  
username! )
,) *
string+ 1
lobbyId2 9
)9 :
;: ;
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SendMessage 
( 
string 
lobbyId  '
,' (
string) /
username0 8
,8 9
string: @
messageA H
)H I
;I J
} 
public 

	interface 
IChatLobbyCallback '
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
ReceiveMessage 
( 
string "
username# +
,+ ,
string- 3
message4 ;
); <
;< =
} 
} Ä
jC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IChatFriendService.cs
	namespace 	
Service
 
. 
	Contracts 
{ 
[ 
ServiceContract 
( 
CallbackContract %
=& '
typeof( .
(. /
IChatFriendCallback/ B
)B C
)C D
]D E
public 

	interface 
IChatFriendService '
{ 
[ 	
OperationContract	 
] 
OperationResponse 
SendMessageToFriend -
(- .
string. 4
senderUsername5 C
,C D
stringE K
receiverUsernameL \
,\ ]
string^ d
messagee l
)l m
;m n
[ 	
OperationContract	 
] 
ChatFriendResponse 
GetChatHistory )
() *
string* 0
	username11 :
,: ;
string< B
	username2C L
)L M
;M N
} 
public 

	interface 
IChatFriendCallback (
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
ReceiveMessage 
( 
MessageFriendDTO ,
message- 4
)4 5
;5 6
} 
} Ñ
gC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IAccountService.cs
	namespace 	
Service
 
. 
	Contracts 
{ 
[ 
ServiceContract 
] 
public 

	interface 
IAccountService $
{		 
[

 	
OperationContract

	 
]

 
OperationResponse 
Register "
(" #
	PlayerDTO# ,
player- 3
)3 4
;4 5
[ 	
OperationContract	 
] 
OperationResponse 
Login 
(  
string  &
username' /
,/ 0
string1 7
password8 @
)@ A
;A B
[ 	
OperationContract	 
] 
OperationResponse 
Logout  
(  !
string! '
username( 0
)0 1
;1 2
} 
} ⁄
sC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Connection\Managers\ConnectionManager.cs
	namespace 	
Service
 
. 

Connection 
. 
Managers %
{ 
public 

class 
ConnectionManager "
{ 
private		 
readonly		  
ConcurrentDictionary		 -
<		- .
string		. 4
,		4 5
IContextChannel		6 E
>		E F
_activeUsers		G S
=		T U
new		V Y 
ConcurrentDictionary		Z n
<		n o
string		o u
,		u v
IContextChannel			w Ü
>
		Ü á
(
		á à
)
		à â
;
		â ä
public 
bool 
RegisterUser  
(  !
string! '
username( 0
,0 1
IContextChannel2 A
channelB I
)I J
{ 	
return 
_activeUsers 
.  
TryAdd  &
(& '
username' /
,/ 0
channel1 8
)8 9
;9 :
} 	
public 
bool 
IsUserRegistered $
($ %
string% +
username, 4
)4 5
{ 	
return 
_activeUsers 
.  
ContainsKey  +
(+ ,
username, 4
)4 5
;5 6
} 	
public 
bool 
UnregisterUser "
(" #
string# )
username* 2
)2 3
{ 	
return 
_activeUsers 
.  
	TryRemove  )
() *
username* 2
,2 3
out4 7
_8 9
)9 :
;: ;
} 	
public 
IReadOnlyDictionary "
<" #
string# )
,) *
IContextChannel+ :
>: ;
GetActiveUsers< J
(J K
)K L
=>M O
_activeUsersP \
;\ ]
} 
} Ñ
xC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Connection\Managers\ConnectionEventHandler.cs
	namespace 	
Service
 
. 

Connection 
. 
Managers %
{ 
public 

class "
ConnectionEventHandler '
{ 
private 
readonly 
ConnectionManager *
_connectionManager+ =
;= >
public

 "
ConnectionEventHandler

 %
(

% &
ConnectionManager

& 7
connectionManager

8 I
)

I J
{ 	
_connectionManager 
=  
connectionManager! 2
;2 3
} 	
public 
void !
RegisterChannelEvents )
() *
string* 0
username1 9
,9 :
IContextChannel; J
channelK R
)R S
{ 	
Console 
. 
	WriteLine 
( 
$"  
$str  %
{% &
username& .
}. /
$str/ B
"B C
)C D
;D E
channel 
. 
Closed 
+= 
( 
sender %
,% &
args' +
)+ ,
=>- /
HandleDisconnection0 C
(C D
usernameD L
)L M
;M N
channel 
. 
Faulted 
+= 
(  
sender  &
,& '
args( ,
), -
=>. 0
HandleDisconnection1 D
(D E
usernameE M
)M N
;N O
} 	
private 
void 
HandleDisconnection (
(( )
string) /
username0 8
)8 9
{ 	
_connectionManager 
. 
UnregisterUser -
(- .
username. 6
)6 7
;7 8
Console 
. 
	WriteLine 
( 
$"  
$str  %
{% &
username& .
}. /
$str/ W
"W X
)X Y
;Y Z
} 	
} 
} 