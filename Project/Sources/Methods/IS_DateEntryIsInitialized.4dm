//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DateEntryIsInitialized ( ) —> BOOLEAN.  TRUE if the dateentry widget has been initialized
var $0 : Boolean  // RESULT. Defaults to FALSE
var $formObj : Object
var $formObjPtr : Pointer  // we need this to check if the "formData" is null. It will be all the time when this is called, actually
$formObjPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")  // this is the object on the form where we are storing the 'form data'
If ($formObjPtr->#Null:C1517)  // does the "formData" object exist?  // [CB 05/18/2021] — removal of 'Undefined' from code
	$formObj:=$formObjPtr->  // this is the FormInfo object
	$0:=Bool:C1537($formObj.isInit)  // if it is defined, then it will be TRUE, and the result will be true [CB 05/18/2021] — removal of 'Undefined' from code
End if 

