// SCRIPT: rightArrow — this helps the Form.bumper object. It allows us to use a right-right arrow shortcut to control the entry slot
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
var $curObjName : Text

$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
$curObjName:=OBJECT Get name:C1087(Object with focus:K67:3)

Case of 
	: ($curObjName="theMonth")
		GOTO OBJECT:C206(*; "theYear")
End case 