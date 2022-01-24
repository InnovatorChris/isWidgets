//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DATEENTRY_DOBUMPER — We use this same item to adjust DAY, MONTH, and YEAR.
// note: This is used by the DateEntry.bumper and can be 'triggered' also by the invisible bumperUp and bumperDown buttons.
var $adjust : Integer
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
var $adjust : Integer  // amount of whatever to adjust by
var $newDate : Date  // used when computing the new day / month / year without affecting $obj_FormData.theDate

$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

If ($obj_FormData.prevBumper=Null:C1517)  // if it is not define yet, define it here. It must be '0' as it would be the first time the ruler is clicked
	$obj_FormData.prevBumper:=0
End if 

$adjust:=Choose:C955($obj_FormData.prevBumper<$obj_FormData.bumper; 1; -1)  // we either go 1 up or 1 down
$obj_FormData.prevBumper:=$obj_FormData.bumper  // update this for comparison on the next ruler press


/* We want the subform container to be advised of changes 'live', so we must avoid setting $obj_FormData.theDate in this method
Instead, we do our computation using a copy (to set the Day, month, year) and then call IS_DATEENTRY_UPDATEDATE( ) which will tell
the container object of any changes*/
If ($obj_FormData.theGuy=Null:C1517)  // if there is no 'theGuy' attribute, make one. This will happen when first working, and no D/M/Y has gotten focus
	$obj_FormData.theGuy:="theDay"
End if 
If ($obj_FormData.theGuy="")  // if there is no 'guy' then default it to 'theDay'. This will happen if the widget gets 'focus' but no attribute is selected for input
	$obj_FormData.theGuy:="theDay"
End if 
$newDate:=$obj_FormData.theDate  // this will make it easier to add day / month / year
Case of 
	: ($obj_FormData.theGuy="theYear")
		$newDate:=Add to date:C393($newDate; $adjust; 0; 0)
		
	: ($obj_FormData.theGuy="theMonth")
		$newDate:=Add to date:C393($newDate; 0; $adjust; 0)
		
	: ($obj_FormData.theGuy="theDay")
		$newDate:=Add to date:C393($newDate; 0; 0; $adjust)
		
End case 

$obj_FormData.ptr_Day->:=Day of:C23($newDate)
$obj_FormData.ptr_Month->:=Month of:C24($newDate)
$obj_FormData.ptr_Year->:=Year of:C25($newDate)

IS_DATEENTRY_UPDATEDATE  // update the .theDate, the display, and inform the CONTAINER OBJECT of any changes
