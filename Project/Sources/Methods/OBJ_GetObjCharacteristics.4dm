//%attributes = {"invisible":true,"publishedWeb":true,"shared":true}
// OBJ_GetObjCharacteristics ( Object Name ; {choicesLongint} ) --> get Object information, return in an object:
// .foreground  .background  .altBackground  .action  .left  .right  .top  .bottom  .height  .width
// .font  .fontSize  .fontStyle  .displayFormat  .entryFilter  .styleSheet
var $1 : Text  // name of the object to inquire
var $2; $options; $fore; $back; $alt : Integer
var $Left; $Top; $Right; $Bottom : Integer
var $dragging; $automaticDrag; $dropping; $automaticDrop : Boolean
var $resizeHoriz; $resizeVertical : Integer
var $key : Text
var $modifiers : Integer
ARRAY LONGINT:C221($arrEvents; 0)
var $0 : Object  // the resulting object.   has  .
$0:=New object:C1471

If (Count parameters:C259>1)  // if they do not specify choices, then do them all
	$options:=$2
Else 
	$options:=_OB_All
End if 

If (($options & _OB_RGB)#0)  // get RGB colors?
	C_LONGINT:C283($fore; $back; $alt)
	OBJECT GET RGB COLORS:C1074(*; $1; $fore; $back; $alt)
	$0.foreground:=$fore
	$0.background:=$back
	$0.altBackground:=$alt
End if 

If (($options & _OB_Action)#0)  // told to 
	$0.action:=OBJECT Get action:C1457(*; $1)
End if 


If (($options & _OB_Coordinates)#0)  // told to 
	OBJECT GET COORDINATES:C663(*; $1; $Left; $Top; $Right; $Bottom)
	$0.left:=$Left
	$0.right:=$Right
	$0.top:=$Top
	$0.bottom:=$Bottom
	$0.height:=$Bottom-$Top
	$0.width:=$Right-$Left
End if 

If (($options & _OB_Font)#0)  // told to 
	$0.fontFamily:=OBJECT Get font:C1069(*; $1)
	$0.fontSize:=OBJECT Get font size:C1070(*; $1)
	$0.fontStyle:=OBJECT Get font style:C1071(*; $1)
End if 

If (($options & _OB_Format)#0)  // told to 
	$0.displayFormat:=OBJECT Get format:C894(*; $1)
End if 

If (($options & _OB_Filter)#0)  // told to 
	$0.entryFilter:=OBJECT Get filter:C1073(*; $1)
End if 

If (($options & _OB_StyleSheet)#0)  // told to 
	$0.styleSheet:=OBJECT Get style sheet:C1258(*; $1)
End if 

If (($options & _OB_Spellcheck)#0)  // told to 
	$0.spellcheck:=OBJECT Get auto spellcheck:C1174(*; $1)
End if 

If (($options & _OB_BorderStyle)#0)  // told to 
	$0.borderStyle:=OBJECT Get border style:C1263(*; $1)
End if 

If (($options & _OB_ContextMenu)#0)  // told to 
	$0.contextMenu:=OBJECT Get context menu:C1252(*; $1)
End if 

If (($options & _OB_CornerRadius)#0)  // told to 
	$0.borderRadius:=OBJECT Get corner radius:C1324(*; $1)
End if 


If (($options & _OB_DragDrop)#0)  // told to 
	OBJECT GET DRAG AND DROP OPTIONS:C1184(*; $1; $dragging; $automaticDrag; $dropping; $automaticDrop)
	$0.dragging:=$dragging
	$0.automaticDrag:=$automaticDrag
	$0.dropping:=$dropping
	$0.automaticDrop:=$automaticDrop
End if 


If (($options & _OB_Enabled)#0)  // told to 
	$0.enabled:=OBJECT Get enabled:C1079(*; $1)
End if 

If (($options & _OB_Enterable)#0)  // told to 
	$0.enterable:=OBJECT Get enterable:C1067(*; $1)
End if 


If (($options & _OB_Events)#0)  // told to 
	OBJECT GET EVENTS:C1238(*; $1; $arrEvents)
	$0.events:=ArrayToCollection(->$arrEvents)  // return in a collection
End if 


If (($options & _OB_FocusRectInv)#0)  // 
	$0.focusRectInvisible:=OBJECT Get focus rectangle invisible:C1178(*; $1)
End if 

If (($options & _OB_HelpTip)#0)  //
	$0.helpTip:=OBJECT Get help tip:C1182(*; $1)
End if 

If (($options & _OB_Alignment)#0)  //
	$0.horizAlign:=OBJECT Get horizontal alignment:C707(*; $1)
	$0.vertAlign:=OBJECT Get vertical alignment:C1188(*; $1)
End if 

If (($options & _OB_ListNames)#0)  //
	$0.choiceList:=OBJECT Get list name:C1072(*; $1; Choice list:K42:19)
	$0.excludedList:=OBJECT Get list name:C1072(*; $1; Excluded list:K42:21)
	$0.requiredList:=OBJECT Get list name:C1072(*; $1; Required list:K42:20)
End if 

If (($options & _OB_ListRefs)#0)  //
	$0.choiceListRef:=OBJECT Get list reference:C1267(*; $1; Choice list:K42:19)
	$0.excludedListRef:=OBJECT Get list reference:C1267(*; $1; Excluded list:K42:21)
	$0.requiredListRef:=OBJECT Get list reference:C1267(*; $1; Required list:K42:20)
End if 


If (($options & _OB_MaxMin)#0)  //
	$0.max:=0  // ensure these attributes exist before call
	$0.min:=0
	OBJECT GET MAXIMUM VALUE:C1245(*; $1; $0.max)
	OBJECT GET MINIMUM VALUE:C1243(*; $1; $0.min)
End if 


If (($options & _OB_MultiLine)#0)  //
	$0.multiLine:=OBJECT Get multiline:C1254(*; $1)
End if 

If (($options & _OB_Placeholder)#0)  //
	$0.placeholder:=OBJECT Get placeholder:C1296(*; $1)
End if 

If (($options & _OB_ResizeOpts)#0)  //
	OBJECT GET RESIZING OPTIONS:C1176(*; $1; $resizeHoriz; $resizeVertical)
	$0.resizeHoriz:=$resizeHoriz
	$0.resizeVert:=$resizeVertical
End if 

If (($options & _OB_Shortcut)#0)  //
	OBJECT GET SHORTCUT:C1186(*; $1; $key; $modifiers)
	$0.shortcut:=$key
	$0.modifiers:=$modifiers
End if 

If (($options & _OB_StyledText)#0)  //
	$0.styledText:=OBJECT Is styled text:C1261(*; $1)
End if 



