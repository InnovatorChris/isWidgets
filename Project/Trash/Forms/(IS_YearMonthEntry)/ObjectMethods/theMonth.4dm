// SCRIPT: theMonth
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

Case of 
	: (Form event code:C388=On Getting Focus:K2:7)
		$obj_FormData.theGuy:=OBJECT Get name:C1087(Object with focus:K67:3)
		$obj_FormData.doShowBumper.call()  // show the BUMPER
		
	: (Form event code:C388=On Losing Focus:K2:8)
		$obj_FormData.doHideBumper.call()  // hide the BUMPER
		$obj_FormData.theGuy:=Null:C1517
		
		IS_YEARMONTHENTRY_UPDATE  // update the  $obj_FormData.theYM  based on the component YEAR, MONTH
		
	: (Form event code:C388=On Data Change:K2:15)
		
End case 

