//%attributes = {"invisible":true,"publishedWeb":true}
// IS_YEARMONTHENTRY_DOBUMPER — We use this same item to adjust MONTH and YEAR.
// note: This is used by the IS_YearMonthEntry.bumper and can be 'triggered' also by the invisible bumperUp and bumperDown buttons.
var $adjust : Integer
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

If ($obj_FormData.prevBumper=Null:C1517)  // if it is not define yet, define it here. It must be '0' as it would be the first time the ruler is clicked
	$obj_FormData.prevBumper:=0
End if 

$adjust:=Choose:C955($obj_FormData.prevBumper<$obj_FormData.bumper; 1; -1)  // we either go 1 up or 1 down
$obj_FormData.prevBumper:=$obj_FormData.bumper  // update this for comparison on the next ruler press

Case of 
	: ($obj_FormData.theGuy="theYear")
		$obj_FormData.ptr_Year->:=$obj_FormData.ptr_Year->+$adjust
		
	: ($obj_FormData.theGuy="theMonth")
		$obj_FormData.ptr_Month->:=$obj_FormData.ptr_Month->+$adjust
		$month:=$obj_FormData.ptr_Month->  // we need to handle where they go past month #12 (next year) or month#0 (previous year)
		If ($month<1)  // they went to the previous year?
			$obj_FormData.ptr_Month->:=12
			$obj_FormData.ptr_Year->:=$obj_FormData.ptr_Year->-1
		Else 
			If ($month>12)  // they went to the next year?
				$obj_FormData.ptr_Month->:=1
				$obj_FormData.ptr_Year->:=$obj_FormData.ptr_Year->+1
			End if 
		End if 
		
End case 

IS_YEARMONTHENTRY_UPDATE  // update the  $obj_FormData.theYM  based on the component YEAR, MONTH
