// SCRIPT: theYear
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

Case of 
	: (Form event code:C388=On Getting Focus:K2:7)
		$obj_FormData.theGuy:=OBJECT Get name:C1087(Object with focus:K67:3)
		$obj_FormData.doShowBumper.call()  // show the BUMPER
		HIGHLIGHT TEXT:C210(Self:C308->; 1; 10000)
		
	: (Form event code:C388=On Losing Focus:K2:8)
		$obj_FormData.doHideBumper.call()  // hide the BUMPER
		$obj_FormData.theGuy:=Null:C1517
		If ($obj_FormData.ptr_Year-><100)
			$obj_FormData.ptr_Year->:=$obj_FormData.ptr_Year->+2000  // all two-digit dates
		End if 
		
		IS_DATEENTRY_UPDATEDATE  // update the  $obj_FormData.theDate  based on the component YEAR, MONTH, DAY
		
	: (Form event code:C388=On Data Change:K2:15)
		
End case 

