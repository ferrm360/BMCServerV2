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
}## ñ
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
} ø
sC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Results\GuestPlayerResponse.cs
	namespace 	
Service
 
. 
	Utilities 
. 
Results #
{		 
public

 

class

 
GuestPlayerResponse

 $
:

% &
OperationResponse

' 8
{ 
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
static 
GuestPlayerResponse )
Success* 1
(1 2
string2 8
username9 A
)A B
{ 	
return 
new 
GuestPlayerResponse *
{ 
	IsSuccess 
= 
true  
,  !
Username 
= 
username #
} 
; 
} 	
public 
static 
new 
GuestPlayerResponse -
Failure. 5
(5 6
string6 <
errorMessage= I
)I J
{ 	
return 
new 
GuestPlayerResponse *
{ 
	IsSuccess 
= 
false !
,! "
ErrorKey 
= 
errorMessage '
} 
; 
} 	
} 
}   Å
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
}!! ≠
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
static 
new 
ChatFriendResponse ,
Failure- 4
(4 5
string5 ;
errorKey< D
)D E
=>F H
newI L
ChatFriendResponseM _
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
} è
rC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Constans\MessageChatFriend.cs
	namespace 	
Service
 
. 
	Utilities 
. 
Constans $
{ 
public		 

static		 
class		 
MessageChatFriend		 )
{

 
public 
const 
string 
SenderNotFound *
=+ ,
$str- C
;C D
public 
const 
string 
NoAreFriend '
=( )
$str* =
;= >
public 
const 
string 
CantSendMessages ,
=- .
$str/ G
;G H
} 
} Â
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
}$$ ©	
mC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Constans\GameMessages.cs
	namespace 	
Service
 
. 
	Utilities 
. 
Constans $
{ 
public		 

static		 
class		 
GameMessages		 $
{

 
public 
const 
string 
GameNotFound (
=) *
$str+ >
;> ?
public 
const 
string %
PlayerDontSummitGameBoard 5
=6 7
$str8 X
;X Y
public 
const 
string 
CantSummitMatrix ,
=- .
$str/ G
;G H
public 
const 
string 
GameAlredyExist +
=, -
$str. F
;F G
public 
const 
string 
CantAddingPlayer ,
=- .
$str/ G
;G H
public 
const 
string 
PlayerNotReady *
=+ ,
$str- C
;C D
} 
} ó
nC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Utilities\Constans\LobbyMessages.cs
	namespace 	
Service
 
. 
	Utilities 
. 
Constans $
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
 
