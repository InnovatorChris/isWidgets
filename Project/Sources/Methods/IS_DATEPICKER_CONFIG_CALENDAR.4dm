//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DATEPICKER_CONFIG_CALENDAR ( )
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
var $thisMonth : Integer
var $dayTitle : Text

$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the storage object (on the widget: formData)

// CALENDAR YEAR & MONTH, AND SET THE TEXT FOR THIS MONTH ***
$obj_FormData.calendarYear:=Year of:C25($obj_FormData.theDate)
$obj_FormData.calendarMonth:=Month of:C24($obj_FormData.theDate)
$obj_FormData.displayMonthText:=$obj_FormData.col_monthNames[$obj_FormData.calendarMonth]+" "+String:C10($obj_FormData.calendarYear)
OBJECT SET TITLE:C194(*; "DisplayedMonth"; $obj_FormData.displayMonthText)

// NOW DEVISE THE CALENDAR APPEARANCE ***
$obj_FormData.firstDate:=FirstDayOfWeek(FirstDayOfMonth($obj_FormData.theDate))  // figure out the date of the SUNDAY of the first week
If ($obj_FormData.firstDate=$obj_FormData.theDate)  // if this is the same as the current date (which would only happen on first of month, SUNDAY)
	$obj_FormData.firstDate:=$obj_FormData.firstDate-7
End if 

$thisMonth:=Month of:C24($obj_FormData.theDate)  // this is the MONTH# of the calendar we are displaying
For ($i; 0; 41)
	$dayTitle:="d"+String:C10($i)  // the name of the day TEXT
	$thisDate:=$obj_FormData.firstDate+$i  // this is the DATE we are setting up
	OBJECT SET TITLE:C194(*; $dayTitle; String:C10(Day of:C23($thisDate)))
	
	If (Month of:C24($thisDate)=$thisMonth)
		OBJECT SET RGB COLORS:C628(*; $dayTitle; $obj_FormData.defaultForeRGB; $obj_FormData.defaultBackRGB)
	Else 
		OBJECT SET RGB COLORS:C628(*; $dayTitle; $obj_FormData.outsideMonthForeRGB; $obj_FormData.outsideMonthBackRGB)
	End if 
	
	OBJECT SET FONT SIZE:C165(*; $dayTitle; $obj_FormData.defaultFontSize)
	OBJECT SET FONT STYLE:C166(*; $dayTitle; $obj_FormData.defaultFontStyle)
	//OBJECT SET FONT(*;$dayTitle;$obj_FormData.defaultFontName)  // probably not necessary
End for 



