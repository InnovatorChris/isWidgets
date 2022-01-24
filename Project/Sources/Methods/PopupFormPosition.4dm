//%attributes = {"publishedWeb":true,"shared":true,"preemptive":"incapable"}
// PopupFormPosition ( Form object ; PositionChoice; {$ownerWinRef:Integer} ) // FormObject just needs   .height  & .width  attributes. It can either be an 'OBJ_GetFormInfo' or a 'manufactured' form obj
#DECLARE($formDefn : Object; $posChoice : Integer; $masterWinRef : Integer)->$posObj : Object  // the resulting object   .left  .top
//var $1 : Object  // form object (has .width & .height characteristics)
//var $2 : Integer  // the positioning choice relative to the 'owner' window
//var $3 : Integer  // winRef. Optional
//var $0 : Object  
var $left; $top : Integer
var $windowObj : Object  // details about the window
var $winRef : Integer
$winRef:=Frontmost window:C447
If (Count parameters:C259>2)  // if given an 'ownerWinRef'
	$winRef:=$masterWinRef
End if 
SCREEN COORDINATES:C438($left; $topScreen; $right; $bottom; 0; Screen work area:K27:10)  // mostly we just need $topScreen
$windowObj:=OBJ_GetWindowInfo($winRef)  // details about the window, so we can figure out the positioning for the 'pwChooseFieldToInsert' dialog

// here we figure out the coordinates of the window we will pop up, depending upon the positioning choice ($posChoice)
// options are:  _topLeft  _topCenter  _topRight  _middleLeft  _middleCenter  _middleRight  _bottomLeft  _bottomCenter  _bottomRight  _middleThirdCenter

var $hLeft; $hCenter; $hRight; $vTop; $vCenter; $vBottom; $vThird : Integer  // make sure these are integers, not REALS
// LEFT-MOST ORIENTATION POINTS CALCULATIONS
$hLeft:=$windowObj.left
$hCenter:=$windowObj.left+(($windowObj.width-$formDefn.width)/2)
$hRight:=$windowObj.left+$windowObj.width-$formDefn.width

// TOP-MOST ORIENTATION POINTS CALCULATIONS
$vTop:=$windowObj.top
$vCenter:=$windowObj.top+(($windowObj.height-$formDefn.height)/2)
$vBottom:=$windowObj.bottom-$formDefn.height
$vThird:=$windowObj.top+(($windowObj.height-$formDefn.height)/3)

// orient the popup form to align based upon the Frontmost window
Case of 
	: ($posChoice=_topLeft)
		$posObj:=New object:C1471("left"; $hLeft; "top"; $vTop)
		
	: ($posChoice=_topCenter)
		$posObj:=New object:C1471("left"; $hCenter; "top"; $vTop)
		
	: ($posChoice=_topRight)
		$posObj:=New object:C1471("left"; $hRight; "top"; $vTop)
		
	: ($posChoice=_middleLeft)
		$posObj:=New object:C1471("left"; $hLeft; "top"; $vCenter)
		
	: ($posChoice=_middleCenter)
		$posObj:=New object:C1471("left"; $hCenter; "top"; $vCenter)
		
	: ($posChoice=_middleRight)
		$posObj:=New object:C1471("left"; $hRight; "top"; $vCenter)
		
	: ($posChoice=_bottomLeft)
		$posObj:=New object:C1471("left"; $hLeft; "top"; $vBottom)
		
	: ($posChoice=_bottomCenter)
		$posObj:=New object:C1471("left"; $hCenter; "top"; $vBottom)
		
	: ($posChoice=_bottomRight)
		$posObj:=New object:C1471("left"; $hRight; "top"; $vBottom)
		
	: ($posChoice=_middleThirdCenter)  // usually used for informational dialogs (custom ones that are like 4D's REQUEST, CONFIRM, ALERT, etc.)
		$posObj:=New object:C1471("left"; $hCenter; "top"; $vThird)  // LEFT = left side of window;  Top is calculated so that the bottom lines up with bottom of window
		
	Else 
		$top:=$posChoice/1000000  // this rounds out, which works fine
		$left:=$posChoice-($top*1000000)
		$posObj:=New object:C1471("left"; $left; "top"; $top)  // use the coordinates we were given
		
End case 
// as a final constraint, keep the top of the form at the Top of the usable portion of the screen
If ($posObj.top<$windowObj.top)  // if it is too close to the top of the screen
	$posObj.top:=$windowObj.top
End if 

// $posObj --> object with  .left  &  .top  attributes, giving the top/left orientation point for the form