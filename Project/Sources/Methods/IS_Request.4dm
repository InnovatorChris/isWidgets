//%attributes = {"shared":true,"publishedWeb":true,"invisible":true}
// IS_Request ( Object {; windowTitle }  ) --> Result (boolean) TRUE if they OK'd their answer.
// Object must have .message.  If   .yes is not defined, it will become "OK";  if .no is not defined, it will become "Cancel"
var $1 : Object  // .message   --> .answer
var $0 : Boolean  // the result. This is also returned in $1.result
var $2; $title : Text  // optional: WINDOW TITLE
var $default : Text

If (Count parameters:C259>1)  // if given a window title, use it; otherwise default to 'Message...'
	$title:=$2
Else 
	$title:="Please answer..."
End if 

If (Not:C34(OB Is defined:C1231($1; "answer")))
	$1.answer:=""
End if 

// it is possible that they CANCEL a button, but alter the $1.answer. We want to circumvent that possibility. If they CANCEL, then the .answer must not change
$default:=$1.answer

$0:=PopupForm("IS_Request"; _middleThirdCenter; $1; Modal dialog:K27:2; $title)
If (Not:C34($0))  // if they CANCELLED the request, make the .answer be what the caller provided
	$1.answer:=$default  // revert the ANSWER if they have CANCELLED this dialog
End if 

$1.result:=$0  // we put it into the object too, for simplicity of interpretation by caller