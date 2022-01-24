//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DATEENTRY_DO_REFRESH
var $curDate : Date  // the current date from the Entity's Attribute (which we are editing)
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget

If (IS_DateEntryIsInitialized)  // Confirm that this object exists; otherwise we have not had IS_DATEENTRY_INIT() successfully called and doing anything could explode the code —— CB 05/10/20
	$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
	
	If ($obj_FormData#Null:C1517)  // if it exists ... 
		$curDate:=IS_DateEntry_GetContainerDate  // get the container's date (works if object attribute or a Date variable)
		If ($curDate#$obj_FormData.theDate)  // only update if it has actually changed. We don't want to trigger needless saves of the entity
			$obj_FormData.theDate:=$curDate  // this is the date read from either the object attribute or the standard 'variable' bound var
			$obj_FormData.ptr_Day->:=Day of:C23($obj_FormData.theDate)  // load the input areas according to correct values from theDate
			$obj_FormData.ptr_Month->:=Month of:C24($obj_FormData.theDate)
			$obj_FormData.ptr_Year->:=Year of:C25($obj_FormData.theDate)
			
			IS_DATEENTRY_UPDATE_DATEDISPLAY  // update the dateDisplay OBJECT
		End if 
	End if 
	
End if   // IS_DateEntryIsInitialized( ) —— CB 05/10/20