//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DATEENTRY_UPDATE_DATEDISPLAY ( ) — utility for form IS_DateEntry; update the 'Display Date' according to theDate stored in the "FormData" object
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
OBJECT SET VALUE:C1742("dateDisplay"; $obj_FormData.theDate)  // update the dateDisplay!