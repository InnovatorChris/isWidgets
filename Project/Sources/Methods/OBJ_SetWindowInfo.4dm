//%attributes = {"invisible":true,"publishedWeb":true}
// OBJ_SetWindowInfo ( WIndowInfoOBJ ) -->   //   .left  .top  .right  .bottom  .title  .kind  .process  .winRef
var $1 : Object  // the WindowInfoOBJ
var $winRef : Integer
var $title : Text

$winRef:=Choose:C955($1.winRef#Null:C1517; $1.winRef; Frontmost window:C447)  // determine what winRef we are dealing with
$winRef:=Choose:C955($winRef=0; Frontmost window:C447; $winRef)  // trap out in case caller supplied  .winRef=0; change it to Frontmost Window

SET WINDOW RECT:C444($1.left; $1.top; $1.right; $1.bottom; $winRef)  // set the window rect
$title:=Choose:C955($1.title#Null:C1517; $1.title; "")  // if .title is given, then use it; otherwise blank
If ($title#"")
	SET WINDOW TITLE:C213($title; $winRef)  // we assume that if .title is blank, we are not to change the title
End if 
