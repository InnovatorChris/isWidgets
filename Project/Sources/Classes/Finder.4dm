/* Class:  Finder — manage the mechanism that we use to search a dataclass with a 'Finder' subform.
Works in conjunction with cs.FinderGroup(), which handles the listBox stuff
 MESSAGES:
WIDGET-LEVEL MESSAGES:
• _msg_FC_Init — initialize
• _msg_FC_Edit — edit
• _msg_FC_ResumeEdit — resume editing (after a up/down keystroke in listBox, or a click in the listbox)
CONTAINER-LEVEL MESSAGES:
• _msg_FCC_Select — User has SELECTED a choice. Container should process the selection
• _msg_FCC_Update — selected record was 'updated' and/or the selection was updated. This is sent to the CONTAINER to be processed.
• _msg_FCC_TextChange — text in the 'Finder' was changed. While it is sent to the Container, it actually is processed in cs.FinderGroup.do( )
• _msg_FCC_Previous — go to the previous record (listbox - caused). While it is sent to the Container, it actually is processed in cs.FinderGroup.do( )
• _msg_FCC_Next — go to the next record (listbox - caused). While it is sent to the Container, it actually is processed in cs.FinderGroup.do( )
• _msg_OK
• _msg_Cancel
*/
// will also end up with:  .es  .en   during operation
Class constructor($fg : cs:C1710.FinderGroup; $containerName : Text; $dataClass : Text; $maxRows : Integer; $placeHolder : Text; $columns : Collection; $orderBy : Text; $col_QuerySpecs : Collection; $showAllOnEntry : Boolean; $isDoNotDraw : Boolean)
	This:C1470.dClass:=$dataClass
	This:C1470.searchFor:=""  // the 'search for' text field we work with
	This:C1470.maxRows:=$maxRows
	This:C1470.placeHolder:=$placeHolder
	This:C1470.makeColumns($columns)  // ensure these are cs.FinderColumn() things
	This:C1470.orderByText:=$orderBy
	This:C1470.containerName:=$containerName
	This:C1470.searchFormulas:=New collection:C1472  // we keep the search formulas in this collection
	This:C1470.searchColors:=New collection:C1472  // this is the collection of 'colors' that each level receives. If it is missing for some reason, we will put in _RGB_Black
	For each ($querySpec; $col_QuerySpecs)
		This:C1470.searchFormulas.push($querySpec.formula)
		This:C1470.searchColors.push($querySpec.color)
	End for each 
	This:C1470.showAllOnEntry:=$showAllOnEntry  // TRUE if they want us to 'show all' when the user goes into this (with none selected)
	This:C1470.isDoNotDraw:=Bool:C1537($isDoNotDraw)
	$fg.addFinder(This:C1470)  // add ourselves to the group. The FinderGroup is also configured as This.LBFinder
/* the 'LBFinder' object controls / receives values from the LB_Finder listBox.
—  .es — entity selection it is showing
— .en — the current entity
— .itemPos — selected item position
— .es_Selected — the selected entities
————
*/
	This:C1470.init()  // finish the FC-controller initialization. 
	
Function makeColumns($columns : Collection)  // use cs.FinderColumn( ) to configure the columns
	This:C1470.columns:=New collection:C1472
	For each ($column; $columns)
		If (OB Instance of:C1731($column; cs:C1710.FinderColumn))  // if it is already a cs.FinderColumn(),  use it
			This:C1470.columns.push($column)
		Else 
			This:C1470.columns.push(cs:C1710.FinderColumn.new($column.theFormula; $column.width; $column.dataType))  // turn it into a cs.FinderColumn()
		End if 
	End for each 
	
Function init()  // tell the widget to initialize, now that our object variable is ready to share
	EXECUTE METHOD IN SUBFORM:C1085(This:C1470.containerName; "FC_Widget_Do"; *; _msg_FC_Init)
	
	// ————— WIDGET - LEVEL FUNCTIONS ——————
/* NOTE: The WIDGET is a simple subform. It's job is to look pretty, receive keystrokes, and message the CONTAINER.
—— it is the CONTAINER's job to respond to the input. The code for the CONTAINER is also in this class, but actually operates in the CONTAINER's context
—— the WIDGET also cannot see or control the LB_Finder because it is actually in the same form as the CONTAINER, so be careful not to 
—— try to access it when this class is operating in the Widget-Level.*/
Function doWidgetInitLBSpecs()  // initialize the LB_Finder specs so we can bring it up easily.Note that because it is potentially shared with other cs.Finder(), we do not configure it right now
	// we also pre-determine the specs for the LB_Finder so we can avoid re-computing it all the time
	This:C1470.lbWidth:=16  // we will compute what the lbColWidth should be beforehand. We add size for the vertical scrollbar
	var $colNo; $colCount : Integer
	For ($colNo; 1; This:C1470.columns.length)  // set a 'colNo' value on each column to simplify coding
		//This.columns[$colNo-1].configAsColumnNo($colNo)  // get the cs.FinderColumn() to configure its .colNo & .colName
		This:C1470.lbWidth:=This:C1470.lbWidth+This:C1470.columns[$colNo-1].width
	End for 
	This:C1470.lbRowCount:=This:C1470.maxRows  // configure .lbRowCount  so we remember to use it to specify how many rows are being displayed
	
