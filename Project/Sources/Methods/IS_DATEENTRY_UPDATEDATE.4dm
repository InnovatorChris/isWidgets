//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DATEENTRY_UPDATEDATE ( ) -- used only inside the FORM:  IS_DateEntry
// this will update the $obj_FormData.theDate value depending on the components (DAY, MONTH, YEAR)
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$ptr_BoundVar:=OBJECT Get pointer:C1124(Object subform container:K67:4)
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

// we are going to try and detect when the date actually is changed, and alert our CONTAINER OBJECT //
var $oldDate : Date
$oldDate:=$obj_FormData.theDate  // compare the 'old date' to what we compute

$obj_FormData.theDate:=Add to date:C393(!00-00-00!; $obj_FormData.ptr_Year->; $obj_FormData.ptr_Month->; $obj_FormData.ptr_Day->)

If ($oldDate#$obj_FormData.theDate)  // a change in the date?
	If ((Year of:C25($obj_FormData.theDate)#0) & (Month of:C24($obj_FormData.theDate)#0) & (Day of:C23($obj_FormData.theDate)#0))  // if it is apparently a valid date
		
		// **** HERE WE UPDATE THE DATA SOURCE OF THE CONTAINER IF IT HAS CHANGED ****
		// we need to handle object-attributes differently from traditional date variables
		$curDate:=IS_DateEntry_GetContainerDate  // get the container's date (works if object attribute or a Date variable)
		If ($obj_FormData.theDate#IS_DateEntry_GetContainerDate)  // if the WIDGET DATE is different from the CONTAINER's DATE...we need to update it
			If ($obj_FormData.isBoundToObject)  // handle updating to a bound OBJECT's attribute...
				Form:C1466[$obj_FormData.sourceAttr]:=$obj_FormData.theDate  // copy the result to the bound Object's DATE Attribute we were editing
			Else   // the bound variable is a DATE. Update it directly
				$ptr_BoundVar->:=$obj_FormData.theDate  // copy the result to the bound Object's DATE Attribute we were editing
			End if 
			CALL SUBFORM CONTAINER:C1086(_msgUpdate)  // tell the container that we have updated the date
		End if 
	End if 
End if 

IS_DATEENTRY_UPDATE_DATEDISPLAY  // update the dateDisplay OBJECT