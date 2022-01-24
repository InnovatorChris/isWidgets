//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DATEPICKER_UPDATE_DISPLAY ( ) — update the appearance of the widget, based on $obj_FormData.theDate
C_OBJECT:C1216($obj_FormData)  // the storage object on the widget
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the storage object (on the widget: formData)

// YEAR & MONTH SETTINGS FOR CURRENT CALENDAR ***
//$obj_FormData.calendarYear
//$obj_FormData.calendarMonth
var $thisMonth; $dayNum : Integer
var $thisDate : Date
var $prevChoiceName : Text
$thisMonth:=$obj_FormData.calendarMonth  // this is the MONTH# of the calendar we are displaying


If ($obj_FormData.prev_dayGrid_Choice#0)
	$thisDate:=$obj_FormData.firstDate+$obj_FormData.prev_dayGrid_Choice-1  // this is the DATE we are clearing
	
	$prevChoiceName:="d"+String:C10($obj_FormData.prev_dayGrid_Choice-1)
	OBJECT SET FONT SIZE:C165(*; $prevChoiceName; $obj_FormData.defaultFontSize)
	OBJECT SET FONT STYLE:C166(*; $prevChoiceName; $obj_FormData.defaultFontStyle)
	
	If (Month of:C24($thisDate)=$thisMonth)
		OBJECT SET RGB COLORS:C628(*; $prevChoiceName; $obj_FormData.defaultForeRGB; $obj_FormData.defaultBackRGB)
	Else 
		OBJECT SET RGB COLORS:C628(*; $prevChoiceName; $obj_FormData.outsideMonthForeRGB; $obj_FormData.outsideMonthBackRGB)
	End if 
	
	$obj_FormData.prev_dayGrid_Choice:=0  // initialize this again for now
End if 

If ($obj_FormData.theDate#!00-00-00!)  // if a valid date is given
	$dayNum:=$obj_FormData.theDate-$obj_FormData.firstDate+1  // the number of days between the firstDate and theDate.
	
	// DO NOT ASSUME that .theDate IS ON THE CURRENTLY-DISPLAYED CALENDAR. IT MAY HAVE DISAPPEARED AS THEY MAY HAVE CHANGED MONTHS
	If ($dayNum>0)
		If ($dayNum<43)
			$thisChoiceName:="d"+String:C10($dayNum-1)
			OBJECT SET FONT STYLE:C166(*; $thisChoiceName; Bold:K14:2)
			OBJECT SET FONT SIZE:C165(*; $thisChoiceName; $obj_FormData.defaultFontSize+2)  // make it OBVIOUS by enlarging the font
			OBJECT SET RGB COLORS:C628(*; $thisChoiceName; $obj_FormData.selectedForeRGB; $obj_FormData.selectedBackRGB)
			
			$obj_FormData.prev_dayGrid_Choice:=$dayNum  // current one now becomes the 'previous grid choice'
		End if 
	End if 
End if 

