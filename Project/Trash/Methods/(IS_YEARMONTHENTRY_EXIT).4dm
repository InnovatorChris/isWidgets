//%attributes = {"invisible":true,"publishedWeb":true}
// IS_YEARMONTHENTRY_EXIT ( ) --> Try to exit to the Next Object on the parent form, if we know it. If we don't, nothing is done
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
If ($obj_FormData.nextObjectName#"")  // if we have been given a 'nextObjectName'
	OBJECT SET ENABLED:C1123(*; "btn_OK"; False:C215)  // deactivate the OK button, which allows user to <CR> out of this area
	OBJECT SET ENABLED:C1123(*; "btn_Today"; False:C215)  // deactivate the TODAY button, which sets the date to TODAY
	CALL SUBFORM CONTAINER:C1086(_msgClose)  // tell the container that we are finished and want to EXIT
	GOTO OBJECT:C206(*; $obj_FormData.nextObjectName)
End if 
