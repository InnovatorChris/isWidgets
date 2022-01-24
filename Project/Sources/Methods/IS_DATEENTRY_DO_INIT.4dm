//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DATEENTRY_DO_INIT ( { AttributeName } ; {NextEntryObject} ; {PlaceHolder Text} ) —> configure the IS_DateEntry widget. — NOTE: This operates in this local environment (not in parent project)
// this is how we update the value upon exitting. 
// for example, it may be   "formDate"    and it will be used as  "Form[formDate]. This will SET or GET the value from the CONTAINER's OBJECT
#DECLARE($attributeName : Text; $nextEntryObject : Text; $placeHolder : Text)  // name of the object attribute; use _Blank if this is for a variable, placeholder text to use
If ($placeHolder#"")
	OBJECT SET PLACEHOLDER:C1295(*; "dateDisplay"; $placeHolder)
End if 

var $formObjPtr : Pointer  // we need this to check if the "formData" is null. It will be all the time when this is called, actually
var $obj_FormData : Object  // the OBJECT (in the form) that contains the DATA we maintain for this widget

$formObjPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")  // this is the object on the form where we are storing the 'form data'
If ($formObjPtr->=Null:C1517)  // no object
	$formObjPtr->:=New object:C1471("isInit"; True:C214)
End if 
$obj_FormData:=OBJECT Get pointer:C1124(Object named:K67:5; "formData")->  // this is the form data object

$obj_FormData.nextObjectName:=$nextEntryObject  // this is the object we should GOTO when we want to exit. It is blank if none given

// If the bound variable is an OBJECT, we need to be given the attribute name of the DATE we are managing
// if the bound variable is a DATE variable, we handle things differently, but caller does not need to give us any other information (no parameter)
If ($attributeName#"")  // if they gave an attribute name...
	$obj_FormData.sourceAttr:=$attributeName
	$obj_FormData.containerObjName:=OBJECT Get name:C1087  // this will be the name of the container object on the parent form! We need it for REDRAW
	$obj_FormData.isBoundToObject:=True:C214
Else 
	$obj_FormData.isBoundToObject:=False:C215  // not bound to an object's attribute
End if 

$obj_FormData.bumper:=0  // 'Bumper' controllers. This is the CURRENT VALUE of the bumper...
$obj_FormData.prevBumper:=0  // this is our managed PREVIOUS value of the bumper. This way we can figure out if they bumped UP or DOWN
$obj_FormData.col_days:=New collection:C1472(0; 31; 28; 31; 30; 31; 30; 31; 31; 30; 31; 30; 31)  // Form.col_days[month#] = last day of that month. Other than if leap year

// DATE ENTRY HANDLING.
$obj_FormData.theDate:=IS_DateEntry_GetContainerDate  // get the date!
// The YEAR, MONTH, DAY are separate entered (unnamed) variables on the widget. We need their pointers so we can process the values.
// may as well get the pointers once and for all at initialization
$obj_FormData.ptr_Day:=OBJECT Get pointer:C1124(Object named:K67:5; "theDay")  // these are the unnamed variables that comprise our widget's entry areas.
$obj_FormData.ptr_Month:=OBJECT Get pointer:C1124(Object named:K67:5; "theMonth")  // we use these because if we don't, then the widget updating does not happen properly...
$obj_FormData.ptr_Year:=OBJECT Get pointer:C1124(Object named:K67:5; "theYear")  // if we use unnamed vars and synchronize them to what we use, then it works

$obj_FormData.ptr_Day->:=Day of:C23($obj_FormData.theDate)  // load the input areas according to correct values from theDate
$obj_FormData.ptr_Month->:=Month of:C24($obj_FormData.theDate)
$obj_FormData.ptr_Year->:=Year of:C25($obj_FormData.theDate)

// **** SET UP SOME FORMULAS USED ONLY WITHIN THIS FORM ****
// this reduces the code, makes it more modular, and is nifty-cool to do ****
$obj_FormData.doShowBumper:=Formula:C1597(OBJECT SET VISIBLE:C603(*; "bumper@"; True:C214))
$obj_FormData.doHideBumper:=Formula:C1597(OBJECT SET VISIBLE:C603(*; "bumper@"; False:C215))

OBJECT SET ENABLED:C1123(*; "btn_OK"; False:C215)  // deactivate the OK button, which allows user to <CR> out of this area. It is, sadly, ENABLED by default
OBJECT SET ENABLED:C1123(*; "btn_Today"; False:C215)  // deactivate the TODAY button, which sets the date to TODAY

IS_DATEENTRY_DO_REFRESH  // refresh the DISPLAY of the DD/MM/YY & the value of .theDate
IS_DATEENTRY_UPDATE_DATEDISPLAY  // update the dateDisplay OBJECT

IS_DateButtonsOnOff(False:C215; "Is_DateEntry")  // turn it OFF. The default behaviour should be OFF