//%attributes = {"shared":true,"publishedWeb":true,"invisible":true}
// IS_DATEENTRY_INIT ( AttributeName; nextEntryObject; Placeholder Text ) --> Handle the initialization of this input area —— NOTE: This executes in the PARENT PROJECT
#DECLARE($attributeName : Text; $nextEntryObject : Text; $placeHolder : Text)  // name of the object attribute; use _Blank if this is for a variable, placeholder text to use
If ($nextEntryObject=_Blank)
	$nextEntryObject:=FORM_GetNextEntryObjName
End if 
EXECUTE METHOD IN SUBFORM:C1085(OBJECT Get name:C1087; "IS_DATEENTRY_DO_INIT"; *; $attributeName; $nextEntryObject; $placeHolder)  // since we are using an object, tell the Attribute we are working on
