//%attributes = {"invisible":true,"publishedWeb":true}
// IS_YearMonthEntry_GetContainer —— get the current YM value of the bound variable
var $0 : Object  // the YM value from the CONTAINER, but made into an object with attributes:  .ym  .year  .month
var $yearMM; $year; $month : Integer

var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

If ($obj_FormData.isBoundToObject)
	$yearMM:=Form:C1466[$obj_FormData.sourceAttr]
Else 
	$yearMM:=OBJECT Get pointer:C1124(Object subform container:K67:4)->  // this should be the date variable / field this is bound to
End if 

$year:=Int:C8($yearMM/100)
$month:=$yearMM%100

$0:=New object:C1471("theYM"; $yearMM; "theYear"; $year; "theMonth"; $month)
