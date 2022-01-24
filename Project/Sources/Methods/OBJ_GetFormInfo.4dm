//%attributes = {"invisible":true,"publishedWeb":true,"shared":true}
// OBJ_GetFormInfo ( { FormName } ) --> FormInfo OBJ   .width  .height  .numPages  .fixedWidth  .fixedHeight  .title
var $1; $formName : Text  // Form Name
var $0; $obj_Result : Object  // the resulting object.   has  .width  .height  .numPages  .fixedWidth  .fixedHeight  .title

If (Storage:C1525.localForms[$1]#Null:C1517)  // if the form is a LOCAL one
	$0:=FO_Get(_FO_Properties; $1)
Else   // it is a form in the Main DB
	EXECUTE METHOD:C1007("FO_Get"; $obj_Result; _FO_Properties; $1)  // get the PROPERTIES object for this form. It actually happens in the Main DB
	$0:=$obj_Result  // return it!
End if 