LobbyMessages

 %
{ 
public 
const 
string 
LobbyNotFound )
=* +
$str, A
;A B
public 
const 
string 
OnlyHostStart )
=* +
$str, @
;@ A
public 
const 
string 
NotEnoughPlayer +
=, -
$str. D
;D E
public 
const 
string 
NotificationMissing /
=0 1
$str2 O
;O P
public 
const 
string 
GameStarted '
=( )
$str* <
;< =
} 
} ·>
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
builder 
. 
RegisterType  
<  !
PlayerRepository! 1
>1 2
(2 3
)3 4
.4 5
As5 7
<7 8
IPlayerRepository8 I
>I J
(J K
)K L
.L M$
InstancePerLifetimeScopeM e
(e f
)f g
;g h
builder 
. 
RegisterType  
<  !
ProfileRepository! 2
>2 3
(3 4
)4 5
.5 6
As6 8
<8 9
IProfileRepository9 K
>K L
(L M
)M N
.N O$
InstancePerLifetimeScopeO g
(g h
)h i
;i j
builder 
. 
RegisterType  
<  !"
PlayerScoresRepository! 7
>7 8
(8 9
)9 :
.: ;
As; =
<= >#
IPlayerScoresRepository> U
>U V
(V W
)W X
.X Y$
InstancePerLifetimeScopeY q
(q r
)r s
;s t
builder 
. 
RegisterType  
<  !#
FriendRequestRepository! 8
>8 9
(9 :
): ;
.; <
As< >
<> ?$
IFriendRequestRepository? W
>W X
(X Y
)Y Z
.Z [$
InstancePerLifetimeScope[ s
(s t
)t u
;u v
builder 
. 
RegisterType  
<  !"
ChatMessagesRepository! 7
>7 8
(8 9
)9 :
.: ;
As; =
<= >#
IChatMessagesRepository> U
>U V
(V W
)W X
.X Y$
InstancePerLifetimeScopeY q
(q r
)r s
;s t
builder 
. 
RegisterType  
<  !"
PlayerScoresRepository! 7
>7 8
(8 9
)9 :
.: ;
As; =
<= >#
IPlayerScoresRepository> U
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
<  !
GuestPlayerService! 3
>3 4
(4 5
)5 6
.6 7
As7 9
<9 :
IGuestPlayerService: M
>M N
(N O
)O P
.P Q$
InstancePerLifetimeScopeQ i
(i j
)j k
;k l
builder   
.   
RegisterType    
<    !
EmailService  ! -
>  - .
(  . /
)  / 0
.  0 1
As  1 3
<  3 4
IEmailService  4 A
>  A B
(  B C
)  C D
.  D E$
InstancePerLifetimeScope  E ]
(  ] ^
)  ^ _
;  _ `
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
}++ ≈
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
} ê
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
]!!) *õ’
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
	namespace 	
Service
 
. 

Implements 
{ 
public 

class 
PlayerScoresService $
:% & 
IPlayerScoresService' ;
{ 
private 
readonly #
IPlayerScoresRepository 0
_scoreRepository1 A
;A B
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
public 
PlayerScoresService "
(" ##
IPlayerScoresRepository #
scoreRepository$ 3
,3 4
IPlayerRepository 
playerRepository .
). /
{ 	
_scoreRepository 
= 
scoreRepository .
;. /
_playerRepository 
= 
playerRepository  0
;0 1
} 	
public  
PlayerScoresResponse #
GetScoresByUsername$ 7
(7 8
string8 >
username? G
)G H
{ 	
try 
{ 
var 
player 
= 
_playerRepository .
.. /
GetByUsername/ <
(< =
username= E
)E F
;F G
if 
( 
player 
== 
null "
)" #
{   
return!!  
PlayerScoresResponse!! /
.!!/ 0
Failure!!0 7
(!!7 8
ErrorMessages!!8 E
.!!E F
UserNotFound!!F R
)!!R S
;!!S T
}"" 
var$$ 
scores$$ 
=$$ 
_scoreRepository$$ -
.$$- .
GetScoresByPlayerId$$. A
($$A B
player$$B H
.$$H I
PlayerID$$I Q
)$$Q R
;$$R S
if%% 
(%% 
scores%% 
==%% 
null%% "
)%%" #
{&& 
return''  
PlayerScoresResponse'' /
.''/ 0
Failure''0 7
(''7 8
ErrorMessages''8 E
.''E F
ScoreNotFound''F S
)''S T
;''T U
}(( 
var** 
	scoresDto** 
=** 
new**  #
PlayerScoresDTO**$ 3
{++ 
PlayerId,, 
=,, 
scores,, %
.,,% &
PlayerID,,& .
,,,. /
Wins-- 
=-- 
scores-- !
.--! "
Wins--" &
,--& '
Losses.. 
=.. 
scores.. #
...# $
Losses..$ *
}// 
;// 
return11  
PlayerScoresResponse11 +
.11+ ,
SuccessResult11, 9
(119 :
	scoresDto11: C
)11C D
;11D E
}22 
catch33 
(33 
SqlException33 
ex33  "
)33" #
{44 
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
PlayerScoresResponse66 +
.66+ ,
Failure66, 3
(663 4
errorMessage664 @
)66@ A
;66A B
}77 
catch88 
(88 
	Exception88 
ex88 
)88  
{99 
Console:: 
.:: 
	WriteLine:: !
(::! "
$"::" $
$str::$ 6
{::6 7
ex::7 9
.::9 :
Message::: A
}::A B
"::B C
)::C D
;::D E
return;;  
PlayerScoresResponse;; +
.;;+ ,
Failure;;, 3
(;;3 4
ErrorMessages;;4 A
.;;A B
GeneralException;;B R
);;R S
;;;S T
}<< 
}== 	
public?? 
OperationResponse??  
IncrementWins??! .
(??. /
string??/ 5
username??6 >
)??> ?
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
}GG 
_scoreRepositoryII  
.II  !
IncrementWinsII! .
(II. /
playerII/ 5
.II5 6
PlayerIDII6 >
)II> ?
;II? @
_scoreRepositoryJJ  
.JJ  !
SaveJJ! %
(JJ% &
)JJ& '
;JJ' (
returnLL 
OperationResponseLL (
.LL( )
SuccessResultLL) 6
(LL6 7
$strLL7 V
)LLV W
;LLW X
}MM 
catchNN 
(NN 
SqlExceptionNN 
exNN  "
)NN" #
{OO 
stringPP 
errorMessagePP #
=PP$ %
SqlErrorHandlerPP& 5
.PP5 6
GetErrorMessagePP6 E
(PPE F
exPPF H
)PPH I
;PPI J
returnQQ 
OperationResponseQQ (
.QQ( )
FailureQQ) 0
(QQ0 1
errorMessageQQ1 =
)QQ= >
;QQ> ?
}RR 
catchSS 
(SS 
	ExceptionSS 
exSS 
)SS  
{TT 
ConsoleUU 
.UU 
	WriteLineUU !
(UU! "
$"UU" $
$strUU$ 6
{UU6 7
exUU7 9
.UU9 :
MessageUU: A
}UUA B
"UUB C
)UUC D
;UUD E
returnVV 
OperationResponseVV (
.VV( )
FailureVV) 0
(VV0 1
ErrorMessagesVV1 >
.VV> ?
GeneralExceptionVV? O
)VVO P
;VVP Q
}WW 
}XX 	
publicZZ 
OperationResponseZZ  
IncrementLossesZZ! 0
(ZZ0 1
stringZZ1 7
usernameZZ8 @
)ZZ@ A
{[[ 	
try\\ 
{]] 
var^^ 
player^^ 
=^^ 
_playerRepository^^ .
.^^. /
GetByUsername^^/ <
(^^< =
username^^= E
)^^E F
;^^F G
if__ 
(__ 
player__ 
==__ 
null__ "
)__" #
{`` 
returnaa 
OperationResponseaa ,
.aa, -
Failureaa- 4
(aa4 5
ErrorMessagesaa5 B
.aaB C
UserNotFoundaaC O
)aaO P
;aaP Q
}bb 
_scoreRepositorydd  
.dd  !
IncrementLossesdd! 0
(dd0 1
playerdd1 7
.dd7 8
PlayerIDdd8 @
)dd@ A
;ddA B
_scoreRepositoryee  
.ee  !
Saveee! %
(ee% &
)ee& '
;ee' (
returngg 
OperationResponsegg (
.gg( )
SuccessResultgg) 6
(gg6 7
$strgg7 W
)ggW X
;ggX Y
}hh 
catchii 
(ii 
SqlExceptionii 
exii  "
)ii" #
{jj 
stringkk 
errorMessagekk #
=kk$ %
SqlErrorHandlerkk& 5
.kk5 6
GetErrorMessagekk6 E
(kkE F
exkkF H
)kkH I
;kkI J
returnll 
OperationResponsell (
.ll( )
Failurell) 0
(ll0 1
errorMessagell1 =
)ll= >
;ll> ?
}mm 
catchnn 
(nn 
	Exceptionnn 
exnn 
)nn  
{oo 
Consolepp 
.pp 
	WriteLinepp !
(pp! "
$"pp" $
$strpp$ 6
{pp6 7
expp7 9
.pp9 :
Messagepp: A
}ppA B
"ppB C
)ppC D
;ppD E
returnqq 
OperationResponseqq (
.qq( )
Failureqq) 0
(qq0 1
ErrorMessagesqq1 >
.qq> ?
GeneralExceptionqq? O
)qqO P
;qqP Q
}rr 
}ss 	
}tt 
}uu Õ◊
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
;''1 2
var)) 
lobbyDto)) 
=)) 
new)) 
LobbyDTO)) '
{** 
LobbyId++ 
=++ 
lobby++ 
.++  
LobbyId++  '
,++' (
Name,, 
=,, 
lobby,, 
.,, 
Name,, !
,,,! "
	IsPrivate-- 
=-- 
lobby-- !
.--! "
	IsPrivate--" +
,--+ ,
CurrentPlayers.. 
=..  
lobby..! &
...& '
Players..' .
.... /
Count../ 4
,..4 5

MaxPlayers// 
=// 
lobby// "
.//" #

MaxPlayers//# -
,//- .
Host00 
=00 
lobby00 
.00 
Host00 !
,00! "
Players11 
=11 
new11 
List11 "
<11" #
string11# )
>11) *
(11* +
lobby11+ 0
.110 1
Players111 8
)118 9
}22 
;22 
return44 
LobbyResponse44  
.44  !
SuccessResult44! .
(44. /
lobbyDto44/ 7
)447 8
;448 9
}55 	
public88 
LobbyResponse88 
	JoinLobby88 &
(88& '
JoinLobbyRequestDTO88' :
request88; B
)88B C
{99 	
if:: 
(:: 
!:: 
_activeLobbies:: 
.::  
TryGetValue::  +
(::+ ,
request::, 3
.::3 4
LobbyId::4 ;
,::; <
out::= @
var::A D
lobby::E J
)::J K
)::K L
{;; 
return<< 
LobbyResponse<< $
.<<$ %
Failure<<% ,
(<<, -
ErrorMessages<<- :
.<<: ;
LobbyNotFound<<; H
)<<H I
;<<I J
}== 
if?? 
(?? 
lobby?? 
.?? 
	IsPrivate?? 
&&??  "
lobby??# (
.??( )
Password??) 1
!=??2 4
request??5 <
.??< =
Password??= E
)??E F
{@@ 
returnAA 
LobbyResponseAA $
.AA$ %
FailureAA% ,
(AA, -
ErrorMessagesAA- :
.AA: ; 
InvalidLobbyPasswordAA; O
)AAO P
;AAP Q
}BB 
ifDD 
(DD 
!DD 
lobbyDD 
.DD 
CanJoinDD 
(DD 
requestDD &
.DD& '
UsernameDD' /
,DD/ 0
requestDD1 8
.DD8 9
PasswordDD9 A
)DDA B
)DDB C
{EE 
returnFF 
LobbyResponseFF $
.FF$ %
FailureFF% ,
(FF, -
ErrorMessagesFF- :
.FF: ;
	LobbyFullFF; D
)FFD E
;FFE F
}GG 
lobbyII 
.II 
	AddPlayerII 
(II 
requestII #
.II# $
UsernameII$ ,
)II, -
;II- .
RegisterCallbackJJ 
(JJ 
requestJJ $
.JJ$ %
UsernameJJ% -
)JJ- .
;JJ. / 
NotifyPlayersInLobbyLL  
(LL  !
lobbyLL! &
,LL& '
requestLL( /
.LL/ 0
UsernameLL0 8
)LL8 9
;LL9 :
varNN 
lobbyDtoNN 
=NN 
newNN 
LobbyDTONN '
{OO 
LobbyIdPP 
=PP 
lobbyPP 
.PP  
LobbyIdPP  '
,PP' (
NameQQ 
=QQ 
lobbyQQ 
.QQ 
NameQQ !
,QQ! "
	IsPrivateRR 
=RR 
lobbyRR !
.RR! "
	IsPrivateRR" +
,RR+ ,
CurrentPlayersSS 
=SS  
lobbySS! &
.SS& '
PlayersSS' .
.SS. /
CountSS/ 4
,SS4 5

MaxPlayersTT 
=TT 
lobbyTT "
.TT" #

MaxPlayersTT# -
,TT- .
HostUU 
=UU 
lobbyUU 
.UU 
HostUU !
,UU! "
PlayersVV 
=VV 
newVV 
ListVV "
<VV" #
stringVV# )
>VV) *
(VV* +
lobbyVV+ 0
.VV0 1
PlayersVV1 8
)VV8 9
}WW 
;WW 
returnYY 
LobbyResponseYY  
.YY  !
SuccessResultYY! .
(YY. /
lobbyDtoYY/ 7
)YY7 8
;YY8 9
}ZZ 	
public\\ 
LobbyResponse\\ 

LeaveLobby\\ '
(\\' (
string\\( .
lobbyId\\/ 6
,\\6 7
string\\8 >
username\\? G
)\\G H
{]] 	
if^^ 
(^^ 
!^^ 
_activeLobbies^^ 
.^^  
TryGetValue^^  +
(^^+ ,
lobbyId^^, 3
,^^3 4
out^^5 8
var^^9 <
lobby^^= B
)^^B C
)^^C D
{__ 
return`` 
LobbyResponse`` $
.``$ %
Failure``% ,
(``, -
ErrorMessages``- :
.``: ;
LobbyNotFound``; H
)``H I
;``I J
}aa 
lobbycc 
.cc 
RemovePlayercc 
(cc 
usernamecc '
)cc' (
;cc( )
_connectedPlayersdd 
.dd 
	TryRemovedd '
(dd' (
usernamedd( 0
,dd0 1
outdd2 5
_dd6 7
)dd7 8
;dd8 9
NotifyPlayerLeftff 
(ff 
lobbyff "
,ff" #
usernameff$ ,
)ff, -
;ff- .
ifhh 
(hh 
lobbyhh 
.hh 
IsEmptyhh 
(hh 
)hh 
)hh  
{ii 
_activeLobbiesjj 
.jj 
Removejj %
(jj% &
lobbyIdjj& -
)jj- .
;jj. /
}kk 
varmm 
lobbyDtomm 
=mm 
newmm 
LobbyDTOmm '
{nn 
LobbyIdoo 
=oo 
lobbyoo 
.oo  
LobbyIdoo  '
,oo' (
Namepp 
=pp 
lobbypp 
.pp 
Namepp !
,pp! "
	IsPrivateqq 
=qq 
lobbyqq !
.qq! "
	IsPrivateqq" +
,qq+ ,
CurrentPlayersrr 
=rr  
lobbyrr! &
.rr& '
Playersrr' .
.rr. /
Countrr/ 4
,rr4 5

MaxPlayersss 
=ss 
lobbyss "
.ss" #

MaxPlayersss# -
,ss- .
Hosttt 
=tt 
lobbytt 
.tt 
Hosttt !
,tt! "
Playersuu 
=uu 
newuu 
Listuu "
<uu" #
stringuu# )
>uu) *
(uu* +
lobbyuu+ 0
.uu0 1
Playersuu1 8
)uu8 9
}vv 
;vv 
returnxx 
LobbyResponsexx  
.xx  !
SuccessResultxx! .
(xx. /
lobbyDtoxx/ 7
)xx7 8
;xx8 9
}yy 	
private{{ 
void{{ 
RegisterCallback{{ %
({{% &
string{{& ,
username{{- 5
){{5 6
{|| 	
var}} 
callback}} 
=}} 
OperationContext}} +
.}}+ ,
Current}}, 3
.}}3 4
GetCallbackChannel}}4 F
<}}F G
ILobbyCallback}}G U
>}}U V
(}}V W
)}}W X
;}}X Y
_connectedPlayers~~ 
.~~ 
TryAdd~~ $
(~~$ %
username~~% -
,~~- .
callback~~/ 7
)~~7 8
;~~8 9
var
ÄÄ 
contextChannel
ÄÄ 
=
ÄÄ  
(
ÄÄ! "
IContextChannel
ÄÄ" 1
)
ÄÄ1 2
callback
ÄÄ2 :
;
ÄÄ: ;
contextChannel
ÅÅ 
.
ÅÅ 
Closed
ÅÅ !
+=
ÅÅ" $
(
ÅÅ% &
sender
ÅÅ& ,
,
ÅÅ, -
args
ÅÅ. 2
)
ÅÅ2 3
=>
ÅÅ4 6$
HandleClientDisconnect
ÅÅ7 M
(
ÅÅM N
username
ÅÅN V
)
ÅÅV W
;
ÅÅW X
contextChannel
ÇÇ 
.
ÇÇ 
Faulted
ÇÇ "
+=
ÇÇ# %
(
ÇÇ& '
sender
ÇÇ' -
,
ÇÇ- .
args
ÇÇ/ 3
)
ÇÇ3 4
=>
ÇÇ5 7$
HandleClientDisconnect
ÇÇ8 N
(
ÇÇN O
username
ÇÇO W
)
ÇÇW X
;
ÇÇX Y
}
ÉÉ 	
private
ÖÖ 
void
ÖÖ $
HandleClientDisconnect
ÖÖ +
(
ÖÖ+ ,
string
ÖÖ, 2
username
ÖÖ3 ;
)
ÖÖ; <
{
ÜÜ 	
if
áá 
(
áá 
_connectedPlayers
áá !
.
áá! "
	TryRemove
áá" +
(
áá+ ,
username
áá, 4
,
áá4 5
out
áá6 9
_
áá: ;
)
áá; <
)
áá< =
{
àà 
var
ââ 
lobby
ââ 
=
ââ 
_activeLobbies
ââ *
.
ââ* +
Values
ââ+ 1
.
ââ1 2
FirstOrDefault
ââ2 @
(
ââ@ A
l
ââA B
=>
ââC E
l
ââF G
.
ââG H
Players
ââH O
.
ââO P
Contains
ââP X
(
ââX Y
username
ââY a
)
ââa b
)
ââb c
;
ââc d
if
ää 
(
ää 
lobby
ää 
!=
ää 
null
ää !
)
ää! "
{
ãã 
lobby
åå 
.
åå 
RemovePlayer
åå &
(
åå& '
username
åå' /
)
åå/ 0
;
åå0 1
NotifyPlayerLeft
çç $
(
çç$ %
lobby
çç% *
,
çç* +
username
çç, 4
)
çç4 5
;
çç5 6
if
èè 
(
èè 
lobby
èè 
.
èè 
IsEmpty
èè %
(
èè% &
)
èè& '
)
èè' (
{
êê 
_activeLobbies
ëë &
.
ëë& '
Remove
ëë' -
(
ëë- .
lobby
ëë. 3
.
ëë3 4
LobbyId
ëë4 ;
)
ëë; <
;
ëë< =
}
íí 
}
ìì 
}
îî 
}
ïï 	
private
óó 
void
óó "
NotifyPlayersInLobby
óó )
(
óó) *
Lobby
óó* /
lobby
óó0 5
,
óó5 6
string
óó7 =
	newPlayer
óó> G
)
óóG H
{
òò 	
string
ôô 
joinMessage
ôô 
=
ôô  
$"
ôô! #
{
ôô# $
	newPlayer
ôô$ -
}
ôô- .
$str
ôô. D
{
ôôD E
lobby
ôôE J
.
ôôJ K
Name
ôôK O
}
ôôO P
$str
ôôP Q
"
ôôQ R
;
ôôR S
Console
öö 
.
öö 
	WriteLine
öö 
(
öö 
joinMessage
öö )
)
öö) *
;
öö* +
foreach
úú 
(
úú 
var
úú 
player
úú 
in
úú  "
lobby
úú# (
.
úú( )
Players
úú) 0
)
úú0 1
{
ùù 
if
ûû 
(
ûû 
player
ûû 
!=
ûû 
	newPlayer
ûû '
&&
ûû( *
_connectedPlayers
ûû+ <
.
ûû< =
TryGetValue
ûû= H
(
ûûH I
player
ûûI O
,
ûûO P
out
ûûQ T
var
ûûU X
callback
ûûY a
)
ûûa b
)
ûûb c
{
üü 
try
†† 
{
°° 
callback
¢¢  
.
¢¢  ! 
NotifyPlayerJoined
¢¢! 3
(
¢¢3 4
	newPlayer
¢¢4 =
,
¢¢= >
lobby
¢¢? D
.
¢¢D E
LobbyId
¢¢E L
)
¢¢L M
;
¢¢M N
callback
££  
.
££  !'
NotifyPlayerJoinedMessage
££! :
(
££: ;
joinMessage
££; F
)
££F G
;
££G H
}
§§ 
catch
•• 
(
•• 
	Exception
•• $
ex
••% '
)
••' (
{
¶¶ 
Console
ßß 
.
ßß  
	WriteLine
ßß  )
(
ßß) *
$"
ßß* ,
$str
ßß, C
{
ßßC D
player
ßßD J
}
ßßJ K
$str
ßßK M
{
ßßM N
ex
ßßN P
.
ßßP Q
Message
ßßQ X
}
ßßX Y
"
ßßY Z
)
ßßZ [
;
ßß[ \$
HandleClientDisconnect
®® .
(
®®. /
player
®®/ 5
)
®®5 6
;
®®6 7
}
©© 
}
™™ 
}
´´ 
}
¨¨ 	
private
ÆÆ 
void
ÆÆ 
NotifyPlayerLeft
ÆÆ %
(
ÆÆ% &
Lobby
ÆÆ& +
lobby
ÆÆ, 1
,
ÆÆ1 2
string
ÆÆ3 9

playerLeft
ÆÆ: D
)
ÆÆD E
{
ØØ 	
string
∞∞ 
leaveMessage
∞∞ 
=
∞∞  !
$"
∞∞" $
{
∞∞$ %

playerLeft
∞∞% /
}
∞∞/ 0
$str
∞∞0 D
{
∞∞D E
lobby
∞∞E J
.
∞∞J K
Name
∞∞K O
}
∞∞O P
$str
∞∞P Q
"
∞∞Q R
;
∞∞R S
Console
±± 
.
±± 
	WriteLine
±± 
(
±± 
leaveMessage
±± *
)
±±* +
;
±±+ ,
foreach
≥≥ 
(
≥≥ 
var
≥≥ 
player
≥≥ 
in
≥≥  "
lobby
≥≥# (
.
≥≥( )
Players
≥≥) 0
)
≥≥0 1
{
¥¥ 
if
µµ 
(
µµ 
player
µµ 
!=
µµ 

playerLeft
µµ (
&&
µµ) +
_connectedPlayers
µµ, =
.
µµ= >
TryGetValue
µµ> I
(
µµI J
player
µµJ P
,
µµP Q
out
µµR U
var
µµV Y
callback
µµZ b
)
µµb c
)
µµc d
{
∂∂ 
try
∑∑ 
{
∏∏ 
callback
ππ  
.
ππ  !
NotifyPlayerLeft
ππ! 1
(
ππ1 2

playerLeft
ππ2 <
,
ππ< =
lobby
ππ> C
.
ππC D
LobbyId
ππD K
)
ππK L
;
ππL M
callback
∫∫  
.
∫∫  !%
NotifyPlayerLeftMessage
∫∫! 8
(
∫∫8 9
leaveMessage
∫∫9 E
)
∫∫E F
;
∫∫F G
}
ªª 
catch
ºº 
(
ºº 
	Exception
ºº $
ex
ºº% '
)
ºº' (
{
ΩΩ 
Console
ææ 
.
ææ  
	WriteLine
ææ  )
(
ææ) *
$"
ææ* ,
$str
ææ, C
{
ææC D
player
ææD J
}
ææJ K
$str
ææK M
{
ææM N
ex
ææN P
.
ææP Q
Message
ææQ X
}
ææX Y
"
ææY Z
)
ææZ [
;
ææ[ \$
HandleClientDisconnect
øø .
(
øø. /
player
øø/ 5
)
øø5 6
;
øø6 7
}
¿¿ 
}
¡¡ 
}
¬¬ 
}
√√ 	
public
≈≈ 
List
≈≈ 
<
≈≈ 
LobbyDTO
≈≈ 
>
≈≈ 
GetAllLobbies
≈≈ +
(
≈≈+ ,
)
≈≈, -
{
∆∆ 	
return
«« 
_activeLobbies
«« !
.
««! "
Values
««" (
.
««( )
Select
««) /
(
««/ 0
lobby
««0 5
=>
««6 8
new
««9 <
LobbyDTO
««= E
{
»» 
LobbyId
…… 
=
…… 
lobby
…… 
.
……  
LobbyId
……  '
,
……' (
Name
   
=
   
lobby
   
.
   
Name
   !
,
  ! "
	IsPrivate
ÀÀ 
=
ÀÀ 
lobby
ÀÀ !
.
ÀÀ! "
	IsPrivate
ÀÀ" +
,
ÀÀ+ ,
CurrentPlayers
ÃÃ 
=
ÃÃ  
lobby
ÃÃ! &
.
ÃÃ& '
Players
ÃÃ' .
.
ÃÃ. /
Count
ÃÃ/ 4
,
ÃÃ4 5

MaxPlayers
ÕÕ 
=
ÕÕ 
lobby
ÕÕ "
.
ÕÕ" #

MaxPlayers
ÕÕ# -
,
ÕÕ- .
Host
ŒŒ 
=
ŒŒ 
lobby
ŒŒ 
.
ŒŒ 
Host
ŒŒ !
,
ŒŒ! "
Players
œœ 
=
œœ 
new
œœ 
List
œœ "
<
œœ" #
string
œœ# )
>
œœ) *
(
œœ* +
lobby
œœ+ 0
.
œœ0 1
Players
œœ1 8
)
œœ8 9
}
–– 
)
–– 
.
–– 
ToList
–– 
(
–– 
)
–– 
;
–– 
}
—— 	
public
”” 
LobbyResponse
”” 

KickPlayer
”” '
(
””' (
string
””( .
lobbyId
””/ 6
,
””6 7
string
””8 >
hostUsername
””? K
,
””K L
string
””M S
targetUsername
””T b
)
””b c
{
‘‘ 	
if
’’ 
(
’’ 
!
’’ 
_activeLobbies
’’ 
.
’’  
TryGetValue
’’  +
(
’’+ ,
lobbyId
’’, 3
,
’’3 4
out
’’5 8
var
’’9 <
lobby
’’= B
)
’’B C
)
’’C D
{
÷÷ 
return
◊◊ 
LobbyResponse
◊◊ $
.
◊◊$ %
Failure
◊◊% ,
(
◊◊, -
ErrorMessages
◊◊- :
.
◊◊: ;
LobbyNotFound
◊◊; H
)
◊◊H I
;
◊◊I J
}
ÿÿ 
if
⁄⁄ 
(
⁄⁄ 
lobby
⁄⁄ 
.
⁄⁄ 
Host
⁄⁄ 
!=
⁄⁄ 
hostUsername
⁄⁄ *
)
⁄⁄* +
{
€€ 
return
‹‹ 
LobbyResponse
‹‹ $
.
‹‹$ %
Failure
‹‹% ,
(
‹‹, -
ErrorMessages
‹‹- :
.
‹‹: ;
NotLobbyHost
‹‹; G
)
‹‹G H
;
‹‹H I
}
›› 
if
ﬂﬂ 
(
ﬂﬂ 
!
ﬂﬂ 
lobby
ﬂﬂ 
.
ﬂﬂ 
Players
ﬂﬂ 
.
ﬂﬂ 
Contains
ﬂﬂ '
(
ﬂﬂ' (
targetUsername
ﬂﬂ( 6
)
ﬂﬂ6 7
)
ﬂﬂ7 8
{
‡‡ 
return
·· 
LobbyResponse
·· $
.
··$ %
Failure
··% ,
(
··, -
ErrorMessages
··- :
.
··: ;
PlayerNotInLobby
··; K
)
··K L
;
··L M
}
‚‚ 
lobby
‰‰ 
.
‰‰ 
RemovePlayer
‰‰ 
(
‰‰ 
targetUsername
‰‰ -
)
‰‰- .
;
‰‰. /
_connectedPlayers
ÂÂ 
.
ÂÂ 
	TryRemove
ÂÂ '
(
ÂÂ' (
targetUsername
ÂÂ( 6
,
ÂÂ6 7
out
ÂÂ8 ;
_
ÂÂ< =
)
ÂÂ= >
;
ÂÂ> ?
NotifyPlayerLeft
ÁÁ 
(
ÁÁ 
lobby
ÁÁ "
,
ÁÁ" #
targetUsername
ÁÁ$ 2
)
ÁÁ2 3
;
ÁÁ3 4
var
ÈÈ 
lobbyDto
ÈÈ 
=
ÈÈ 
new
ÈÈ 
LobbyDTO
ÈÈ '
{
ÍÍ 
LobbyId
ÎÎ 
=
ÎÎ 
lobby
ÎÎ 
.
ÎÎ  
LobbyId
ÎÎ  '
,
ÎÎ' (
Name
ÏÏ 
=
ÏÏ 
lobby
ÏÏ 
.
ÏÏ 
Name
ÏÏ !
,
ÏÏ! "
	IsPrivate
ÌÌ 
=
ÌÌ 
lobby
ÌÌ !
.
ÌÌ! "
	IsPrivate
ÌÌ" +
,
ÌÌ+ ,
CurrentPlayers
ÓÓ 
=
ÓÓ  
lobby
ÓÓ! &
.
ÓÓ& '
Players
ÓÓ' .
.
ÓÓ. /
Count
ÓÓ/ 4
,
ÓÓ4 5

MaxPlayers
ÔÔ 
=
ÔÔ 
lobby
ÔÔ "
.
ÔÔ" #

MaxPlayers
ÔÔ# -
,
ÔÔ- .
Host
 
=
 
lobby
 
.
 
Host
 !
,
! "
Players
ÒÒ 
=
ÒÒ 
new
ÒÒ 
List
ÒÒ "
<
ÒÒ" #
string
ÒÒ# )
>
ÒÒ) *
(
ÒÒ* +
lobby
ÒÒ+ 0
.
ÒÒ0 1
Players
ÒÒ1 8
)
ÒÒ8 9
}
ÚÚ 
;
ÚÚ 
return
ÙÙ 
LobbyResponse
ÙÙ  
.
ÙÙ  !
SuccessResult
ÙÙ! .
(
ÙÙ. /
lobbyDto
ÙÙ/ 7
)
ÙÙ7 8
;
ÙÙ8 9
}
ıı 	
public
˜˜ 
OperationResponse
˜˜  
	StartGame
˜˜! *
(
˜˜* +
string
˜˜+ 1
lobbyId
˜˜2 9
,
˜˜9 :
string
˜˜; A
hostUsername
˜˜B N
)
˜˜N O
{
¯¯ 	
if
˘˘ 
(
˘˘ 
!
˘˘ 
_activeLobbies
˘˘ 
.
˘˘  
TryGetValue
˘˘  +
(
˘˘+ ,
lobbyId
˘˘, 3
,
˘˘3 4
out
˘˘5 8
var
˘˘9 <
lobby
˘˘= B
)
˘˘B C
)
˘˘C D
{
˙˙ 
return
˚˚ 
OperationResponse
˚˚ (
.
˚˚( )
Failure
˚˚) 0
(
˚˚0 1
LobbyMessages
˚˚1 >
.
˚˚> ?
LobbyNotFound
˚˚? L
)
˚˚L M
;
˚˚M N
}
¸¸ 
if
˛˛ 
(
˛˛ 
lobby
˛˛ 
.
˛˛ 
Host
˛˛ 
!=
˛˛ 
hostUsername
˛˛ *
)
˛˛* +
{
ˇˇ 
return
ÄÄ 
OperationResponse
ÄÄ (
.
ÄÄ( )
Failure
ÄÄ) 0
(
ÄÄ0 1
LobbyMessages
ÄÄ1 >
.
ÄÄ> ?
OnlyHostStart
ÄÄ? L
)
ÄÄL M
;
ÄÄM N
}
ÅÅ 
if
ÉÉ 
(
ÉÉ 
lobby
ÉÉ 
.
ÉÉ 
Players
ÉÉ 
.
ÉÉ 
Count
ÉÉ #
<
ÉÉ$ %
$num
ÉÉ& '
)
ÉÉ' (
{
ÑÑ 
return
ÖÖ 
OperationResponse
ÖÖ (
.
ÖÖ( )
Failure
ÖÖ) 0
(
ÖÖ0 1
LobbyMessages
ÖÖ1 >
.
ÖÖ> ?
NotEnoughPlayer
ÖÖ? N
)
ÖÖN O
;
ÖÖO P
}
ÜÜ 
if
àà 
(
àà 
!
àà $
NotifyPlayersStartGame
àà '
(
àà' (
lobby
àà( -
)
àà- .
)
àà. /
{
ââ 
return
ää 
OperationResponse
ää (
.
ää( )
Failure
ää) 0
(
ää0 1
LobbyMessages
ää1 >
.
ää> ?!
NotificationMissing
ää? R
)
ääR S
;
ääS T
}
ãã 
return
çç 
OperationResponse
çç $
.
çç$ %
SuccessResult
çç% 2
(
çç2 3
LobbyMessages
çç3 @
.
çç@ A
GameStarted
ççA L
)
ççL M
;
ççM N
}
éé 	
private
êê 
bool
êê $
NotifyPlayersStartGame
êê +
(
êê+ ,
Lobby
êê, 1
lobby
êê2 7
)
êê7 8
{
ëë 	
bool
íí (
allNotificationsSuccessful
íí +
=
íí, -
true
íí. 2
;
íí2 3
foreach
îî 
(
îî 
var
îî 
player
îî 
in
îî  "
lobby
îî# (
.
îî( )
Players
îî) 0
)
îî0 1
{
ïï 
if
ññ 
(
ññ 
player
ññ 
==
ññ 
lobby
ññ #
.
ññ# $
Host
ññ$ (
)
ññ( )
continue
ññ* 2
;
ññ2 3
if
òò 
(
òò 
_connectedPlayers
òò %
.
òò% &
TryGetValue
òò& 1
(
òò1 2
player
òò2 8
,
òò8 9
out
òò: =
var
òò> A
callback
òòB J
)
òòJ K
)
òòK L
{
ôô 
try
öö 
{
õõ 
callback
úú  
.
úú  !#
StartGameNotification
úú! 6
(
úú6 7
lobby
úú7 <
.
úú< =
LobbyId
úú= D
)
úúD E
;
úúE F
}
ùù 
catch
ûû 
(
ûû 
	Exception
ûû $
ex
ûû% '
)
ûû' (
{
üü 
Console
†† 
.
††  
	WriteLine
††  )
(
††) *
$"
††* ,
$str
††, C
{
††C D
player
††D J
}
††J K
$str
††K [
{
††[ \
ex
††\ ^
.
††^ _
Message
††_ f
}
††f g
"
††g h
)
††h i
;
††i j$
HandleClientDisconnect
°° .
(
°°. /
player
°°/ 5
)
°°5 6
;
°°6 7(
allNotificationsSuccessful
¢¢ 2
=
¢¢3 4
false
¢¢5 :
;
¢¢: ;
}
££ 
}
§§ 
}
•• 
return
¶¶ (
allNotificationsSuccessful
¶¶ -
;
¶¶- .
}
ßß 	
}
©© 
}™™ ã;
kC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\GuestPlayerService.cs
	namespace 	
Service
 
. 

Implements 
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
,I J
ConcurrencyModeK Z
=[ \
ConcurrencyMode] l
.l m
Multiplem u
)u v
]v w
public 

class 
GuestPlayerService #
:$ %
IGuestPlayerService& 9
{ 
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
private 
readonly 
ConnectionManager *
_connectionManager+ =
;= >
private 
readonly "
ConnectionEventHandler /#
_connectionEventHandler0 G
;G H
public 
GuestPlayerService !
(! "
IPlayerRepository 
playerRepository .
,. /
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
_connectionManager!! 
=!!  
connectionManager!!! 2
;!!2 3#
_connectionEventHandler"" #
=""$ %"
connectionEventHandler""& <
;""< =
}## 	
public%% 
OperationResponse%%  
RegisterGuestPlayer%%! 4
(%%4 5
string%%5 ;
username%%< D
)%%D E
{&& 	
if'' 
('' 
string'' 
.'' 
IsNullOrWhiteSpace'' )
('') *
username''* 2
)''2 3
)''3 4
return(( 
OperationResponse(( (
.((( )
Failure(() 0
(((0 1
ErrorMessages((1 >
.((> ?
InvalidUsername((? N
)((N O
;((O P
if** 
(** 
_connectionManager** "
.**" #
IsUserRegistered**# 3
(**3 4
username**4 <
)**< =
)**= >
return++ 
OperationResponse++ (
.++( )
Failure++) 0
(++0 1
ErrorMessages++1 >
.++> ? 
UserAlreadyConnected++? S
)++S T
;++T U
try-- 
{.. 
var// 
existingPlayer// "
=//# $
_playerRepository//% 6
.//6 7
GetByUsername//7 D
(//D E
username//E M
)//M N
;//N O
if00 
(00 
existingPlayer00 "
!=00# %
null00& *
)00* +
return11 
OperationResponse11 ,
.11, -
Failure11- 4
(114 5
ErrorMessages115 B
.11B C
DuplicateUsername11C T
)11T U
;11U V
if33 
(33 
OperationContext33 $
.33$ %
Current33% ,
?33, -
.33- .
Channel33. 5
is336 8
IContextChannel339 H
channel33I P
)33P Q
{44 
bool55 

registered55 #
=55$ %
_connectionManager55& 8
.558 9
RegisterUser559 E
(55E F
username55F N
,55N O
channel55P W
)55W X
;55X Y
if66 
(66 
!66 

registered66 #
)66# $
return77 
OperationResponse77 0
.770 1
Failure771 8
(778 9
ErrorMessages779 F
.77F G 
UserAlreadyConnected77G [
)77[ \
;77\ ]#
_connectionEventHandler99 +
.99+ ,!
RegisterChannelEvents99, A
(99A B
username99B J
,99J K
channel99L S
)99S T
;99T U
}:: 
return<< 
OperationResponse<< (
.<<( )
SuccessResult<<) 6
(<<6 7
)<<7 8
;<<8 9
}== 
catch>> 
(>> 
SqlException>> 
ex>>  "
)>>" #
{?? 
CustomLogger@@ 
.@@ 
Error@@ "
(@@" #
$str@@# O
,@@O P
ex@@Q S
)@@S T
;@@T U
stringAA 
errorMessageAA #
=AA$ %
SqlErrorHandlerAA& 5
.AA5 6
GetErrorMessageAA6 E
(AAE F
exAAF H
)AAH I
;AAI J
returnBB 
OperationResponseBB (
.BB( )
FailureBB) 0
(BB0 1
errorMessageBB1 =
)BB= >
;BB> ?
}CC 
catchDD 
(DD 
	ExceptionDD 
exDD 
)DD  
{EE 
CustomLoggerFF 
.FF 
FatalFF "
(FF" #
$strFF# V
,FFV W
exFFX Z
)FFZ [
;FF[ \
returnGG 
OperationResponseGG (
.GG( )
FailureGG) 0
(GG0 1
ErrorMessagesGG1 >
.GG> ?
GeneralExceptionGG? O
)GGO P
;GGP Q
}HH 
}II 	
publicKK 
OperationResponseKK  
LogoutGuestPlayerKK! 2
(KK2 3
stringKK3 9
usernameKK: B
)KKB C
{LL 	
ifMM 
(MM 
stringMM 
.MM 
IsNullOrWhiteSpaceMM )
(MM) *
usernameMM* 2
)MM2 3
)MM3 4
returnNN 
OperationResponseNN (
.NN( )
FailureNN) 0
(NN0 1
ErrorMessagesNN1 >
.NN> ?
InvalidUsernameNN? N
)NNN O
;NNO P
tryPP 
{QQ 
ifRR 
(RR 
!RR 
_connectionManagerRR '
.RR' (
IsUserRegisteredRR( 8
(RR8 9
usernameRR9 A
)RRA B
)RRB C
{SS 
returnTT 
OperationResponseTT ,
.TT, -
FailureTT- 4
(TT4 5
ErrorMessagesTT5 B
.TTB C
UserNotConnectedTTC S
)TTS T
;TTT U
}UU #
_connectionEventHandlerWW '
.WW' (
HandleDisconnectionWW( ;
(WW; <
usernameWW< D
)WWD E
;WWE F
_connectionManagerXX "
.XX" #
UnregisterUserXX# 1
(XX1 2
usernameXX2 :
)XX: ;
;XX; <
CustomLoggerZZ 
.ZZ 
InfoZZ !
(ZZ! "
$"ZZ" $
$strZZ$ 1
{ZZ1 2
usernameZZ2 :
}ZZ: ;
$strZZ; X
"ZZX Y
)ZZY Z
;ZZZ [
return\\ 
OperationResponse\\ (
.\\( )
SuccessResult\\) 6
(\\6 7
)\\7 8
;\\8 9
}]] 
catch^^ 
(^^ 
	Exception^^ 
ex^^ 
)^^  
{__ 
CustomLogger`` 
.`` 
Error`` "
(``" #
$str``# P
,``P Q
ex``R T
)``T U
;``U V
returnaa 
OperationResponseaa (
.aa( )
Failureaa) 0
(aa0 1
ErrorMessagesaa1 >
.aa> ?
GeneralExceptionaa? O
)aaO P
;aaP Q
}bb 
}cc 	
}ee 
}ff áÑ
dC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\GameService.cs
	namespace 	
Service
 
. 

Implements 
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?

PerSession? I
,I J
ConcurrencyModeK Z
=[ \
ConcurrencyMode] l
.l m
Multiplem u
)u v
]v w
public 

class 
GameService 
: 
IGameService +
{ 
public 
static 
readonly  
ConcurrentDictionary 3
<3 4
string4 :
,: ;
GameSession< G
>G H
_activeGamesI U
=V W
newX [ 
ConcurrentDictionary\ p
<p q
stringq w
,w x
GameSession	y Ñ
>
Ñ Ö
(
Ö Ü
)
Ü á
;
á à
public 
async 
Task 
< 
OperationResponse +
>+ ,
AttackAsync- 8
(8 9
string9 ?
lobbyId@ G
,G H
stringI O
attackerP X
,X Y
AttackPositionDTOZ k
attackPositionl z
)z {
{ 	
if 
( 
! 
_activeGames 
. 
TryGetValue )
() *
lobbyId* 1
,1 2
out3 6
var7 :
gameSession; F
)F G
)G H
{ 
Console 
. 
	WriteLine !
(! "
$"" $
$str$ 1
{1 2
lobbyId2 9
}9 :
$str: I
"I J
)J K
;K L
return 
OperationResponse (
.( )
Failure) 0
(0 1
$str1 B
)B C
;C D
} 
var 
opponent 
= 
gameSession &
.& '
GetOpponent' 2
(2 3
attacker3 ;
); <
;< =
if 
( 
opponent 
== 
null  
)  !
{ 
Console   
.   
	WriteLine   !
(  ! "
$"  " $
$str  $ 1
{  1 2
attacker  2 :
}  : ;
$str  ; _
{  _ `
lobbyId  ` g
}  g h
$str  h j
"  j k
)  k l
;  l m
return!! 
OperationResponse!! (
.!!( )
Failure!!) 0
(!!0 1
$str!!1 F
)!!F G
;!!G H
}"" 
if$$ 
($$ 
gameSession$$ 
.$$ 
GetCurrentPlayer$$ ,
($$, -
)$$- .
!=$$/ 1
attacker$$2 :
)$$: ;
{%% 
Console&& 
.&& 
	WriteLine&& !
(&&! "
$"&&" $
$str&&$ /
{&&/ 0
attacker&&0 8
}&&8 9
$str&&9 c
"&&c d
)&&d e
;&&e f
return'' 
OperationResponse'' (
.''( )
Failure'') 0
(''0 1
$str''1 F
)''F G
;''G H
}(( 
if++ 
(++ 
gameSession++ 
.++ 
TryGetCallback++ *
(++* +
opponent+++ 3
,++3 4
out++5 8
var++9 <
opponentCallback++= M
)++M N
)++N O
{,, 
try-- 
{.. 
opponentCallback// $
.//$ %
OnAttackReceived//% 5
(//5 6
attackPosition//6 D
)//D E
;//E F
Console00 
.00 
	WriteLine00 %
(00% &
$"00& (
$str00( 9
{009 :
opponent00: B
}00B C
$str00C P
{00P Q
attackPosition00Q _
.00_ `
X00` a
}00a b
$str00b f
{00f g
attackPosition00g u
.00u v
Y00v w
}00w x
$str00x y
"00y z
)00z {
;00{ |
gameSession22 
.22  

RotateTurn22  *
(22* +
)22+ ,
;22, -
Console33 
.33 
	WriteLine33 %
(33% &
$str33& 9
)339 :
;33: ;
return44 
OperationResponse44 ,
.44, -
SuccessResult44- :
(44: ;
$str44; I
)44I J
;44J K
}55 
catch66 
(66 
	Exception66  
ex66! #
)66# $
{77 
Console88 
.88 
	WriteLine88 %
(88% &
$"88& (
$str88( C
{88C D
opponent88D L
}88L M
$str88M O
{88O P
ex88P R
.88R S
Message88S Z
}88Z [
"88[ \
)88\ ]
;88] ^
return99 
OperationResponse99 ,
.99, -
Failure99- 4
(994 5
$str995 Q
)99Q R
;99R S
}:: 
};; 
else<< 
{== 
Console>> 
.>> 
	WriteLine>> !
(>>! "
$">>" $
$str>>$ ?
{>>? @
opponent>>@ H
}>>H I
$str>>I f
{>>f g
lobbyId>>g n
}>>n o
$str>>o q
">>q r
)>>r s
;>>s t
return?? 
OperationResponse?? (
.??( )
Failure??) 0
(??0 1
$str??1 S
)??S T
;??T U
}@@ 
}AA 	
publicDD 
OperationResponseDD  
InitializeGameDD! /
(DD/ 0
stringDD0 6
lobbyIdDD7 >
,DD> ?
ListDD@ D
<DDD E
stringDDE K
>DDK L
playersDDM T
)DDT U
{EE 	
ifFF 
(FF 
_activeGamesFF 
.FF 
ContainsKeyFF (
(FF( )
lobbyIdFF) 0
)FF0 1
)FF1 2
{GG 
returnHH 
OperationResponseHH (
.HH( )
FailureHH) 0
(HH0 1
GameMessagesHH1 =
.HH= >
GameAlredyExistHH> M
)HHM N
;HHN O
}II 
varKK 
gameSessionKK 
=KK 
newKK !
GameSessionKK" -
(KK- .
)KK. /
;KK/ 0
foreachLL 
(LL 
varLL 
playerLL 
inLL  "
playersLL# *
)LL* +
{MM 
tryNN 
{OO 
gameSessionPP 
.PP  
	AddPlayerPP  )
(PP) *
playerPP* 0
)PP0 1
;PP1 2
}QQ 
catchRR 
(RR 
	ExceptionRR  
exRR! #
)RR# $
{SS 
CustomLoggerTT  
.TT  !
WarnTT! %
(TT% &
exTT& (
.TT( )
MessageTT) 0
)TT0 1
;TT1 2
returnUU 
OperationResponseUU ,
.UU, -
FailureUU- 4
(UU4 5
GameMessagesUU5 A
.UUA B
CantAddingPlayerUUB R
)UUR S
;UUS T
}VV 
}WW 
_activeGamesYY 
[YY 
lobbyIdYY  
]YY  !
=YY" #
gameSessionYY$ /
;YY/ 0"
PrintGameSessionsStateZZ "
(ZZ" #
)ZZ# $
;ZZ$ %
return[[ 
OperationResponse[[ $
.[[$ %
SuccessResult[[% 2
([[2 3
)[[3 4
;[[4 5
}\\ 	
public^^ 
async^^ 
Task^^ 
<^^ 
OperationResponse^^ +
>^^+ , 
MarkPlayerReadyAsync^^- A
(^^A B
string^^B H
lobbyId^^I P
,^^P Q
string^^R X
player^^Y _
)^^_ `
{__ 	
if`` 
(`` 
!`` 
_activeGames`` 
.`` 
TryGetValue`` )
(``) *
lobbyId``* 1
,``1 2
out``3 6
var``7 :
gameSession``; F
)``F G
)``G H
{aa 
returnbb 
OperationResponsebb (
.bb( )
Failurebb) 0
(bb0 1
$strbb1 A
)bbA B
;bbB C
}cc 
tryee 
{ff 
vargg 
callbackgg 
=gg 
OperationContextgg /
.gg/ 0
Currentgg0 7
.gg7 8
GetCallbackChannelgg8 J
<ggJ K
IGameCallbackggK X
>ggX Y
(ggY Z
)ggZ [
;gg[ \
gameSessionhh 
.hh 
RegisterCallbackhh ,
(hh, -
playerhh- 3
,hh3 4
callbackhh5 =
)hh= >
;hh> ?
gameSessionjj 
.jj 
MarkPlayerReadyjj +
(jj+ ,
playerjj, 2
)jj2 3
;jj3 4
Consolell 
.ll 
	WriteLinell !
(ll! "
$"ll" $
$strll$ ,
{ll, -
playerll- 3
}ll3 4
$strll4 L
{llL M
lobbyIdllM T
}llT U
$strllU V
"llV W
)llW X
;llX Y"
PrintGameSessionsStatemm &
(mm& '
)mm' (
;mm( )
ifoo 
(oo 
gameSessionoo 
.oo  
AreAllPlayersReadyoo  2
(oo2 3
)oo3 4
)oo4 5
{pp 
Consoleqq 
.qq 
	WriteLineqq %
(qq% &
$"qq& (
$strqq( U
{qqU V
lobbyIdqqV ]
}qq] ^
$strqq^ _
"qq_ `
)qq` a
;qqa b
varss 
tasksss 
=ss 
newss  #
Listss$ (
<ss( )
Taskss) -
>ss- .
(ss. /
)ss/ 0
;ss0 1
foreachtt 
(tt 
vartt  
registeredPlayertt! 1
intt2 4
gameSessiontt5 @
.tt@ A

GetPlayersttA K
(ttK L
)ttL M
)ttM N
{uu 
ifvv 
(vv 
gameSessionvv '
.vv' (
TryGetCallbackvv( 6
(vv6 7
registeredPlayervv7 G
,vvG H
outvvI L
varvvM P
registeredCallbackvvQ c
)vvc d
)vvd e
{ww 
tasksxx !
.xx! "
Addxx" %
(xx% &
Taskxx& *
.xx* +
Runxx+ .
(xx. /
(xx/ 0
)xx0 1
=>xx2 4
{yy 
tryzz  #
{{{  !
Console||$ +
.||+ ,
	WriteLine||, 5
(||5 6
$"||6 8
$str||8 F
{||F G
registeredPlayer||G W
}||W X
$str||X s
"||s t
)||t u
;||u v
registeredCallback}}$ 6
.}}6 7
OnGameStarted}}7 D
(}}D E
)}}E F
;}}F G
}~~  !
catch  %
(& '
	Exception' 0
ex1 3
)3 4
{
ÄÄ  !
Console
ÅÅ$ +
.
ÅÅ+ ,
	WriteLine
ÅÅ, 5
(
ÅÅ5 6
$"
ÅÅ6 8
$str
ÅÅ8 f
{
ÅÅf g
registeredPlayer
ÅÅg w
}
ÅÅw x
$str
ÅÅx z
{
ÅÅz {
ex
ÅÅ{ }
.
ÅÅ} ~
MessageÅÅ~ Ö
}ÅÅÖ Ü
"ÅÅÜ á
)ÅÅá à
;ÅÅà â
gameSession
ÇÇ$ /
.
ÇÇ/ 0
RemoveCallback
ÇÇ0 >
(
ÇÇ> ?
registeredPlayer
ÇÇ? O
)
ÇÇO P
;
ÇÇP Q
}
ÉÉ  !
}
ÑÑ 
)
ÑÑ 
)
ÑÑ 
;
ÑÑ  
}
ÖÖ 
}
ÜÜ 
await
àà 
Task
àà 
.
àà 
WhenAll
àà &
(
àà& '
tasks
àà' ,
)
àà, -
;
àà- .
return
ââ 
OperationResponse
ââ ,
.
ââ, -
SuccessResult
ââ- :
(
ââ: ;
$str
ââ; L
)
ââL M
;
ââM N
}
ää 
}
ãã 
catch
åå 
(
åå 
	Exception
åå 
ex
åå 
)
åå  
{
çç 
Console
éé 
.
éé 
	WriteLine
éé !
(
éé! "
$"
éé" $
$str
éé$ ?
{
éé? @
player
éé@ F
}
ééF G
$str
ééG T
{
ééT U
ex
ééU W
.
ééW X
Message
ééX _
}
éé_ `
"
éé` a
)
ééa b
;
ééb c
return
èè 
OperationResponse
èè (
.
èè( )
Failure
èè) 0
(
èè0 1
$"
èè1 3
$str
èè3 Z
{
èèZ [
ex
èè[ ]
.
èè] ^
Message
èè^ e
}
èèe f
"
èèf g
)
èèg h
;
èèh i
}
êê 
return
íí 
OperationResponse
íí $
.
íí$ %
SuccessResult
íí% 2
(
íí2 3
$str
íí3 @
)
íí@ A
;
ííA B
}
ìì 	
public
óó 
async
óó 
Task
óó 
<
óó 
OperationResponse
óó +
>
óó+ ,
StartGameAsync
óó- ;
(
óó; <
string
óó< B
lobbyId
óóC J
)
óóJ K
{
òò 	
if
ôô 
(
ôô 
!
ôô 
_activeGames
ôô 
.
ôô 
TryGetValue
ôô )
(
ôô) *
lobbyId
ôô* 1
,
ôô1 2
out
ôô3 6
var
ôô7 :
gameSession
ôô; F
)
ôôF G
)
ôôG H
{
öö 
return
õõ 
OperationResponse
õõ (
.
õõ( )
Failure
õõ) 0
(
õõ0 1
GameMessages
õõ1 =
.
õõ= >
GameNotFound
õõ> J
)
õõJ K
;
õõK L
}
úú 
if
ûû 
(
ûû 
!
ûû 
gameSession
ûû 
.
ûû  
AreAllPlayersReady
ûû /
(
ûû/ 0
)
ûû0 1
)
ûû1 2
{
üü 
return
†† 
OperationResponse
†† (
.
††( )
Failure
††) 0
(
††0 1
GameMessages
††1 =
.
††= >
PlayerNotReady
††> L
)
††L M
;
††M N
}
°° 
CustomLogger
££ 
.
££ 
Info
££ 
(
££ 
$"
££  
$str
££  >
{
££> ?
lobbyId
££? F
}
££F G
"
££G H
)
££H I
;
££I J
await
•• 
Task
•• 
.
•• 
Delay
•• 
(
•• 
$num
••  
)
••  !
;
••! "
return
¶¶ 
OperationResponse
¶¶ $
.
¶¶$ %
SuccessResult
¶¶% 2
(
¶¶2 3
)
¶¶3 4
;
¶¶4 5
}
ßß 	
private
©© 
static
©© 
void
©© $
PrintGameSessionsState
©© 2
(
©©2 3
)
©©3 4
{
™™ 	
if
´´ 
(
´´ 
_activeGames
´´ 
.
´´ 
IsEmpty
´´ $
)
´´$ %
{
¨¨ 
Console
≠≠ 
.
≠≠ 
	WriteLine
≠≠ !
(
≠≠! "
$str
≠≠" <
)
≠≠< =
;
≠≠= >
return
ÆÆ 
;
ÆÆ 
}
ØØ 
foreach
±± 
(
±± 
var
±± 
lobby
±± 
in
±± !
_activeGames
±±" .
)
±±. /
{
≤≤ 
Console
≥≥ 
.
≥≥ 
	WriteLine
≥≥ !
(
≥≥! "
$"
≥≥" $
$str
≥≥$ -
{
≥≥- .
lobby
≥≥. 3
.
≥≥3 4
Key
≥≥4 7
}
≥≥7 8
"
≥≥8 9
)
≥≥9 :
;
≥≥: ;
var
¥¥ 
gameSession
¥¥ 
=
¥¥  !
lobby
¥¥" '
.
¥¥' (
Value
¥¥( -
;
¥¥- .
foreach
∂∂ 
(
∂∂ 
var
∂∂ 
player
∂∂ #
in
∂∂$ &
gameSession
∂∂' 2
.
∂∂2 3

GetPlayers
∂∂3 =
(
∂∂= >
)
∂∂> ?
)
∂∂? @
{
∑∑ 
var
∏∏ 
isReady
∏∏ 
=
∏∏  !
gameSession
∏∏" -
.
∏∏- .
IsPlayerReady
∏∏. ;
(
∏∏; <
player
∏∏< B
)
∏∏B C
?
∏∏D E
$str
∏∏F J
:
∏∏K L
$str
∏∏M Q
;
∏∏Q R
Console
ππ 
.
ππ 
	WriteLine
ππ %
(
ππ% &
$"
ππ& (
$str
ππ( 3
{
ππ3 4
player
ππ4 :
}
ππ: ;
$str
ππ; E
{
ππE F
isReady
ππF M
}
ππM N
"
ππN O
)
ππO P
;
ππP Q
}
∫∫ 
}
ªª 
}
ºº 	
}
ΩΩ 
}ææ §∫
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
$str,,# 1
,,,1 2
ex,,3 5
),,5 6
;,,6 7
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
}ëë ó
eC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\EmailService.cs
	namespace 	
Service
 
. 

Implements 
{ 
public		 

class		 
EmailService		 
:		 
	Contracts		  )
.		) *
IEmailService		* 7
{

 
public 
OperationResponse  
	SendEmail! *
(* +
EmailDTO+ 3
emailDTO4 <
)< =
{ 	
try 
{ 
var 
emailService  
=! "
EmailServiceFactory# 6
.6 7
CreateEmailService7 I
(I J
)J K
;K L
var 
( 
subject 
, 
body "
)" #
=$ %
TemplateFactory& 5
.5 6
GetTemplate6 A
(A B
emailDTOB J
)J K
;K L
emailService 
. 
Send !
(! "
emailDTO" *
.* +
	Recipient+ 4
,4 5
subject6 =
,= >
body? C
)C D
;D E
return 
OperationResponse (
.( )
SuccessResult) 6
(6 7
$str7 Q
)Q R
;R S
} 
catch 
( 
	Exception 
ex 
)  
{! "
return 
OperationResponse (
.( )
Failure) 0
(0 1
$"1 3
$str3 N
{N O
exO Q
.Q R
MessageR Y
}Y Z
"Z [
)[ \
;\ ]
} 
} 	
} 
} ’%
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
public 

class 
ChatService 
: 
IChatService +
{ 
private 
readonly 

Dictionary #
<# $
string$ *
,* + 
IChatServiceCallback, @
>@ A
_connectedUsersB Q
=R S
newT W

DictionaryX b
<b c
stringc i
,i j 
IChatServiceCallbackk 
>	 Ä
(
Ä Å
)
Å Ç
;
Ç É
public 
void 
RegisterUser  
(  !
string! '
username( 0
)0 1
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
IChatServiceCallbackG [
>[ \
(\ ]
)] ^
;^ _
if 
( 
! 
_connectedUsers  
.  !
ContainsKey! ,
(, -
username- 5
)5 6
)6 7
{ 
_connectedUsers 
.  
Add  #
(# $
username$ ,
,, -
callback. 6
)6 7
;7 8
SendMessage 
( 
$str $
,$ %
$"& (
{( )
username) 1
}1 2
$str2 G
"G H
)H I
;I J
IContextChannel 
contextChannel  .
=/ 0
(1 2
IContextChannel2 A
)A B
callbackB J
;J K
contextChannel 
. 
Closed %
+=& (
() *
sender* 0
,0 1
args2 6
)6 7
=>8 :
DisconnectUser; I
(I J
usernameJ R
)R S
;S T
contextChannel 
. 
Faulted &
+=' )
(* +
sender+ 1
,1 2
args3 7
)7 8
=>9 ;
DisconnectUser< J
(J K
usernameK S
)S T
;T U
} 
} 	
public!! 
void!! 
DisconnectUser!! "
(!!" #
string!!# )
username!!* 2
)!!2 3
{"" 	
if## 
(## 
_connectedUsers## 
.##  
ContainsKey##  +
(##+ ,
username##, 4
)##4 5
)##5 6
{$$ 
_connectedUsers%% 
.%%  
Remove%%  &
(%%& '
username%%' /
)%%/ 0
;%%0 1
SendMessage'' 
('' 
$str'' $
,''$ %
$"''& (
{''( )
username'') 1
}''1 2
$str''2 E
"''E F
)''F G
;''G H
}(( 
})) 	
public++ 
void++ 
SendMessage++ 
(++  
string++  &
username++' /
,++/ 0
string++1 7
message++8 ?
)++? @
{,, 	
string-- 
fullMessage-- 
=--  
$"--! #
{--# $
username--$ ,
}--, -
$str--- /
{--/ 0
message--0 7
}--7 8
"--8 9
;--9 :
foreach// 
(// 
var// 
userCallback// %
in//& (
_connectedUsers//) 8
)//8 9
{00 
try22 
{33 
if44 
(44 
userCallback44 $
.44$ %
Key44% (
!=44) +
username44, 4
)444 5
{55 
userCallback88 $
.88$ %
Value88% *
.88* +
ReceiveMessage88+ 9
(889 :
fullMessage88: E
)88E F
;88F G
}99 
}:: 
catch;; 
(;; 
	Exception;; $
ex;;% '
);;' (
{<< 
Console== 
.==  
	WriteLine==  )
(==) *
$"==* ,
$str==, E
{==E F
username==F N
}==N O
$str==O Q
{==Q R
ex==R T
.==T U
Message==U \
}==\ ]
"==] ^
)==^ _
;==_ `
}>> 
}AA 
}BB 	
}CC 
}DD ã 
iC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\ChatLobbyService.cs
	namespace 	
