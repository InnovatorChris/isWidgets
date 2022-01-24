// SCRIPT: bumperDown — this helps the Form.bumper object. It allows us to use a up/down shortcut to control the bumper
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget

$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
$obj_FormData.bumper:=$obj_FormData.bumper-1  // we are bumping up a day/month/year
IS_DateEntry_doBumper  // this manages the date-picker 'bumper' object
