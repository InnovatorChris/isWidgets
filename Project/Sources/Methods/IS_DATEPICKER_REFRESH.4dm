//%attributes = {"shared":true}
// IS_DATEPICKER_REFRESH( $name )
#DECLARE($name : Text)
EXECUTE METHOD IN SUBFORM:C1085($name; "IS_DATEPICKER_DO_REFRESH"; *)  // since we are using an object, tell the Attribute we are working on