Service
 
. 

Implements 
{ 
[		 
ServiceBehavior		 
(		 
InstanceContextMode		 (
=		) *
InstanceContextMode		+ >
.		> ?

PerSession		? I
,		I J
ConcurrencyMode		K Z
=		[ \
ConcurrencyMode		] l
.		l m
Multiple		m u
)		u v
]		v w
public

 

class

 
ChatLobbyService

 !
:

" #
IChatLobbyService

$ 5
{ 
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
string5 ;
,; < 
ConcurrentDictionary= Q
<Q R
stringR X
,X Y
IChatLobbyCallbackZ l
>l m
>m n
_lobbyUserso z
={ |
new	} Ä"
ConcurrentDictionary
Å ï
<
ï ñ
string
ñ ú
,
ú ù"
ConcurrentDictionary
û ≤
<
≤ ≥
string
≥ π
,
π ∫ 
IChatLobbyCallback
ª Õ
>
Õ Œ
>
Œ œ
(
œ –
)
– —
;
— “
public 
void 
RegisterUser  
(  !
string! '
username( 0
,0 1
string2 8
lobbyId9 @
)@ A
{ 	
var 
callback 
= 
OperationContext +
.+ ,
Current, 3
.3 4
GetCallbackChannel4 F
<F G
IChatLobbyCallbackG Y
>Y Z
(Z [
)[ \
;\ ]
if 
( 
! 
_lobbyUsers 
. 
ContainsKey (
(( )
lobbyId) 0
)0 1
)1 2
{ 
_lobbyUsers 
[ 
lobbyId #
]# $
=% &
new' * 
ConcurrentDictionary+ ?
<? @
string@ F
,F G
IChatLobbyCallbackH Z
>Z [
([ \
)\ ]
;] ^
} 
_lobbyUsers 
[ 
lobbyId 
]  
[  !
username! )
]) *
=+ ,
callback- 5
;5 6
} 	
public 
void 
SendMessage 
(  
string  &
lobbyId' .
,. /
string0 6
username7 ?
,? @
stringA G
messageH O
)O P
{ 	
if 
( 
! 
_lobbyUsers 
. 
TryGetValue (
(( )
lobbyId) 0
,0 1
out2 5
var6 9
usersInLobby: F
)F G
)G H
{ 
return 
; 
} 
foreach!! 
(!! 
var!! 
userCallback!! %
in!!& (
usersInLobby!!) 5
.!!5 6
Values!!6 <
)!!< =
{"" 
try## 
{$$ 
userCallback%%  
.%%  !
ReceiveMessage%%! /
(%%/ 0
username%%0 8
,%%8 9
message%%: A
)%%A B
;%%B C
}&& 
catch'' 
('' 
	Exception''  
ex''! #
)''# $
{(( 
CustomLogger))  
.))  !
Warn))! %
())% &
ex))& (
.))( )
Message))) 0
)))0 1
;))1 2
Console** 
.** 
	WriteLine** %
