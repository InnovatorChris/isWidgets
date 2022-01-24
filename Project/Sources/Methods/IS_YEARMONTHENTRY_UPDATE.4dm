//%attributes = {"invisible":true,"publishedWeb":true}
// IS_YEARMONTHENTRY_UPDATE ( ) -- used only inside the FORM:  IS_YMEntry
// this will update the $obj_FormData.theYM value depending on the components (MONTH, YEAR)
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget

$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
$obj_FormData.theYM:=(($obj_FormData.ptr_Year->)*100)+($obj_FormData.ptr_Month->)


// we need to handle object-attributes differently from traditional YM variables
$obj_curYM:=IS_YearMonthEntry_GetContainer  // get the container's YM (works if object attribute or a YM variable)
If ($obj_FormData.theYM#$obj_curYM.theYM)  // if the WIDGET YM is different from the CONTAINER's YM...we need to update it
	If ($obj_FormData.isBoundToObject)  // handle updating to a bound OBJECT's attribute...
		Form:C1466[$obj_FormData.sourceAttr]:=$obj_FormData.theYM  // copy the result to the bound Object's YM Attribute we were editing
	Else   // the bound variable is a YM. Update it directly
		$ptr_BoundVar->:=$obj_FormData.theYM  // copy the result to the bound Object's YM Attribute we were editing
	End if 
	CALL SUBFORM CONTAINER:C1086(_msgUpdate)  // tell the container that we have updated the date
End if 



