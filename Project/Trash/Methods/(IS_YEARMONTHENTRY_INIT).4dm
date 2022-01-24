//%attributes = {"shared":true,"publishedWeb":true,"invisible":true}
// IS_YEARMONTHENTRY_INIT ( { AttributeName } ; {PlaceHolder text} ) —> BOOLEAN (TRUE if successful) —— NOTE: This executes in the PARENT PROJECT
// this is how we update the value upon exitting. 
// for example, it may be   "formYM"    and it will be used as  "Form[formYM]. This will SET or GET the value from the CONTAINER's OBJECT
var $1 : Text  // the attribute name where the value is stored
var $placeHolder; $nextEnterableObj : Text
If (Count parameters:C259>1)  // given a placeHolder?
	$placeHolder:=$2
End if 
$nextEnterableObj:=FORM_GetNextEntryObjName
EXECUTE METHOD IN SUBFORM:C1085(OBJECT Get name:C1087; "IS_YEARMONTHENTRY_DO_INIT"; *; $1; $nextEnterableObj; $placeHolder)  // since we are using an object, tell the Attribute we are working on