(**% &
$"**& (
$str**( A
{**A B
username**B J
}**J K
$str**K M
{**M N
ex**N P
.**P Q
Message**Q X
}**X Y
"**Y Z
)**Z [
;**[ \
}++ 
},, 
}-- 	
}.. 
}// ê
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
}-- ïG
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
(((0 1
MessageChatFriend((1 B
.((B C
SenderNotFound((C Q
)((Q R
;((R S
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
(--0 1
MessageChatFriend--1 B
.--B C
NoAreFriend--C N
)--N O
;--O P
}.. 
try00 
{11 
var22 
formattedMessage22 $
=22% &
$"22' )
{22) *
senderUsername22* 8
}228 9
$str229 ;
{22; <
message22< C
}22C D
"22D E
;22E F#
_chatMessagesRepository33 '
.33' (

AddMessage33( 2
(332 3
sender333 9
.339 :
PlayerID33: B
,33B C
receiver33D L
.33L M
PlayerID33M U
,33U V
formattedMessage33W g
)33g h
;33h i
var55 

messageDto55 
=55  
new55! $
MessageFriendDTO55% 5
{66 
ReceiverUsername77 $
=77% &
senderUsername77' 5
,775 6
SenderUsername88 "
=88# $
senderUsername88% 3
,883 4
Message99 
=99 
formattedMessage99 .
,99. /
	Timestamp:: 
=:: 
DateTime::  (
.::( )
Now::) ,
};; 
;;; 
if== 
(== 
_connectionManager== &
.==& '
IsUserRegistered==' 7
(==7 8
receiverUsername==8 H
)==H I
&&==J L
_connectionManager>> &
.>>& '
GetActiveUsers>>' 5
(>>5 6
)>>6 7
.>>7 8
TryGetValue>>8 C
(>>C D
receiverUsername>>D T
,>>T U
out>>V Y
var>>Z ]
receiverChannel>>^ m
)>>m n
)>>n o
{?? 
var@@ 
receiverCallback@@ (
=@@) *
receiverChannel@@+ :
.@@: ;
GetProperty@@; F
<@@F G
IChatFriendCallback@@G Z
>@@Z [
(@@[ \
)@@\ ]
;@@] ^
receiverCallbackAA $
?AA$ %
.AA% &
ReceiveMessageAA& 4
(AA4 5

messageDtoAA5 ?
)AA? @
;AA@ A
}BB 
returnDD 
OperationResponseDD (
.DD( )
SuccessResultDD) 6
(DD6 7
)DD7 8
;DD8 9
}EE 
catchFF 
(FF 
	ExceptionFF 
exFF 
)FF  
{GG 
ConsoleHH 
.HH 
	WriteLineHH !
(HH! "
$"HH" $
$strHH$ =
{HH= >
receiverUsernameHH> N
}HHN O
$strHHO Q
{HHQ R
exHHR T
.HHT U
MessageHHU \
}HH\ ]
"HH] ^
)HH^ _
;HH_ `
returnII 
OperationResponseII (
.II( )
FailureII) 0
(II0 1
MessageChatFriendII1 B
.IIB C
CantSendMessagesIIC S
)IIS T
;IIT U
}JJ 
}KK 	
publicMM 
ChatFriendResponseMM !
GetChatHistoryMM" 0
(MM0 1
stringMM1 7
	username1MM8 A
,MMA B
stringMMC I
	username2MMJ S
)MMS T
{NN 	
varOO 
player1OO 
=OO 
_playerRepositoryOO +
.OO+ ,
GetByUsernameOO, 9
(OO9 :
	username1OO: C
)OOC D
;OOD E
varPP 
player2PP 
=PP 
_playerRepositoryPP +
.PP+ ,
GetByUsernamePP, 9
(PP9 :
	username2PP: C
)PPC D
;PPD E
ifRR 
(RR 
player1RR 
==RR 
nullRR 
||RR  "
player2RR# *
==RR+ -
nullRR. 2
)RR2 3
{SS 
returnTT 
ChatFriendResponseTT )
.TT) *
FailureTT* 1
(TT1 2
MessageChatFriendTT2 C
.TTC D
SenderNotFoundTTD R
)TTR S
;TTS T
}UU 
tryWW 
{XX 
varYY 
messagesYY 
=YY #
_chatMessagesRepositoryYY 6
.YY6 7%
GetMessagesBetweenPlayersYY7 P
(YYP Q
player1YYQ X
.YYX Y
PlayerIDYYY a
,YYa b
player2YYc j
.YYj k
PlayerIDYYk s
)YYs t
;YYt u
var[[ 
messageList[[ 
=[[  !
messages[[" *
.[[* +
Select[[+ 1
([[1 2
m[[2 3
=>[[4 6
new[[7 :
MessageFriendDTO[[; K
{\\ 
SenderUsername]] "
=]]# $
m]]% &
.]]& '
Player]]' -
.]]- .
Username]]. 6
,]]6 7
Message^^ 
=^^ 
m^^ 
.^^  
MessageText^^  +
,^^+ ,
	Timestamp__ 
=__ 
(__  !
DateTime__! )
)__) *
m__* +
.__+ ,
	Timestamp__, 5
}`` 
)`` 
.`` 
ToList`` 
(`` 
)`` 
;`` 
returnbb 
ChatFriendResponsebb )
.bb) *
SuccessResultbb* 7
(bb7 8
messageListbb8 C
)bbC D
;bbD E
}cc 
catchdd 
(dd 
	Exceptiondd 
exdd 
)dd  
{ee 
Consoleff 
.ff 
	WriteLineff !
(ff! "
$"ff" $
$strff$ C
{ffC D
exffD F
.ffF G
MessageffG N
}ffN O
"ffO P
)ffP Q
;ffQ R
returngg 
ChatFriendResponsegg )
.gg) *
Failuregg* 1
(gg1 2
$strgg2 R
)ggR S
;ggS T
}hh 
}ii 	
}jj 
}kk ái
gC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Implements\AccountService.cs
	namespace 	
Service
 
. 

Implements 
{ 
public 

class 
AccountService 
:  !
IAccountService" 1
{ 
private 
readonly 
IPlayerRepository *
_playerRepository+ <
;< =
private 
readonly 
IProfileRepository +
_profileRepository, >
;> ?
private 
readonly #
IPlayerScoresRepository 0
_scoreRepository1 A
;A B
private 
readonly 
ConnectionManager *
_connectionManager+ =
;= >
private 
readonly "
ConnectionEventHandler /#
_connectionEventHandler0 G
;G H
public 
AccountService 
( 
IPlayerRepository 
playerRepository .
,. /
IProfileRepository 
profileRepository 0
,0 1#
IPlayerScoresRepository #
scoreRepository$ 3
,3 4
ConnectionManager 
connectionManager /
,/ 0"
ConnectionEventHandler ""
connectionEventHandler# 9
)9 :
{ 	
_playerRepository 
= 
playerRepository  0
;0 1
_profileRepository   
=    
profileRepository  ! 2
;  2 3
_scoreRepository!! 
=!! 
scoreRepository!! .
;!!. /
_connectionManager"" 
=""  
connectionManager""! 2
;""2 3#
_connectionEventHandler## #
=##$ %"
connectionEventHandler##& <
;##< =
}$$ 	
public&& 
OperationResponse&&  
Register&&! )
(&&) *
	PlayerDTO&&* 3
player&&4 :
)&&: ;
{'' 	
if** 
(** 
string** 
.** 
IsNullOrWhiteSpace** )
(**) *
player*** 0
.**0 1
Username**1 9
)**9 :
)**: ;
{++ 
return,, 
OperationResponse,, (
.,,( )
Failure,,) 0
(,,0 1
ErrorMessages,,1 >
.,,> ?
InvalidUsername,,? N
),,N O
;,,O P
}-- 
if00 
(00 
string00 
.00 
IsNullOrWhiteSpace00 )
(00) *
player00* 0
.000 1
Email001 6
)006 7
)007 8
{11 
return22 
OperationResponse22 (
.22( )
Failure22) 0
(220 1
ErrorMessages221 >
.22> ?
InvalidEmail22? K
)22K L
;22L M
}33 
if66 
(66 
string66 
.66 
IsNullOrWhiteSpace66 )
(66) *
player66* 0
.660 1
Password661 9
)669 :
)66: ;
{77 
return88 
OperationResponse88 (
.88( )
Failure88) 0
(880 1
ErrorMessages881 >
.88> ?
InvalidPassword88? N
)88N O
;88O P
}99 
try:: 
{;; 
if<< 
(<< 
_playerRepository<< %
.<<% &
GetByUsername<<& 3
(<<3 4
player<<4 :
.<<: ;
Username<<; C
)<<C D
!=<<E G
null<<H L
)<<L M
{== 
return>> 
OperationResponse>> ,
.>>, -
Failure>>- 4
(>>4 5
ErrorMessages>>5 B
.>>B C
DuplicateUsername>>C T
)>>T U
;>>U V
}?? 
ifAA 
(AA 
_playerRepositoryAA %
.AA% &

GetByEmailAA& 0
(AA0 1
playerAA1 7
.AA7 8
EmailAA8 =
)AA= >
!=AA? A
nullAAB F
)AAF G
{BB 
returnCC 
OperationResponseCC ,
.CC, -
FailureCC- 4
(CC4 5
ErrorMessagesCC5 B
.CCB C
DuplicateEmailCCC Q
)CCQ R
;CCR S
}DD 
stringFF 
passwordHashFF #
=FF$ %
PasswordHelperFF& 4
.FF4 5
HashPasswordFF5 A
(FFA B
playerFFB H
.FFH I
PasswordFFI Q
)FFQ R
;FFR S
varHH 
playerEntityHH  
=HH! "
EntityFactoryHH# 0
.HH0 1
CreatePlayerEntityHH1 C
(HHC D
playerHHD J
,HHJ K
passwordHashHHL X
)HHX Y
;HHY Z
varII 
profileEntityII !
=II" #
EntityFactoryII$ 1
.II1 2
CreateProfileEntityII2 E
(IIE F
playerEntityIIF R
.IIR S
PlayerIDIIS [
)II[ \
;II\ ]
varJJ 
playerScoresEntityJJ &
=JJ' (
EntityFactoryJJ) 6
.JJ6 7$
CreatePlayerScoresEntityJJ7 O
(JJO P
playerEntityJJP \
.JJ\ ]
PlayerIDJJ] e
)JJe f
;JJf g
_playerRepositoryLL !
.LL! "
AddLL" %
(LL% &
playerEntityLL& 2
)LL2 3
;LL3 4
_profileRepositoryMM "
.MM" #
AddMM# &
(MM& '
profileEntityMM' 4
)MM4 5
;MM5 6
_scoreRepositoryNN  
.NN  !
AddNN! $
(NN$ %
playerScoresEntityNN% 7
)NN7 8
;NN8 9
_playerRepositoryPP !
.PP! "
SavePP" &
(PP& '
)PP' (
;PP( )
_profileRepositoryQQ "
.QQ" #
SaveQQ# '
(QQ' (
)QQ( )
;QQ) *
_scoreRepositoryRR  
.RR  !
SaveRR! %
(RR% &
)RR& '
;RR' (
returnTT 
OperationResponseTT (
.TT( )
SuccessResultTT) 6
(TT6 7
)TT7 8
;TT8 9
}UU 
catchVV 
(VV 
SqlExceptionVV 
exVV  "
)VV" #
{WW 
stringXX 
errorMessageXX #
=XX$ %
SqlErrorHandlerXX& 5
.XX5 6
GetErrorMessageXX6 E
(XXE F
exXXF H
)XXH I
;XXI J
returnYY 
OperationResponseYY (
.YY( )
FailureYY) 0
(YY0 1
errorMessageYY1 =
)YY= >
;YY> ?
}ZZ 
catch[[ 
([[ 
	Exception[[ 
ex[[ 
)[[  
{\\ 
CustomLogger]] 
.]] 
Fatal]] "
(]]" #
$str]]# I
,]]I J
ex]]K M
)]]M N
;]]N O
return^^ 
OperationResponse^^ (
.^^( )
Failure^^) 0
(^^0 1
ErrorMessages^^1 >
.^^> ?
GeneralException^^? O
)^^O P
;^^P Q
}__ 
}`` 	
publicbb 
OperationResponsebb  
Loginbb! &
(bb& '
stringbb' -
usernamebb. 6
,bb6 7
stringbb8 >
passwordbb? G
)bbG H
{cc 	
ifdd 
(dd 
stringdd 
.dd 
IsNullOrWhiteSpacedd )
(dd) *
usernamedd* 2
)dd2 3
)dd3 4
{ee 
returnff 
OperationResponseff (
.ff( )
Failureff) 0
(ff0 1
ErrorMessagesff1 >
.ff> ?
InvalidUsernameff? N
)ffN O
;ffO P
}gg 
ifii 
(ii 
stringii 
.ii 
IsNullOrWhiteSpaceii )
(ii) *
passwordii* 2
)ii2 3
)ii3 4
{jj 
returnkk 
OperationResponsekk (
.kk( )
Failurekk) 0
(kk0 1
ErrorMessageskk1 >
.kk> ?
InvalidPasswordkk? N
)kkN O
;kkO P
}ll 
ifnn 
(nn 
_connectionManagernn "
.nn" #
IsUserRegisterednn# 3
(nn3 4
usernamenn4 <
)nn< =
)nn= >
{oo 
returnpp 
OperationResponsepp (
.pp( )
Failurepp) 0
(pp0 1
ErrorMessagespp1 >
.pp> ? 
UserAlreadyConnectedpp? S
)ppS T
;ppT U
}qq 
tryrr 
{ss 
vartt 
playertt 
=tt 
_playerRepositorytt .
.tt. /
GetByUsernamett/ <
(tt< =
usernamett= E
)ttE F
;ttF G
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
}xx 
boolzz 
isPasswordValidzz $
=zz% &
PasswordHelperzz' 5
.zz5 6
VerifyPasswordzz6 D
(zzD E
passwordzzE M
,zzM N
playerzzO U
.zzU V
PasswordHashzzV b
)zzb c
;zzc d
if|| 
(|| 
!|| 
isPasswordValid|| $
)||$ %
{}} 
return~~ 
OperationResponse~~ ,
.~~, -
Failure~~- 4
(~~4 5
ErrorMessages~~5 B
.~~B C
InvalidPassword~~C R
)~~R S
;~~S T
} 
if
ÅÅ 
(
ÅÅ 
OperationContext
ÅÅ $
.
ÅÅ$ %
Current
ÅÅ% ,
?
ÅÅ, -
.
ÅÅ- .
Channel
ÅÅ. 5
is
ÅÅ6 8
IContextChannel
ÅÅ9 H
channel
ÅÅI P
)
ÅÅP Q
{
ÇÇ 
bool
ÉÉ 

registered
ÉÉ #
=
ÉÉ$ % 
_connectionManager
ÉÉ& 8
.
ÉÉ8 9
RegisterUser
ÉÉ9 E
(
ÉÉE F
username
ÉÉF N
,
ÉÉN O
channel
ÉÉP W
)
ÉÉW X
;
ÉÉX Y
if
ÑÑ 
(
ÑÑ 
!
ÑÑ 

registered
ÑÑ #
)
ÑÑ# $
{
ÖÖ 
return
ÜÜ 
OperationResponse
ÜÜ 0
.
ÜÜ0 1
Failure
ÜÜ1 8
(
ÜÜ8 9
ErrorMessages
ÜÜ9 F
.
ÜÜF G"
UserAlreadyConnected
ÜÜG [
)
ÜÜ[ \
;
ÜÜ\ ]
}
áá %
_connectionEventHandler
ââ +
.
ââ+ ,#
RegisterChannelEvents
ââ, A
(
ââA B
username
ââB J
,
ââJ K
channel
ââL S
)
ââS T
;
ââT U
}
ää 
return
åå 
OperationResponse
åå (
.
åå( )
SuccessResult
åå) 6
(
åå6 7
)
åå7 8
;
åå8 9
}
çç 
catch
éé 
(
éé 
SqlException
éé 
ex
éé  "
)
éé" #
{
èè 
CustomLogger
êê 
.
êê 
Error
êê "
(
êê" #
$str
êê# ;
,
êê; <
ex
êê= ?
)
êê? @
;
êê@ A
string
ëë 
errorMessage
ëë #
=
ëë$ %
SqlErrorHandler
ëë& 5
.
ëë5 6
GetErrorMessage
ëë6 E
(
ëëE F
ex
ëëF H
)
ëëH I
;
ëëI J
return
íí 
OperationResponse
íí (
.
íí( )
Failure
íí) 0
(
íí0 1
errorMessage
íí1 =
)
íí= >
;
íí> ?
}
ìì 
catch
îî 
(
îî 
	Exception
îî 
ex
îî 
)
îî  
{
ïï 
CustomLogger
ññ 
.
ññ 
Error
ññ "
(
ññ" #
$str
ññ# B
,
ññB C
ex
ññD F
)
ññF G
;
ññG H
return
óó 
OperationResponse
óó (
.
óó( )
Failure
óó) 0
(
óó0 1
ErrorMessages
óó1 >
.
óó> ?
GeneralException
óó? O
)
óóO P
;
óóP Q
}
òò 
}
ôô 	
public
õõ 
OperationResponse
õõ  
Logout
õõ! '
(
õõ' (
string
õõ( .
username
õõ/ 7
)
õõ7 8
{
úú 	
if
ùù 
(
ùù  
_connectionManager
ùù "
.
ùù" #
IsUserRegistered
ùù# 3
(
ùù3 4
username
ùù4 <
)
ùù< =
)
ùù= >
{
ûû %
_connectionEventHandler
üü '
.
üü' (!
HandleDisconnection
üü( ;
(
üü; <
username
üü< D
)
üüD E
;
üüE F 
_connectionManager
†† "
.
††" #
UnregisterUser
††# 1
(
††1 2
username
††2 :
)
††: ;
;
††; <
return
°° 
OperationResponse
°° (
.
°°( )
SuccessResult
°°) 6
(
°°6 7
)
°°7 8
;
°°8 9
}
¢¢ 
else
££ 
{
§§ 
return
•• 
OperationResponse
•• (
.
••( )
Failure
••) 0
(
••0 1
ErrorMessages
••1 >
.
••> ?
UserNotConnected
••? O
)
••O P
;
••P Q
}
¶¶ 
}
ßß 	
}
®® 
}©© °
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
}__ œS
bC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Entities\GameSession.cs
	namespace 	
Service
 
. 
Entities 
{		 
public

 

class

 
GameSession

 
{ 
private 
readonly  
ConcurrentDictionary -
<- .
string. 4
,4 5
IGameCallback6 C
>C D!
_gameCallbackChannelsE Z
=[ \
new] ` 
ConcurrentDictionarya u
<u v
stringv |
,| }
IGameCallback	~ ã
>
ã å
(
å ç
)
ç é
;
é è
private 
readonly 
HashSet  
<  !
string! '
>' (
_readyPlayers) 6
=7 8
new9 <
HashSet= D
<D E
stringE K
>K L
(L M
)M N
;N O
private 
readonly 
List 
< 
string $
>$ %
_players& .
=/ 0
new1 4
List5 9
<9 :
string: @
>@ A
(A B
)B C
;C D
private 
int 
_currentTurnIndex %
=& '
$num( )
;) *
public 
void 
	AddPlayer 
( 
string $
player% +
)+ ,
{ 	
if 
( 
_players 
. 
Contains !
(! "
player" (
)( )
)) *
{ 
throw 
new %
InvalidOperationException 3
(3 4
$"4 6
$str6 =
{= >
player> D
}D E
$strE `
"` a
)a b
;b c
} 
_players 
. 
Add 
( 
player 
)  
;  !
} 	
public 
void 
RegisterCallback $
($ %
string% +
player, 2
,2 3
IGameCallback4 A
callbackB J
)J K
{ 	
if 
( 
! 
_players 
. 
Contains "
(" #
player# )
)) *
)* +
{ 
throw   
new   %
InvalidOperationException   3
(  3 4
$"  4 6
$str  6 =
{  = >
player  > D
}  D E
$str  E b
"  b c
)  c d
;  d e
}!! !
_gameCallbackChannels## !
[##! "
player##" (
]##( )
=##* +
callback##, 4
;##4 5
}$$ 	
public&& 
void&& 
MarkPlayerReady&& #
(&&# $
string&&$ *
player&&+ 1
)&&1 2
{'' 	
if(( 
((( 
!(( 
_players(( 
.(( 
Contains(( "
(((" #
player((# )
)(() *
)((* +
{)) 
throw** 
new** %
InvalidOperationException** 3
(**3 4
$"**4 6
$str**6 =
{**= >
player**> D
}**D E
$str**E b
"**b c
)**c d
;**d e
}++ 
_readyPlayers-- 
.-- 
Add-- 
(-- 
player-- $
)--$ %
;--% &
}.. 	
public00 
bool00 
IsPlayerReady00 !
(00! "
string00" (
player00) /
)00/ 0
{11 	
return22 
_readyPlayers22  
.22  !
Contains22! )
(22) *
player22* 0
)220 1
;221 2
}33 	
public55 
bool55 
AreAllPlayersReady55 &
(55& '
)55' (
{66 	
return77 
_players77 
.77 
Count77 !
>77" #
$num77$ %
&&77& (
_readyPlayers77) 6
.776 7
Count777 <
==77= ?
_players77@ H
.77H I
Count77I N
;77N O
}88 	
public:: 
IEnumerable:: 
<:: 
string:: !
>::! "

GetPlayers::# -
(::- .
)::. /
{;; 	
return<< 
_players<< 
;<< 
}== 	
public?? 
IEnumerable?? 
<?? 
string?? !
>??! "
GetReadyPlayers??# 2
(??2 3
)??3 4
{@@ 	
returnAA 
_readyPlayersAA  
;AA  !
}BB 	
publicDD 
voidDD 
NotifyGameStartedDD %
(DD% &
)DD& '
{EE 	
foreachFF 
(FF 
varFF 
callbackFF !
inFF" $!
_gameCallbackChannelsFF% :
.FF: ;
ValuesFF; A
)FFA B
{GG 
callbackHH 
?HH 
.HH 
OnGameStartedHH '
(HH' (
)HH( )
;HH) *
}II 
}JJ 	
publicMM 
IEnumerableMM 
<MM 
IGameCallbackMM (
>MM( )
GetCallbacksMM* 6
(MM6 7
)MM7 8
{NN 	
returnOO !
_gameCallbackChannelsOO (
.OO( )
ValuesOO) /
;OO/ 0
}PP 	
publicRR 
boolRR 
TryGetCallbackRR "
(RR" #
stringRR# )
playerRR* 0
,RR0 1
outRR2 5
IGameCallbackRR6 C
callbackRRD L
)RRL M
{SS 	
returnTT !
_gameCallbackChannelsTT (
.TT( )
TryGetValueTT) 4
(TT4 5
playerTT5 ;
,TT; <
outTT= @
callbackTTA I
)TTI J
;TTJ K
}UU 	
publicWW 
voidWW 
RemoveCallbackWW "
(WW" #
stringWW# )
playerWW* 0
)WW0 1
{XX 	!
_gameCallbackChannelsYY !
.YY! "
	TryRemoveYY" +
(YY+ ,
playerYY, 2
,YY2 3
outYY4 7
_YY8 9
)YY9 :
;YY: ;
}ZZ 	
public\\ 
string\\ 
GetOpponent\\ !
(\\! "
string\\" (
player\\) /
)\\/ 0
{]] 	
return^^ 
_players^^ 
.^^ 
FirstOrDefault^^ *
(^^* +
p^^+ ,
=>^^- /
p^^0 1
!=^^2 4
player^^5 ;
)^^; <
;^^< =
}__ 	
publicaa 
stringaa 
GetCurrentPlayeraa &
(aa& '
)aa' (
{bb 	
returncc 
_playerscc 
[cc 
_currentTurnIndexcc -
]cc- .
;cc. /
}dd 	
publicff 
voidff 

RotateTurnff 
(ff 
)ff  
{gg 	
varhh 
previousPlayerhh 
=hh  
_playershh! )
[hh) *
(hh* +
_currentTurnIndexhh+ <
-hh= >
$numhh? @
+hhA B
_playershhC K
.hhK L
CounthhL Q
)hhQ R
%hhS T
_playershhU ]
.hh] ^
Counthh^ c
]hhc d
;hhd e
Consoleii 
.ii 
	WriteLineii 
(ii 
$"ii  
$strii  .
{ii. /
previousPlayerii/ =
}ii= >
$strii> U
"iiU V
)iiV W
;iiW X
ifkk 
(kk !
_gameCallbackChannelskk %
.kk% &
TryGetValuekk& 1
(kk1 2
previousPlayerkk2 @
,kk@ A
outkkB E
varkkF I
previousCallbackkkJ Z
)kkZ [
)kk[ \
{ll 
_mm 
=mm 
Taskmm 
.mm 
Runmm 
(mm 
asyncmm "
(mm# $
)mm$ %
=>mm& (
{nn 
tryoo 
{pp 
awaitqq 
previousCallbackqq .
.qq. /
OnTurnChangedAsyncqq/ A
(qqA B
falseqqB G
)qqG H
;qqH I
}rr 
catchss 
(ss 
	Exceptionss $
exss% '
)ss' (
{tt 
Consoleuu 
.uu  
	WriteLineuu  )
(uu) *
$"uu* ,
$struu, A
{uuA B
previousPlayeruuB P
}uuP Q
$struuQ S
{uuS T
exuuT V
.uuV W
MessageuuW ^
}uu^ _
"uu_ `
)uu` a
;uua b
}vv 
}ww 
)ww 
;ww 
}xx 
_currentTurnIndexzz 
=zz 
(zz  !
_currentTurnIndexzz! 2
+zz3 4
$numzz5 6
)zz6 7
%zz8 9
_playerszz: B
.zzB C
CountzzC H
;zzH I
string{{ 
currentPlayer{{  
={{! "
GetCurrentPlayer{{# 3
({{3 4
){{4 5
;{{5 6
Console}} 
.}} 
	WriteLine}} 
(}} 
$"}}  
$str}}  /
{}}/ 0
currentPlayer}}0 =
}}}= >
"}}> ?
)}}? @
;}}@ A
if 
( !
_gameCallbackChannels %
.% &
TryGetValue& 1
(1 2
currentPlayer2 ?
,? @
outA D
varE H
currentCallbackI X
)X Y
)Y Z
{
ÄÄ 
_
ÅÅ 
=
ÅÅ 
Task
ÅÅ 
.
ÅÅ 
Run
ÅÅ 
(
ÅÅ 
async
ÅÅ "
(
ÅÅ# $
)
ÅÅ$ %
=>
ÅÅ& (
{
ÇÇ 
try
ÉÉ 
{
ÑÑ 
await
ÖÖ 
currentCallback
ÖÖ -
.
ÖÖ- . 
OnTurnChangedAsync
ÖÖ. @
(
ÖÖ@ A
true
ÖÖA E
)
ÖÖE F
;
ÖÖF G
}
ÜÜ 
catch
áá 
(
áá 
	Exception
áá $
ex
áá% '
)
áá' (
{
àà 
Console
ââ 
.
ââ  
	WriteLine
ââ  )
(
ââ) *
$"
ââ* ,
$str
ââ, A
{
ââA B
currentPlayer
ââB O
}
ââO P
$str
ââP R
{
ââR S
ex
ââS U
.
ââU V
Message
ââV ]
}
ââ] ^
"
ââ^ _
)
ââ_ `
;
ââ` a
}
ää 
}
ãã 
)
ãã 
;
ãã 
}
åå 
}
éé 	
}
èè 
}êê ≥
mC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Email\Templates\TemplateFactory.cs
	namespace 	
Service
 
. 
Email 
. 
	Templates !
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
TemplateFactory

 '
{ 
public 
static 
( 
string 
Subject %
,% &
string' -
Body. 2
)2 3
GetTemplate4 ?
(? @
EmailDTO@ H
emailDtoI Q
)Q R
{ 	
switch 
( 
emailDto 
. 
	EmailType &
.& '
ToLower' .
(. /
)/ 0
)0 1
{ 
case 
$str %
:% &
return 
( "
ChangePasswordTemplate .
.. /

GetSubject/ 9
(9 :
): ;
,; <"
ChangePasswordTemplate .
.. /
GetBody/ 6
(6 7
emailDto7 ?
.? @
Username@ H
,H I
emailDtoJ R
.R S
VerificationCodeS c
)c d
) 
; 
case 
$str "
:" #
return 
( 
LobbyTemplate %
.% &

GetSubject& 0
(0 1
)1 2
,2 3
LobbyTemplate %
.% &
GetBody& -
(- .
emailDto. 6
)6 7
) 
; 
case 
$str 
: 
return 
( 
$str (
,( )
emailDto  
.  !

CustomBody! +
??, .
$str/ I
)   
;   
default"" 
:"" 
throw## 
new## 
ArgumentException## /
(##/ 0
$str##0 I
)##I J
;##J K
}$$ 
}%% 	
}&& 
}'' ‰
kC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Email\Templates\LobbyTemplate.cs
	namespace 	
Service
 
. 
Email 
. 
	Templates !
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
 
LobbyTemplate

 %
{ 
public 
static 
string 

GetSubject '
(' (
)( )
{ 	
return 
$str $
;$ %
} 	
public 
static 
string 
GetBody $
($ %
EmailDTO% -
emailDTO. 6
)6 7
{8 9
var 
lobbyDetails 
= 
$@" "
$str" 
{ 
emailDTO 
. 
Username %
}% &
$str& >
{> ?
emailDTO? G
.G H
	LobbyHostH Q
}Q R
$strR 
{ 
emailDTO %
.% &
	LobbyName& /
}/ 0
"0 1
;1 2
if 
( 
! 
string 
. 
IsNullOrWhiteSpace *
(* +
emailDTO+ 3
.3 4
LobbyPassword4 A
)A B
)B C
{ 
lobbyDetails 
+= 
$@"  #
$str# 
{ 
emailDTO #
.# $
LobbyPassword$ 1
}1 2
"2 3
;3 4
} 
lobbyDetails 
+= 
$str$ !
;$$! "
return&& 
lobbyDetails&& 
;&&  
}'' 	
}(( 
})) ë
tC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Email\Templates\ChangePasswordTemplate.cs
	namespace 	
Service
 
. 
Email 
. 
	Templates !
{ 
public		 

class		 "
ChangePasswordTemplate		 '
{

 
public 
static 
string 

GetSubject '
(' (
)( )
{ 	
return 
$str /
;/ 0
} 	
public 
static 
string 
GetBody $
($ %
string% +
username, 4
,4 5
string6 <
verificationCode= M
)M N
{ 	
return 
$@" 
$str 
{ 
username 
} 
$str #
{# $
verificationCode$ 4
}4 5
$str5 !
"! "
;" #
} 	
} 
} »
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
} ﬁ
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
} ˘
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
} Ï
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
{ 	
if 
( 
matrix 
== 
null 
) 
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
matrix7 =
)= >
)> ?
;? @
} 
Rows 
= 
matrix 
. 
	GetLength #
(# $
$num$ %
)% &
;& '
Columns 
= 
matrix 
. 
	GetLength &
(& '
$num' (
)( )
;) *
Data 
= 
new 
List 
< 
int 
>  
(  !
)! "
;" #
for!! 
(!! 
int!! 
i!! 
=!! 
$num!! 
;!! 
i!! 
<!! 
Rows!!  $
;!!$ %
i!!& '
++!!' )
)!!) *
{"" 
for## 
(## 
int## 
j## 
=## 
$num## 
;## 
j##  !
<##" #
Columns##$ +
;##+ ,
j##- .
++##. 0
)##0 1
{$$ 
Data%% 
.%% 
Add%% 
(%% 
matrix%% #
[%%# $
i%%$ %
,%%% &
j%%' (
]%%( )
)%%) *
;%%* +
}&& 
}'' 
}(( 	
public** 
int** 
[** 
,** 
]** 
ToMatrix** 
(** 
)**  
{++ 	
int,, 
[,, 
,,, 
],, 
matrix,, 
=,, 
new,, 
int,,  #
[,,# $
Rows,,$ (
,,,( )
Columns,,* 1
],,1 2
;,,2 3
for-- 
(-- 
int-- 
i-- 
=-- 
$num-- 
;-- 
i-- 
<-- 
Rows--  $
;--$ %
i--& '
++--' )
)--) *
{.. 
for// 
(// 
int// 
j// 
=// 
$num// 
;// 
j//  !
<//" #
Columns//$ +
;//+ ,
j//- .
++//. 0
)//0 1
{00 
matrix11 
[11 
i11 
,11 
j11 
]11  
=11! "
Data11# '
[11' (
i11( )
*11* +
Columns11, 3
+114 5
j116 7
]117 8
;118 9
}22 
}33 
return44 
matrix44 
;44 
}55 	
}66 
}77 µ	
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
} ˆ
ZC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\EmailDTO.cs
	namespace 	
Service
 
. 
DTO 
{ 
[ 
DataContract 
] 
public 

class 
EmailDTO 
{ 
[ 	

DataMember	 
] 
public		 
string		 
	Recipient		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
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
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
string 
	EmailType 
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
string 
VerificationCode &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
[ 	

DataMember	 
] 
public 
string 
	LobbyName 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
string 
	LobbyHost 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
string 
LobbyPassword #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
] 
public 
string 

CustomBody  
{! "
get# &
;& '
set( +
;+ ,
}- .
} 
} ı
cC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\DTO\AttackPositionDTO.cs
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
AttackPositionDTO "
{ 
[ 	

DataMember	 
] 
public 
int 
X 
{ 
get 
; 
set 
;  
}! "
[ 	

DataMember	 
] 
public 
int 
Y 
{ 
get 
; 
set 
;  
}! "
} 
} ¶
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
	interface  
IPlayerScoresService )
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
PlayerScoresResponse 
GetScoresByUsername 0
(0 1
string1 7
username8 @
)@ A
;A B
[ 	
OperationContract	 
] 
OperationResponse 
IncrementWins '
(' (
string( .
username/ 7
)7 8
;8 9
[ 	
OperationContract	 
] 
OperationResponse 
IncrementLosses )
() *
string* 0
username1 9
)9 :
;: ;
} 
} ≠
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
},, ¢
kC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IGuestPlayerService.cs
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
IGuestPlayerService (
{ 
[ 	
OperationContract	 
] 
OperationResponse 
RegisterGuestPlayer -
(- .
string. 4
username5 =
)= >
;> ?
[ 	
OperationContract	 
] 
OperationResponse 
LogoutGuestPlayer +
(+ ,
string, 2
username3 ;
); <
;< =
} 
} û
dC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IGameService.cs
	namespace 	
Service
 
. 
	Contracts 
{ 
[		 
ServiceContract		 
(		 
CallbackContract		 %
=		& '
typeof		( .
(		. /
IGameCallback		/ <
)		< =
)		= >
]		> ?
public

 

	interface

 
IGameService

 !
{ 
[ 	
OperationContract	 
] 
OperationResponse 
InitializeGame (
(( )
string) /
lobbyId0 7
,7 8
List9 =
<= >
string> D
>D E
playersF M
)M N
;N O
[ 	
OperationContract	 
] 
Task 
< 
OperationResponse 
>  
MarkPlayerReadyAsync  4
(4 5
string5 ;
lobbyId< C
,C D
stringE K
playerL R
)R S
;S T
[## 	
OperationContract##	 
]## 
Task$$ 
<$$ 
OperationResponse$$ 
>$$ 
StartGameAsync$$  .
($$. /
string$$/ 5
lobbyId$$6 =
)$$= >
;$$> ?
[&& 	
OperationContract&&	 
]&& 
Task'' 
<'' 
OperationResponse'' 
>'' 
AttackAsync''  +
(''+ ,
string'', 2
lobbyId''3 :
,'': ;
string''< B
attacker''C K
,''K L
AttackPositionDTO''M ^
attackPosition''_ m
)''m n
;''n o
})) 
public++ 

	interface++ 
IGameCallback++ "
{,, 
[00 	
OperationContract00	 
(00 
IsOneWay00 #
=00$ %
true00& *
)00* +
]00+ ,
void11 
OnGameStarted11 
(11 
)11 
;11 
[77 	
OperationContract77	 
(77 
IsOneWay77 #
=77$ %
true77& *
)77* +
]77+ ,
void88 
OnPlayerReady88 
(88 
string88 !
player88" (
)88( )
;88) *
[:: 	
OperationContract::	 
(:: 
IsOneWay:: #
=::$ %
true::& *
)::* +
]::+ ,
void;; 
OnAttackReceived;; 
(;; 
AttackPositionDTO;; /
attackPosition;;0 >
);;> ?
;;;? @
[== 	
OperationContract==	 
(== 
IsOneWay== #
===$ %
true==& *
)==* +
]==+ ,
Task>> 
OnTurnChangedAsync>> 
(>>  
bool>>  $
isPlayerTurn>>% 1
)>>1 2
;>>2 3
}@@ 
}AA ‘
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
} º
eC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IEmailService.cs
	namespace 	
Service
 
. 
	Contracts 
{ 
[ 
ServiceContract 
] 
public		 

	interface		 
IEmailService		 "
{

 
[ 	
OperationContract	 
] 
OperationResponse 
	SendEmail #
(# $
EmailDTO$ ,
emailDTO- 5
)5 6
;6 7
} 
} ¡
dC:\Users\neco3\source\repos\RepositorioServidor\BMCServerV2\Server\Service\Contracts\IChatService.cs
	namespace 	
Service
 
. 
	Contracts 
{ 
[ 
ServiceContract 
( 
CallbackContract %
=& '
typeof( .
(. / 
IChatServiceCallback/ C
)C D
)D E
]E F
public 

	interface 
IChatService !
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void		 
SendMessage		 
(		 
string		 
username		  (
,		( )
string		* 0
message		1 8
)		8 9
;		9 :
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
RegisterUser 
( 
string  
username! )
)) *
;* +
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
DisconnectUser 
( 
string "
username# +
)+ ,
;, -
} 
[ 
ServiceContract 
] 
public 

	interface  
IChatServiceCallback )
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
ReceiveMessage 
( 
string "
message# *
)* +
;+ ,
} 
} …
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
} §
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
channel 
. 
Closed 
+= 
( 
sender %
,% &
args' +
)+ ,
=>- /
HandleDisconnection0 C
(C D
usernameD L
)L M
;M N
channel 
. 
Faulted 
+= 
(  
sender  &
,& '
args( ,
), -
=>. 0
HandleDisconnection1 D
(D E
usernameE M
)M N
;N O
} 	
public 
void 
HandleDisconnection '
(' (
string( .
username/ 7
)7 8
{ 	
_connectionManager 
. 
UnregisterUser -
(- .
username. 6
)6 7
;7 8
Console 
. 
	WriteLine 
( 
$"  
$str  %
{% &
username& .
}. /
$str/ W
"W X
)X Y
;Y Z
} 	
} 
} 