//%attributes = {}
// IS_DATEPICKER_UPDATEDATE ( ) -- used only inside the FORM:  IS_DatePicker. Will give container object _msgUpdate event if a change is detected
// this will update the $obj_FormData.theDate value as needed
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$ptr_BoundVar:=OBJECT Get pointer:C1124(Object subform container:K67:4)
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

If ($obj_FormData.theDate#IS_DateEntry_GetContainerDate)  // if the WIDGET DATE is different from the CONTAINER's DATE...we need to update it
	If ($obj_FormData.isBoundToObject)  // handle updating to a bound OBJECT's attribute...
		Form:C1466[$obj_FormData.sourceAttr]:=$obj_FormData.theDate  // copy the result to the bound Object's DATE Attribute we were editing
	Else   // the bound variable is a DATE. Update it directly
		$ptr_BoundVar->:=$obj_FormData.theDate  // copy the result to the bound Object's DATE Attribute we were editing
	End if 
	
	// in special case that  IS_DatePicker has been invoked by the IS_DateEntry, then a single click is good enough to confirm the input to the IS_DateEntry. Save and close
	If (Form:C1466.inDateEntry#Null:C1517)  // check for a special 'inDateEntry' flag when called inside IS_DateEntry
		POST KEY:C465(_uCR)  // this invokes the  'dummyAccept' button — basically, same as hitting the <CR>
	Else   // in our own subform; tell the container a change has been made
		CALL SUBFORM CONTAINER:C1086(_msgUpdate)  // tell the container that we have updated the date
	End if 
	
End if 
