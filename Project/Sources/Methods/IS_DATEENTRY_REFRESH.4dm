//%attributes = {"shared":true,"publishedWeb":true,"invisible":true}
// IS_DATEENTRY_REFRESH($name)
#DECLARE($name : Text)
EXECUTE METHOD IN SUBFORM:C1085($name; "IS_DATEENTRY_DO_REFRESH"; *)  // since we are using an object, tell the Attribute we are working on
