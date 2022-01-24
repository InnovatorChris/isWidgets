//%attributes = {"publishedWeb":true,"shared":true}
// PopupForm ( FormName; Position; Object ; {windowType} ; {windowTitle}  ) // 
// NOTE: IF $3.position{ } is defined, we use its top / left coordinates (relative to window) to position the popupForm **** —————
var $1 : Text  // name of the FORM to pop up
var $2 : Integer  // the positioning choice relative to the 'owner' window
var $3; $obj_Pos : Object  // object to pass on to the popup form
var $4 : Integer  // window type. If not given, use a pop up window
var $5; $windowTitle : Text  // window title. If not given, it will be blank
var $0 : Boolean  // TRUE if   (OK = 1)
var $formObj : Object  // the WINDOW INFO   &   FORM INFO objects


$windowType:=Pop up form window:K39:11  // default is to use a popup form window. But if they supply the type, use it instead
If (Count parameters:C259>3)
	$windowType:=$4
	If (Count parameters:C259>4)  // if they gave a window title, use it. Otherwise it will be blank
		$windowTitle:=$5
	End if 
End if 

$formObj:=OBJ_GetFormInfo($1)  // .name  .width  .height  .numPages  .fixedWidth  .fixedHeight  .title
If ($3.position#Null:C1517)
	$windowObj:=OBJ_GetWindowInfo  // details about the window, so we can figure out the positioning for the 'pwChooseFieldToInsert' dialog
	$obj_Pos:=New object:C1471("left"; $windowObj.left+$3.position.left; "top"; $windowObj.top+$3.position.top)
Else 
	$obj_Pos:=PopupFormPosition($formObj; $2)  // get the .top & .left for the form
End if 

var $testForm : Integer
$testForm:=Open form window:C675($1; $windowType+Form has no menu bar:K39:18; $obj_Pos.left; $obj_Pos.top)
If ($windowTitle#"")
	SET WINDOW TITLE:C213($5; $testForm)
End if 

If ($1="LB_Decorator")  // special case ... make it its own dialog, which can communicate to the master window
	DIALOG:C40($1; $3; *)
	
Else 
	DIALOG:C40($1; $3)  // open the POPUP FORM, passing along the OBJECT we received from the caller
	CLOSE WINDOW:C154($testForm)  // close the stupid thing
	
	$0:=(OK=1)  // this is the result; if OK=1, we return TRUE, otherwise FALSE.
	// the caller also receives other information returned in the object they gave us, so the popup dialog can put information into that too
End if 