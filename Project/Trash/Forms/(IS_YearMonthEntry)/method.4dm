// SCRIPT: IS_YearMonthEntry.Form Method
//$theVarPtr:=OBJECT Get pointer(Object subform container)
C_LONGINT:C283($curYM)  // the current YM from the Entity's Attribute (which we are editing)

C_OBJECT:C1216($obj_FormData)  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

C_POINTER:C301($ptr_BoundVar)  // will be NULL if the bound var is an OBJECT. But we need it if the bound var is NOT an object (i.e. a YM VAR/FIELD)
$ptr_BoundVar:=OBJECT Get pointer:C1124(Object subform container:K67:4)

Case of 
	: (Form event code:C388=On Load:K2:1)  // create our process variable object to store the values we need
		
	: (Form event code:C388=On Bound Variable Change:K2:52)
		$obj_curYM:=IS_YearMonthEntry_GetContainer  // get the container's YM value (works if object attribute or a Longint variable)
		If ($obj_curYM.theYM#$obj_FormData.theYM)  // only update if it has actually changed. We don't want to trigger needless saves of the entity
			$obj_FormData.theYM:=$obj_curYM.theYM  // this is the YM read from either the object attribute or the standard 'variable' bound var
			$obj_FormData.ptr_Month->:=$obj_curYM.theMonth  // load the input areas according to correct values from theYM
			$obj_FormData.ptr_Year->:=$obj_curYM.theYear
		End if 
		
	: (Form event code:C388=On Activate:K2:9)  // we define this collection HERE rather than in on Load because that fails (object FORM does not exist yet) 
		OBJECT SET VISIBLE:C603(*; "FocusRing"; True:C214)
		OBJECT SET VISIBLE:C603(*; "TinyCalendar"; True:C214)
		// we do this YM stuff in case for some reason we failed to get the memo on an update...
		$obj_curYM:=IS_YearMonthEntry_GetContainer  // get the container's YM value (works if object attribute or a Longint variable)
		If ($obj_curYM.theYM#$obj_FormData.theYM)  // only update if it has actually changed. We don't want to trigger needless saves of the entity
			$obj_FormData.theYM:=$obj_curYM.theYM  // this is the YM read from either the object attribute or the standard 'variable' bound var
			$obj_FormData.ptr_Month->:=$obj_curYM.theMonth  // load the input areas according to correct values from theYM
			$obj_FormData.ptr_Year->:=$obj_curYM.theYear
		End if 
		
		GOTO OBJECT:C206(*; "theMonth")  // initiate by going into the MONTH slot
		
	: (Form event code:C388=On Deactivate:K2:10)
		OBJECT SET VISIBLE:C603(*; "FocusRing"; False:C215)
		OBJECT SET VISIBLE:C603(*; "TinyCalendar"; False:C215)
		
		IS_YEARMONTHENTRY_UPDATE  // we ensure the data source of the container is updated if changed. Basically, these calls should have happened
		// before the deactivate, but we are just making sure we don't mess up
		
		//// **** HERE WE UPDATE THE DATA SOURCE OF THE CONTAINER IF IT HAS CHANGED ****
		//// we need to handle object-attributes differently from traditional YM variables
		//$obj_curYM:=IS_YearMonthEntry_GetContainer  // get the container's YM (works if object attribute or a YM variable)
		//If ($obj_FormData.theYM#$obj_curYM.theYM)  // if the WIDGET YM is different from the CONTAINER's YM...we need to update it
		//If ($obj_FormData.isBoundToObject)  // handle updating to a bound OBJECT's attribute...
		//Form[$obj_FormData.sourceAttr]:=$obj_FormData.theYM  // copy the result to the bound Object's YM Attribute we were editing
		//Else   // the bound variable is a YM. Update it directly
		//$ptr_BoundVar->:=$obj_FormData.theYM  // copy the result to the bound Object's YM Attribute we were editing
		//End if 
		//End if 
		
		
		
End case 