Function doWidgetInit()  // initialize (if not already)
	If (Form:C1466.isInit=Null:C1517)  // if we haven't initialized yet, then we do it
		//If (Undefined(Form.isInit))   // [CB 05/18/2021] Remove Undefined]
		Form:C1466.isInit:=True:C214  // we are initialized now
		If (This:C1470.isDoNotDraw)  // do not draw any of the search-bar look
			OBJECT SET VISIBLE:C603(*; "mac_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "win_@"; True:C214)  // this will put a BOX around the input area. We will need to decide which 'magnifying glass' to show depending on platform
			OBJECT SET VISIBLE:C603(*; "mac_Focus@"; False:C215)  // hide the 'focus' indicator for macs
			If (Is macOS:C1572)
				OBJECT SET VISIBLE:C603(*; "mac_Glass"; True:C214)
				OBJECT SET VISIBLE:C603(*; "win_Glass"; False:C215)
				OBJECT MOVE:C664(*; "searchFor"; 0; 0; 6; 0)  // resize the 'searchFor' input area, extending it 6 pixels because we are not drawing it as a searchBar
			Else 
				OBJECT SET VISIBLE:C603(*; "mac_Glass"; False:C215)
				OBJECT SET VISIBLE:C603(*; "win_Glass"; True:C214)
				OBJECT MOVE:C664(*; "searchFor"; -19; 0; 18; 0)  // resize the 'searchFor' input area, and make its boundaries visible
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*; "mac_@"; Is macOS:C1572)
			OBJECT SET VISIBLE:C603(*; "win_@"; Is Windows:C1573)
			If (Is Windows:C1573)  // if display as on windows, then we need to change the framing images
				OBJECT MOVE:C664(*; "searchFor"; -15; 0)  // bump to left a bit for windows
			Else 
				OBJECT SET VISIBLE:C603(*; "mac_Focus@"; False:C215)  // hide the 'focus' indicator for macs
			End if 
		End if 
		
		C_LONGINT:C283($subHeight; $subWidth)
		OBJECT GET SUBFORM CONTAINER SIZE:C1148($subWidth; $subHeight)
		OBJECT GET COORDINATES:C663(*; "mac_SBRight"; $L; $T; $R; $B)  // find out where the RIGHT-SIDE of the Mac search is. It's RIGHT should be exactly the width of the subform
		// NOTE: We need to do it this way, because if this subform is itself inside a subform that gets hidden, then shown again, Form.isInit will be undefined, but the elements would have already been repositioned. Very stupid
		If (Form:C1466.placeholder=Null:C1517)
			//If (Undefined(Form.placeholder))  // [CB 05/18/2021] Remove Undefined]
			Form:C1466.placeholder:="Search Text"
		End if 
		OBJECT SET PLACEHOLDER:C1295(*; "searchFor"; Form:C1466.placeHolder)  // set the placeholder if given
		$adjustWidth:=$subWidth-$R  // hopefully the same
		If ($adjustWidth#0)
			OBJECT MOVE:C664(*; "@Middle"; 0; 0; $adjustWidth; 0)  // make the 'middle' elements resized
			OBJECT MOVE:C664(*; "@Right"; $adjustWidth; 0)  // move the 'Right' elements
			OBJECT MOVE:C664(*; "win_Glass"; $adjustWidth; 0)  // and the 'windows glass'
			OBJECT MOVE:C664(*; "searchFor"; 0; 0; $adjustWidth; 0)  // resize the searchFor input area
		End if 
	End if 
	This:C1470.doWidgetInitLBSpecs()  // and initialize the LB_Finder specs
	
Function doWidget($msg : Variant)  // this takes place in the context of the Widget, where Form. is This
	Case of 
		: ($msg=_msg_FC_Init)  // told to initialize
			This:C1470.doWidgetInit()
			
		: ($msg=_msg_FC_Edit)
			EDIT ITEM:C870(*; "searchFor")
			
		: ($msg=_msg_FC_ResumeEdit)  // after an up / down arrow key has been pressed, we need to re-establish this with the focus
			EDIT ITEM:C870(*; "searchFor")  // return to the 'search for' thing
			POST KEY:C465(Right arrow key:K12:17)
			
	End case 
	
	// ————— CONTAINER - LEVEL FUNCTIONS —————— //
	// we get the FinderGroup to handle all the processing. It will configure for us automatically.
Function do($event : Object) : Object  // perform the operation (this is at the CONTAINER level). It receives the 'FORM Event'. The caller can see what event was handled
	This:C1470.group.do($event)  // pass it along to our FinderGroup object. It will handle all the stuff to do with managing entry and the listBox
	$0:=$event  // let the caller know what event we handled
	