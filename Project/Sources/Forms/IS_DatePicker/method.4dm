// IS_DATE_PICKER FORM METHOD
var $curDate : Date  // the current date from the Entity's Attribute (which we are editing)
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
var $ptr_BoundVar : Pointer  // will be NULL if the bound var is an OBJECT. But we need it if the bound var is NOT an object (i.e. a DATE VAR/FIELD)

$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
$ptr_BoundVar:=OBJECT Get pointer:C1124(Object subform container:K67:4)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		// In situations where this is a widget in an input form, the IS_DATEPICKER_INIT is handled in the CONTAINER SCRIPT
		// where this widget is called by the IS_DateEntry widget, the initialization occurs in this ON LOAD form event
		If (Form:C1466.inDateEntry#Null:C1517)  // check for a special 'inDateEntry' flag when called inside IS_DateEntry
			IS_DATEPICKER_DO_INIT("theDate")  // then we need to initialize our structures. The date will be    Form.theDate
			// we need to initialize the control structures because 'On Bound Variable Change' will never occur
			$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
			$obj_FormData.theDate:=Form:C1466.theDate  // we use the date as provided by the Date Entry widget
			IS_DATEPICKER_DO_REFRESH  // configure the calendar, display, etc
			IS_DateButtonsOnOff(True:C214; "Is_DatePicker")  // turn it ON
		End if 
		
	: (Form event code:C388=On Bound Variable Change:K2:52)
		IS_DATEPICKER_DO_REFRESH
		
	: ((Form event code:C388=On Activate:K2:9) | (Form event code:C388=On Deactivate:K2:10))
		IS_DATEPICKER_UPDATEDATE  // ensure the container's date value is correct. Should always be. Will give _msgUpdate event to container object if changed
		
		If (Form event code:C388=On Activate:K2:9)
			IS_DateButtonsOnOff(True:C214; "Is_DatePicker")  // turn it ON
		Else 
			IS_DateButtonsOnOff(False:C215; "Is_DatePicker")  // turn it ON
		End if 
End case 
