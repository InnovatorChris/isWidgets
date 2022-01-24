// ACCEPT BUTTON! only really do something if we have been called inside a DateEntry widget to assist
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget

If (Form:C1466.inDateEntry#Null:C1517)  // check for a special 'inDateEntry' flag when called inside IS_DateEntry
	$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
	Form:C1466.theDate:=$obj_FormData.theDate  // copy the result back to the caller
	
	IS_DATEENTRY_UPDATE_DATEDISPLAY  // update the dateDisplay OBJECT
	ACCEPT:C269
	
Else   // within our 'standard' widget, just treat this like a CLICK on the date. Sends a _msgUpdate to the container
	IS_DATEPICKER_UPDATE_DISPLAY  // update the display to match!
	IS_DATEPICKER_UPDATEDATE  // ensure the container's date value is correct. Should always be. Will give _msgUpdate event to container object if changed
End if 