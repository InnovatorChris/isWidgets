//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DateEntry_GetContainerDate —— get the current date value of the bound variable
var $0 : Date  // the date value from the CONTAINER
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget

If (IS_DateEntryIsInitialized)  // Confirm that this object exists; otherwise we have not had IS_DATEENTRY_INIT() successfully called and doing anything could explode the code —— CB 05/10/20
	$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
	If ($obj_FormData.isBoundToObject)
		$0:=Form:C1466[$obj_FormData.sourceAttr]
	Else 
		$0:=OBJECT Get pointer:C1124(Object subform container:K67:4)->  // this should be the date variable / field this is bound to
	End if 
End if   // Is_DateEntryIsInitialized() —— CB 05/10/20
