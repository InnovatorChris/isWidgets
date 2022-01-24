//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DATEPICKER_BUMP_DAY (  ) // bump the selected date appropriately. The whole secret is in the correct naming of the invisible button
var $1 : Integer  // # of days to adjust the date by
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object
// ** this is used by our arrow-key buttons 
// ▲ = Day_Back                     ▼ = Day_Ahead
// ◀ = Week_Back                  ▶ = Week_Ahead
// ⌘▲ = Year_Back           ⌘▼ = Year_Ahead
// ⌘◀ = Month_Back       ⌘▶ = Month_Ahead

// We rely upon the correct naming of the bump buttons. They should be named in this manner:
// TYPE_DIRECTION       Day_Ahead  Day_Back   Week_Ahead Week_Back   Month_Ahead Month_Back   Year_Ahead Year_Back
var $namePieces : Collection  // used to split the name of the button into components
var $jumpType : Text  // text of the TYPE of jump;  Day, Week, Month or Year
var $jumpAmount : Integer  // will be 1 or -1 (Ahead or Back)
var $curDate; $newDate : Date

$namePieces:=Split string:C1554(OBJECT Get name:C1087(Object current:K67:2); "_")
$jumpType:=$namePieces[0]  // Day, Week, Month, Year
$jumpAmount:=Choose:C955($namePieces[1]="Ahead"; 1; -1)  // if it is AHEAD, then advance 1. otherwise it is BACK, so backup 1

$calMonth:=$obj_FormData.calendarMonth  // we remember what calendar is being displayed according to $curDate
$calYear:=$obj_FormData.calendarYear
$curDate:=$obj_FormData.theDate
$newDate:=$curDate  // prepare to adjust the date according to the curent date

Case of 
	: ($jumpType="Day")  // one day forward or back
		$newDate:=$curDate+$jumpAmount
		
	: ($jumpType="Week")  // one week forward or back
		$newDate:=$curDate+($jumpAmount*7)
		
	: ($jumpType="Mon@")  // one month forward or back. We juse "Mon@" because we have our visible <> buttons (Mon_) and invisible keyed-buttons (Month_)
		$newDate:=Add to date:C393($curDate; 0; $jumpAmount; 0)
		
	: ($jumpType="Year")  // one year forward or back
		$newDate:=Add to date:C393($curDate; $jumpAmount; 0; 0)
		
End case 

// we need to notice if we need to change the calendar to a different month. Do so if the date ends up in a different month than currently displayed
$newCalMonth:=Month of:C24($newDate)
$newCalYear:=Year of:C25($newDate)

$obj_FormData.theDate:=$newDate  // update the date that was selected
IS_DATEENTRY_UPDATE_DATEDISPLAY  // update the dateDisplay OBJECT

If (($calMonth#$newCalMonth) | ($calYear#$newCalYear))  // if we need to change to another month's calendar...do so
	IS_DATEPICKER_CONFIG_CALENDAR  // configure the calendar for this date
End if 

IS_DATEPICKER_UPDATE_DISPLAY  // update the display now too
