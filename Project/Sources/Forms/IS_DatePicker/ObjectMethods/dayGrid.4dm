// SCRIPT: IS_DatePicker.dayGrid
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
var $chosen : Integer  // the GRID BUTTON value now since the click happened

$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
$chosen:=Self:C308->  // this is the current choice
$obj_FormData.theDate:=$obj_FormData.firstDate+$chosen-1  // figure out the date chosen and update it

IS_DATEPICKER_UPDATE_DISPLAY  // update the display to match!
IS_DATEPICKER_UPDATEDATE  // ensure the container's date value is correct. Should always be. Will give _msgUpdate event to container object if changed
