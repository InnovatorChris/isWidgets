// btn_Today — set the date to TODAY
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
$obj_FormData.theDate:=Current date:C33  // user wants to set the date to TODAY
IS_DATEPICKER_CONFIG_CALENDAR  // configure the calendar for this date
IS_DATEPICKER_UPDATE_DISPLAY  // update the display now too
IS_DATEENTRY_UPDATE_DATEDISPLAY  // update the dateDisplay OBJECT
