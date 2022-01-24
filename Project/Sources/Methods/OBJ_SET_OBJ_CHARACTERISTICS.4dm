//%attributes = {"invisible":true,"publishedWeb":true,"shared":true}
// OBJ_SET_OBJ_CHARACTERISTICS ( Object Name; InfoObj; {choiceLongint} ) --> Set the appropriate characteristics based on InfoObj
var $1 : Text  // Object name
var $2 : Object  // Information Object
var $3; $options : Integer
ARRAY LONGINT:C221($arrEvents; 0)

If (Count parameters:C259>2)  // if they do not specify choices, then do them all (if the values are there)
	$options:=$3
Else 
	$options:=_OB_All
End if 

If (($options & _OB_RGB)#0)  // set RGB colors?
	If (($2.foreground#Null:C1517) & ($2.background#Null:C1517) & ($2.altBackground#Null:C1517))
		OBJECT SET RGB COLORS:C628(*; $1; $2.foreground; $2.background; $2.altBackground)
	End if 
End if 

If (($options & _OB_Action)#0)  // set Action? _
	If ($2.action#Null:C1517)
		OBJECT SET ACTION:C1259(*; $1; $2.action)
	End if 
End if 

If (($options & _OB_Coordinates)#0)  // set coordinates?
	If (($2.left#Null:C1517) & ($2.right#Null:C1517) & ($2.top#Null:C1517) & ($2.bottom#Null:C1517))
		OBJECT SET COORDINATES:C1248(*; $1; $2.left; $2.top; $2.right; $2.bottom)
	End if 
End if 

If (($options & _OB_Font)#0)  // set font information?
	If ($2.fontFamily#Null:C1517)
		OBJECT SET FONT:C164(*; $1; $2.fontFamily)
	End if 
	If ($2.fontSize#Null:C1517)
		OBJECT SET FONT SIZE:C165(*; $1; $2.fontSize)
	End if 
	If ($2.fontStyle#Null:C1517)
		OBJECT SET FONT STYLE:C166(*; $1; $2.fontStyle)
	End if 
End if 

If (($options & _OB_Format)#0)  // set format?
	If ($2.displayFormat#Null:C1517)
		OBJECT SET FORMAT:C236(*; $1; FormatCode($2.displayFormat))  // it needs to go through this translation for DATE, TIME, PICTURES
	End if 
End if 

If (($options & _OB_Filter)#0)  // set Filter? 
	If ($2.entryFilter#Null:C1517)
		OBJECT SET FILTER:C235(*; $1; $2.entryFilter)
	End if 
End if 

If (($options & _OB_StyleSheet)#0)  // set StyleSheet?
	If ($2.styleSheet#Null:C1517)
		OBJECT SET STYLE SHEET:C1257(*; $1; $2.styleSheet)
	End if 
End if 

If (($options & _OB_Spellcheck)#0)  // set Spellcheck? 
	If ($2.spellcheck#Null:C1517)
		OBJECT SET AUTO SPELLCHECK:C1173(*; $1; $2.spellcheck)
	End if 
End if 

If (($options & _OB_BorderStyle)#0)  // set BorderStyle?
	If ($2.borderStyle#Null:C1517)
		OBJECT SET BORDER STYLE:C1262(*; $1; $2.borderStyle)
	End if 
End if 

If (($options & _OB_ContextMenu)#0)  // set ContextMenu [Enabled]? 
	If ($2.contextMenu#Null:C1517)
		OBJECT SET CONTEXT MENU:C1251(*; $1; $2.contextMenu)
	End if 
End if 

If (($options & _OB_CornerRadius)#0)  // set corner radius? 
	If ($2.borderRadius#Null:C1517)
		OBJECT SET CORNER RADIUS:C1323(*; $1; $2.borderRadius)
	End if 
End if 

If (($options & _OB_DragDrop)#0)  // set drag and drop options? 
	If (($2.dragging#Null:C1517) & ($2.automaticDrag#Null:C1517) & ($2.dropping#Null:C1517) & ($2.automaticDrop#Null:C1517))
		OBJECT SET DRAG AND DROP OPTIONS:C1183(*; $1; $2.dragging; $2.automaticDrag; $2.dropping; $2.automaticDrop)
	End if 
End if 

If (($options & _OB_Enabled)#0)  // set enabled option? 
	If ($2.enabled#Null:C1517)
		OBJECT SET ENABLED:C1123(*; $1; $2.enabled)
	End if 
End if 

If (($options & _OB_Enterable)#0)  // set enterable option?
	If ($2.enterable#Null:C1517)
		OBJECT SET ENTERABLE:C238(*; $1; $2.enterable)
	End if 
End if 

If (($options & _OB_Events)#0)  // set events?
	If ($2.events#Null:C1517)
		COLLECTION TO ARRAY:C1562($2.events; $arrEvents)
		OBJECT SET EVENTS:C1239(*; $1; $arrEvents; Enable events disable others:K42:37)  // ONLY these events active
	End if 
End if 

If (($options & _OB_FocusRectInv)#0)  // set Focus Rectangle visible?
	If ($2.focusRectInvisible#Null:C1517)
		OBJECT SET FOCUS RECTANGLE INVISIBLE:C1177(*; $1; $2.focusRectInvisible)
	End if 
End if 

If (($options & _OB_HelpTip)#0)  // set help tip?
	If ($2.helpTip#Null:C1517)
		OBJECT SET HELP TIP:C1181(*; $1; $2.helpTip)
	End if 
End if 

If (($options & _OB_Alignment)#0)  // set alignments?
	If ($2.horizAlign#Null:C1517)  // horizontal?
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $1; $2.horizAlign)
	End if 
	If ($2.vertAlign#Null:C1517)  // vertical?
		OBJECT SET VERTICAL ALIGNMENT:C1187(*; $1; $2.vertAlign)
	End if 
End if 

If (($options & _OB_ListNames)#0)  // set choice lists by name?
	If ($2.choiceList#Null:C1517)  // choiceList name?
		OBJECT SET LIST BY NAME:C237(*; $1; Choice list:K42:19; $2.choiceList)
	End if 
	
	If ($2.excludedList#Null:C1517)  // excluded list name?
		OBJECT SET LIST BY NAME:C237(*; $1; Excluded list:K42:21; $2.excludedList)
	End if 
	
	If ($2.requiredList#Null:C1517)  // required list name?
		OBJECT SET LIST BY NAME:C237(*; $1; Required list:K42:20; $2.requiredList)
	End if 
End if 

If (($options & _OB_ListRefs)#0)  // set choice list by refs?
	
	If ($2.choiceListRef#Null:C1517)  // choice list ref?
		OBJECT SET LIST BY REFERENCE:C1266(*; $1; Choice list:K42:19; $2.choiceListRef)
	End if 
	
	If ($2.excludedListRef#Null:C1517)  // excluded list ref?
		OBJECT SET LIST BY REFERENCE:C1266(*; $1; Excluded list:K42:21; $2.excludedListRef)
	End if 
	
	If ($2.requiredListRef#Null:C1517)  // required list ref?
		OBJECT SET LIST BY REFERENCE:C1266(*; $1; Required list:K42:20; $2.requiredListRef)
	End if 
End if 

If (($options & _OB_MaxMin)#0)  // set max / min?
	If ($2.max#Null:C1517)  // max?
		OBJECT SET MAXIMUM VALUE:C1244(*; $1; $2.max)
	End if 
	If ($2.min#Null:C1517)  // min?
		OBJECT SET MINIMUM VALUE:C1242(*; $1; $2.min)
	End if 
End if 

If (($options & _OB_MultiLine)#0)  // set multiLine option?
	If ($2.multiLine#Null:C1517)  // valid?
		OBJECT SET MULTILINE:C1253(*; $1; $2.multiLine)
	End if 
End if 

If (($options & _OB_Placeholder)#0)  // set Placeholder?
	If ($2.placeholder#Null:C1517)  // valid?
		OBJECT SET PLACEHOLDER:C1295(*; $1; $2.placeholder)
	End if 
End if 

If (($options & _OB_ResizeOpts)#0)  // set Resize options?
	If (($2.resizeHoriz#Null:C1517) & ($2.resizeVert#Null:C1517))  // valid?
		OBJECT SET RESIZING OPTIONS:C1175(*; $1; $2.resizeHoriz; $2.resizeVert)
	End if 
End if 

If (($options & _OB_Shortcut)#0)  // set keyboard shortcut?
	If (($2.shortcut#Null:C1517) & ($2.modifiers#Null:C1517))  // valid?
		OBJECT SET SHORTCUT:C1185(*; $1; $2.shortcut; $2.modifiers)
	End if 
End if 

If (($options & _OB_StyledText)#0)  // set StyledText option? it cannot be set here...
	If ($2.styledText#Null:C1517)  // valid?
		//OBJECT set is styled text(*;$1)
	End if 
End if 