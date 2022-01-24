// IS_DateEntry (Colonel)
//$theVarPtr:=OBJECT Get pointer(Object subform container)
var $curDate : Date  // the current date from the Entity's Attribute (which we are editing)
var $ptr_BoundVar : Pointer
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
var $ptr_BoundVar : Pointer  // will be NULL if the bound var is an OBJECT. But we need it if the bound var is NOT an object (i.e. a DATE VAR/FIELD)

If (IS_DateEntryIsInitialized)  // Confirm that this object exists; otherwise we have not had IS_DATEENTRY_INIT() successfully called and doing anything could explode the code —— CB 05/10/20
	
	$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
	$ptr_BoundVar:=OBJECT Get pointer:C1124(Object subform container:K67:4)
	
	Case of 
		: (Form event code:C388=On Load:K2:1)  // create our process variable object to store the values we need
			
		: (Form event code:C388=On Bound Variable Change:K2:52)
			IS_DATEENTRY_DO_REFRESH  // refresh the DISPLAY of the DD/MM/YY
			
		: (Form event code:C388=On Activate:K2:9)  // we define this collection HERE rather than in on Load because that fails (object FORM does not exist yet) 
			OBJECT SET VISIBLE:C603(*; "FocusRing"; True:C214)
			//OBJECT SET VISIBLE(*;"TinyCalendar";True)
			OBJECT SET VISIBLE:C603(*; "theMonth"; True:C214)  // show the MONTH, DAY, YEAR entry areas
			OBJECT SET VISIBLE:C603(*; "theDay"; True:C214)
			OBJECT SET VISIBLE:C603(*; "theYear"; True:C214)
			OBJECT SET VISIBLE:C603(*; "Slash@"; True:C214)  // and the SLASHES
			OBJECT SET VISIBLE:C603(*; "dateDisplay"; False:C215)  // hide the dateDisplay
			OBJECT SET ENABLED:C1123(*; "btn_OK"; True:C214)  // allow the OK button to work, which allows user to <CR> out of this area
			OBJECT SET VISIBLE:C603(*; "btn_OK"; True:C214)  // allow the OK button to work, which allows user to <CR> out of this area
			OBJECT SET VISIBLE:C603(*; "btn_Today"; True:C214)  // allow the OK button to work, which allows user to set the date to TODAY
			OBJECT SET ENABLED:C1123(*; "btn_Today"; True:C214)  // activate the TODAY button, which sets the date to TODAY. 'T' triggers it
			
			IS_DateButtonsOnOff(True:C214; "Is_DateEntry")  // turn it ON
			
			// we do this date stuff in case for some reason we failed to get the memo on an update...
			IS_DATEENTRY_DO_REFRESH  // refresh the DISPLAY of the DD/MM/YY
			
			//GOTO OBJECT(*; "theMonth")  // initiate by going into the MONTH slot
			//HIGHLIGHT TEXT(*; "theMonth"; 1; 10)  // highlight the text for immediately replacement
			EDIT ITEM:C870(*; "theMonth")  // initiate by going into the MONTH slot
			
		: (Form event code:C388=On Deactivate:K2:10)
			OBJECT SET VISIBLE:C603(*; "FocusRing"; False:C215)
			//OBJECT SET VISIBLE(*;"TinyCalendar";False)
			OBJECT SET VISIBLE:C603(*; "theMonth"; False:C215)  // hide the MONTH, DAY, YEAR entry areas
			OBJECT SET VISIBLE:C603(*; "theDay"; False:C215)
			OBJECT SET VISIBLE:C603(*; "theYear"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Slash@"; False:C215)  // and hide the SLASHES
			OBJECT SET VISIBLE:C603(*; "dateDisplay"; True:C214)  // show the dateDisplay
			OBJECT SET ENABLED:C1123(*; "btn_OK"; False:C215)  // deactivate the OK button, which allows user to <CR> out of this area
			OBJECT SET VISIBLE:C603(*; "btn_OK"; False:C215)  // deactivate the OK button, which allows user to <CR> out of this area
			OBJECT SET ENABLED:C1123(*; "btn_Today"; False:C215)  // deactivate the TODAY button, which sets the date to TODAY
			IS_DateButtonsOnOff(False:C215; "Is_DateEntry")  // turn it OFF
			
			// **** HERE WE UPDATE THE DATA SOURCE OF THE CONTAINER IF IT HAS CHANGED ****
			// we need to handle object-attributes differently from traditional date variables
			$curDate:=IS_DateEntry_GetContainerDate  // get the container's date (works if object attribute or a Date variable)
			If ($obj_FormData.theDate#IS_DateEntry_GetContainerDate)  // if the WIDGET DATE is different from the CONTAINER's DATE...we need to update it
				If ($obj_FormData.isBoundToObject)  // handle updating to a bound OBJECT's attribute...
					Form:C1466[$obj_FormData.sourceAttr]:=$obj_FormData.theDate  // copy the result to the bound Object's DATE Attribute we were editing
				Else   // the bound variable is a DATE. Update it directly
					$ptr_BoundVar->:=$obj_FormData.theDate  // copy the result to the bound Object's DATE Attribute we were editing
				End if 
			End if 
			
		: (Form event code:C388=On Losing Focus:K2:8)
			If (Bool:C1537($obj_FormData.datePickerChangedDate))  // date picker changed the date; tell the caller
				OB REMOVE:C1226($obj_FormData; "datePickerChangedDate")  // clear it so it does not linger
				CALL SUBFORM CONTAINER:C1086(_msgUpdate)  // tell the container that we have updated the date
			End if 
	End case 
	
End if   // Is_DateEntryIsInitialized() —— CB 05/10/20
