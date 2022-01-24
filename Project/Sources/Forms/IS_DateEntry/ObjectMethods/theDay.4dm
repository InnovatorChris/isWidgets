// SCRIPT: theDay
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
var $theMonth; $lastDay : Integer
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

Case of 
	: (Form event code:C388=On Getting Focus:K2:7)
		$obj_FormData.theGuy:=OBJECT Get name:C1087(Object with focus:K67:3)
		$obj_FormData.doShowBumper.call()  // show the BUMPER
		$theMonth:=$obj_FormData.ptr_Month->
		$lastDay:=$obj_FormData.col_days[$theMonth]  // this is the last day of that month
		If ($theMonth=2)  // if February, adjust last day for leap years
			If (($obj_FormData.ptr_Year->%4)=0)  // a leap year possibly?
				If (($obj_FormData.ptr_Year->%400)#0)  // if not a 'skipped' leap year (every 400 years is NOT a leap year;  ex. 400, 800, 1200, 1600, 2000, 2400)
					$lastDay:=29
				End if 
			End if 
		End if 
		OBJECT SET MAXIMUM VALUE:C1244(*; $obj_FormData.theGuy; $lastDay)  // enforce our own MAXIMUM based on the month
		HIGHLIGHT TEXT:C210(Self:C308->; 1; 10000)
		
		
	: (Form event code:C388=On Losing Focus:K2:8)
		$obj_FormData.doHideBumper.call()  // hide the BUMPER
		$obj_FormData.theGuy:=Null:C1517
		IS_DATEENTRY_UPDATEDATE  // update the  $obj_FormData.theDate  based on the component YEAR, MONTH, DAY
		
	: (Form event code:C388=On Data Change:K2:15)
		
		//DatePicker__RecalcDate (True)
		
End case 

