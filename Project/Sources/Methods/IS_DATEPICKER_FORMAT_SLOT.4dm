//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DATEPICKER_FORMAT_SLOT ( slot# ) 1 to 42
var $1 : Integer
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
var $thisMonth : Integer
var $dayTitle : Text
var $thisDate : Date

$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the storage object (on the widget: formData)

ALERT:C41("This IS_DATEPICKER_FORMAT_SLOT is not used")

$thisMonth:=Month of:C24($obj_FormData.theDate)  // this is the MONTH# of the calendar we are displaying

$dayTitle:="d"+String:C10($1)  // the name of the day TEXT

$thisDate:=$obj_FormData.firstDate+$1-1  // this is the DATE we are setting up
If (Month of:C24($thisDate)=$thisMonth)
	OBJECT SET RGB COLORS:C628(*; $dayTitle; $obj_FormData.defaultForeRGB; $obj_FormData.defaultBackRGB)
Else 
	OBJECT SET RGB COLORS:C628(*; $dayTitle; $obj_FormData.outsideMonthForeRGB; $obj_FormData.outsideMonthBackRGB)
End if 
