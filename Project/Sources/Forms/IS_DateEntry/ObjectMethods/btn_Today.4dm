// btn_Today — set the date to TODAY
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget

$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
$obj_FormData.ptr_Day->:=Day of:C23(Current date:C33)
$obj_FormData.ptr_Month->:=Month of:C24(Current date:C33)
$obj_FormData.ptr_Year->:=Year of:C25(Current date:C33)
IS_DATEENTRY_UPDATEDATE  // update the .theDate, the display, and inform the CONTAINER OBJECT of any changes
