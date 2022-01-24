//%attributes = {"shared":true,"publishedWeb":true,"invisible":true}
// IS_DATEPICKER_INIT($attributeName)
#DECLARE($attributeName : Text)  // name of the object attribute; use _Blank if this is for a variable, placeholder text to use
EXECUTE METHOD IN SUBFORM:C1085(OBJECT Get name:C1087; "IS_DATEPICKER_DO_INIT"; *; $attributeName)  // since we are using an object, tell the Attribute we are working on
