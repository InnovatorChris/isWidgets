//%attributes = {"shared":true,"publishedWeb":true,"invisible":true}
// doTinyCalendar
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget
var $curDate; $newDate : Date
var $l; $t; $r; $b; $wdw : Integer
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

OBJECT GET COORDINATES:C663(*; "TinyCalendar"; $l; $t; $r; $b)
CONVERT COORDINATES:C1365($r; $b; XY Current form:K27:5; XY Screen:K27:7)

IS_DATEENTRY_UPDATEDATE  // update the  $obj_FormData.theDate  based on the component YEAR, MONTH, DAY. (The user may have just been modifying it)

$curDate:=$obj_FormData.theDate  // get the current date we have been working on

C_OBJECT:C1216($objDate)
$objDate:=New object:C1471("theDate"; $curDate; "inDateEntry"; True:C214)

$wdw:=Open form window:C675("IS_DatePicker"; Pop up form window:K39:11+Form has no menu bar:K39:18; $r-130; $b)
DIALOG:C40("IS_DatePicker"; $objDate)
CLOSE WINDOW:C154($wdw)  // close the date-picker window. 

If (OK=1)  // if the date picker was 'OK'ed... we can retrieve the new date
	$newDate:=$objDate.theDate
	// conditionally update it if it has changed. We help out by breaking out the date into its components (DAY, MONTH, YEAR) —— Voila!
	If ($newDate#$curDate)
		$obj_FormData.ptr_Day->:=Day of:C23($newDate)  // load the input areas according to correct values from theDate
		$obj_FormData.ptr_Month->:=Month of:C24($newDate)
		$obj_FormData.ptr_Year->:=Year of:C25($newDate)
		$obj_FormData.datePickerChangedDate:=True:C214  // date picker changed the date
		IS_DATEENTRY_UPDATEDATE  // update date, container value, and tell container object of any changes. (.theDate gets set in this)
		IS_DATEENTRY_EXIT  // try to leave now
	End if 
End if 
