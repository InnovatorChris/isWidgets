//%attributes = {}
// IS_DATEPICKER_DO_REFRESH( )
var $curDate : Date  // the current date from the Entity's Attribute (which we are editing)
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
var $ptr_BoundVar : Pointer  // will be NULL if the bound var is an OBJECT. But we need it if the bound var is NOT an object (i.e. a DATE VAR/FIELD)

$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

$curDate:=IS_DateEntry_GetContainerDate  // get the container's date (works if object attribute or a Date variable)
If ($curDate#$obj_FormData.theDate)  // only update if it has actually changed. We don't want to trigger needless saves of the entity
	$obj_FormData.theDate:=$curDate  // this is the date read from either the object attribute or the standard 'variable' bound var
End if 
IS_DATEPICKER_CONFIG_CALENDAR  // configure the calendar for this date
IS_DATEPICKER_UPDATE_DISPLAY  // update the display now too
IS_DATEENTRY_UPDATE_DATEDISPLAY  // update the dateDisplay OBJECT
