//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DATEPICKER_INIT ( { AttributeName } ) —> BOOLEAN (TRUE if successful)
// this is how we update the value upon exitting. 
// for example, it may be   "formDate"    and it will be used as  "Form[formDate]. This will SET or GET the value from the CONTAINER's OBJECT
var $1 : Text  // the attribute name where the value is stored
var $formObjPtr : Pointer  // we need this to check if the "formData" is null. It will be all the time when this is called, actually
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget

$formObjPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")  // this is the object on the form where we are storing the 'form data'
If ($formObjPtr->=Null:C1517)  // no object
	$formObjPtr->:=New object:C1471("isInit"; True:C214)
End if 
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

// If the bound variable is an OBJECT, we need to be given the attribute name of the DATE we are managing
// if the bound variable is a DATE variable, we handle things differently, but caller does not need to give us any other information (no parameter)
If (Count parameters:C259>0)  // if they gave an attribute name...
	$obj_FormData.sourceAttr:=$1
	$obj_FormData.containerObjName:=OBJECT Get name:C1087  // this will be the name of the container object on the parent form! We need it for REDRAW
	$obj_FormData.isBoundToObject:=True:C214
	
Else 
	$obj_FormData.isBoundToObject:=False:C215  // not bound to an object's attribute
End if 

// DEFINE our control structures ***
$obj_FormData.theDate:=!00-00-00!
$obj_FormData.firstDate:=!00-00-00!
$obj_FormData.calendarMonth:=0
$obj_FormData.calendarYear:=0
$obj_FormData.displayMonthText:=""  // shown in the "DisplayedMonth" OBJECT. Kept up-to-date in IS_DATEPICKER_CONFIG_CALENDAR( )

$obj_FormData.col_monthNames:=New collection:C1472(""; "January"; "February"; "March"; "April"; "May"; "June"; "July"; "August"; "September"; "October"; "November"; "December")
$obj_FormData.ptr_dayGrid:=OBJECT Get pointer:C1124(Object named:K67:5; "dayGrid")  // this is the GRID BUTTON that we use for selecting the date. Remember the pointer for simplification
$obj_FormData.prev_dayGrid_Choice:=0  // this remembers the previous 'dayGrid' choice so we can unselect it as needed (in sense of restoring TEXT OBJECT appearance)

// **** SET UP SOME FORMULAS USED ONLY WITHIN THIS FORM ****
// this reduces the code, makes it more modular, and is nifty-cool to do **** 
// RETAINED FOR INSTRUCTIVE PURPOSES
//$obj_FormData.doShowBumper:=New formula(OBJECT SET VISIBLE(*;"bumper@";True))
//$obj_FormData.doHideBumper:=New formula(OBJECT SET VISIBLE(*;"bumper@";False))

OBJECT SET TITLE:C194(*; "DayName1"; "Sun")
OBJECT SET TITLE:C194(*; "DayName2"; "Mo")
OBJECT SET TITLE:C194(*; "DayName3"; "Tue")
OBJECT SET TITLE:C194(*; "DayName4"; "We")
OBJECT SET TITLE:C194(*; "DayName5"; "Thu")
OBJECT SET TITLE:C194(*; "DayName6"; "Fri")
OBJECT SET TITLE:C194(*; "DayName7"; "Sat")

// STYLISTIC NOTES: We derive a lot of them by examining OBJECT NAMED "D0" (the first day text object)

var $foreRGB; $backRGB : Integer  // RGB color values
OBJECT GET RGB COLORS:C1074(*; "D0"; $foreRGB; $backRGB)
$obj_FormData.defaultForeRGB:=$foreRGB
$obj_FormData.defaultBackRGB:=$backRGB
$obj_FormData.outsideMonthForeRGB:=10987431  // grey
$obj_FormData.outsideMonthBackRGB:=15002111  // lilac-sort of color
$obj_FormData.defaultFontSize:=OBJECT Get font size:C1070(*; "D0")
$obj_FormData.defaultFontStyle:=OBJECT Get font style:C1071(*; "D0")
$obj_FormData.defaultFontName:=OBJECT Get font:C1069(*; "D0")
$obj_FormData.selectedForeRGB:=2438143  // a dark blue
$obj_FormData.selectedBackRGB:=16777215  // white


IS_DATEENTRY_UPDATE_DATEDISPLAY  // update the dateDisplay OBJECT