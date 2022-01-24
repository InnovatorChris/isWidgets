//%attributes = {"invisible":true,"publishedWeb":true,"shared":true}
// OBJ_GetWindowInfo ( { WinRef } ) --> WIndowInfo OBJ   .left  .top  .right  .bottom  .title  .kind  .process
var $1 : Integer  // the WindowRef (if given)
var $0 : Object  // the resulting object.   has  .left  .top  .right  .bottom
var $T; $L; $B; $R; $kind; $processID : Integer
var $kind; $winRef : Integer
var $title : Text

If (Count parameters:C259>0)  // did they give a WinRef?
	GET WINDOW RECT:C443($L; $T; $R; $B; $1)
	$title:=Get window title:C450($1)
	$kind:=Window kind:C445($1)
	$processID:=Window process:C446($1)
	$winRef:=$1
Else 
	GET WINDOW RECT:C443($L; $T; $R; $B)  // frontmost window
	$title:=Get window title:C450
	$kind:=Window kind:C445
	$processID:=Window process:C446
	$winRef:=Frontmost window:C447
End if 

$0:=New object:C1471("left"; $L; "top"; $T; "right"; $R; "bottom"; $B; "title"; $title; "kind"; $kind; "process"; $processID; "winRef"; $winRef)
$0.height:=$0.bottom-$0.top
$0.width:=$0.right-$0.left

