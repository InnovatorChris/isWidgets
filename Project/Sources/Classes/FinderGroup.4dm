/* Class: FinderGroup   — this is a simple class. It's purpose is just to define a 'group' of Finder's. They share the same LB_Finder (listbox).
—— with complicated screens with several subforms, then one may wish to defi*/
/*  .activeFinderName : the name of the active 'finder'
 .activeFinder: the cs.Finder object that is currently active (i.e.  This[This.activeFinderName])
*/
Class constructor
	This:C1470.lbName:="LB_Finder"  // this listBox will be 'shared' with all finders under this group. We need separate 'finders' for subforms, I think.
	This:C1470.lbNameBox:="LB_FinderBox"  // the 'box' that sets the backdrop. Otherwise the listbox is transparent
	This:C1470.col_Matches:=New collection:C1472(0; 0; 0; 0; 0)  // allow up to five levels of search 'matches. But, really, this is resized as needed, automatically
	This:C1470.searchColors:=New collection:C1472  // we just define this here as a way of documenting. When a FINDER becomes active, it sets this collection
	
	
Function addFinder($finder : cs:C1710.Finder)  // add this 'Finder' to the group
	This:C1470[$finder.containerName]:=$finder  // add the entry for this 'Finder'
	$finder.LBFinder:=This:C1470  // and let the finder access our LBFinder support
	$finder.group:=This:C1470  // and link the finder to our group. 
	
Function lbSetHeight()  // configure the LB_Finder to the optimal height. We avoid unnecessary dimension-changes
	var $lbPos : Object  // positional-object .top .left etc
	var $newHeight : Integer  // the height the lb needs to be. 
	var $matches : Integer  // will be the # of matches in This.LBFinder.es.
	$lbPos:=OBJ_GetObjCharacteristics(This:C1470.lbName; _OB_Coordinates)
	$rows:=MinValue(This:C1470.matchCount(); This:C1470.activeFinder.lbRowCount)
	$newHeight:=$rows*This:C1470.lbRowHeight
	If ($lbPos.height#$newHeight)  // if the height is changed...
		$lbPos.height:=$newHeight
		$lbPos.bottom:=$lbPos.top+$lbPos.height
		OBJ_SET_OBJ_CHARACTERISTICS(This:C1470.lbName; $lbPos; _OB_Coordinates)  // and re-dimension the LB 
		OBJ_SET_OBJ_CHARACTERISTICS(This:C1470.lbNameBox; $lbPos; _OB_Coordinates)  // and re-dimension the LB 
	End if 
	
	// position the .lbFinder (listBox) directly under the active Finder //
Function lbSetPosition()  // position the Top-Left to be just underneath the CONTAINER, and make its WIDTH correct
	var $pos : Object  // this will be a 'rectangle' object. We start by finding out our Container's location, then set the top-left (and bottom)
	$pos:=OBJ_GetObjCharacteristics(This:C1470.activeFinderName; _OB_Coordinates)
	$pos.top:=$pos.bottom+2
	$pos.bottom:=$pos.top+$pos.height  // re-do the bottom
	$pos.width:=This:C1470.activeFinder.lbWidth  // re-size the WIDTH of the LB to be what is needed for the activeFinder
	$pos.right:=$pos.left+$pos.width  // and correct the RIGHT dimension
	OBJ_SET_OBJ_CHARACTERISTICS(This:C1470.lbName; $pos; _OB_Coordinates)  // and position the LB to this location 
	OBJ_SET_OBJ_CHARACTERISTICS(This:C1470.lbNameBox; $pos; _OB_Coordinates)  // and position the LB to this location 
	
	// set the lbFinder columns according to the specs in the .activeFinder
Function lbSetColumns()
	var $column : cs:C1710.FinderColumn
	For each ($column; This:C1470.activeFinder.columns)  // for each column definition
		$column.setLBColumn()  // get the FinderColumn to configure its column in the listBox
	End for each 
	
Function lbSetColVisibility()
	$lbColCount:=LISTBOX Get number of columns:C831(*; This:C1470.lbName)  // the number of configured columns in the LB_Finder
	For ($i; 1; $lbColCount)
		$isVisible:=($i<=This:C1470.activeFinder.columns.length)  // TRUE if the column will be visible.
		OBJECT SET VISIBLE:C603(*; This:C1470.lbColName($i); $isVisible)  // this will make the required number of columns visible
		If (Not:C34($isVisible))  // if it is hidden, shrink its column width too
			LISTBOX SET COLUMN WIDTH:C833(*; This:C1470.lbColName($i-1); 0)  // shrink columns before setting them correctly. This will effectively also make unused columns 'invisible'
		End if 
	End for 
	
Function fontColorExpression($row : Integer) : Variant  // the row color. This is the 'font color expression' that gets performed by the LB_Finder
	$0:=This:C1470.searchColors[$row]
	
Function lbFontColorExpression($row : Integer) : Variant  // give the color that applies to $row. Used inside font Expression for the listBox
	$matchLevel:=This:C1470.lbRowMatchLevel($row)  // this is the 'level' for this row
	$0:=This:C1470.activeFinder.searchColors[$matchLevel]  // and this is the RGB Color!
	
Function lbColName($index : Integer) : Text  // the name of the listbox column in LB_Finder
	$0:="LBCol"+String:C10($index)
	
Function matchCount() : Integer  // we have this as a function because This.LBFinder.es may be null, and we can't just .length it
	If (This:C1470.es#Null:C1517)  // if it is a valid entity selection
		$0:=This:C1470.es.length
	End if 
	
Function lbRowMatchLevel($lbRow : Integer) : Integer  // give the 'match level' that this row is part of
	//$0:=This.col_Matches.length-1  // assume it is in the LAST group
	var $i : Integer  // counter
	For ($i; This:C1470.col_Matches.length-1; 0; -1)  // go in reverse
		If ($lbRow<=This:C1470.col_Matches[$i])  // if it is in this level
			$0:=$i
		End if 
	End for 
/* —— This.LBFinder.col_Matches[ ] ———
PURPOSE: To assist with font expressions, meta expressions and the like. Currently we are just doing font expressions
ThisLBFinder.col_Matches[ x ] — the Last Row# that this group is.
So to compare, given an INDEX, it is part of the 'match group' that it is <= to
*/
Function lbInitMatches()  // initialize the .col_Matches[ ]
	var $i : Integer  // loop counter
	This:C1470.col_Matches.resize(This:C1470.activeFinder.searchFormulas.length)
	For ($i; 0; This:C1470.col_Matches.length-1)
		This:C1470.col_Matches[$i]:=0
	End for 
	//This.activeFinder.searchColors // consult this to determine the colors
	
Function configureLB()  // configure the listbox helper, which must exist on the form that the CONTAINER OBJECT is in
	This:C1470.lbRowHeight:=LISTBOX Get rows height:C836(*; This:C1470.lbName)  // so we will remember what the ROW HEIGHT is
	This:C1470.es:=ds:C1482[This:C1470.activeFinder.dClass].newSelection()  // make a new EMPTY selection based on our dataClass
	This:C1470.lbInitMatches()  // initialize the 'col_Matches', which notes how many matches at each level of the query
	This:C1470.lbSetColVisibility()  // set the 'visibility' of the listbox columns. Basically, we hide any unneeded columns
	This:C1470.lbSetColumns()  // define the columns in the LB_Finder
	This:C1470.lbSetPosition()  // set the position of the LB_Finder (directly under ourself)
	This:C1470.lbSetHeight()  // set the dimensions of the LB_Finder
	This:C1470.pickPosition:=0  // initialize to 'no choice'
	If (This:C1470.activeFinder.en=Null:C1517)  // if no .en to start, then make a new one
		//If (Undefined(This.activeFinder.en))  // if no .en to start, then make a new one   // [CB 05/18/2021] Remove Undefined]
		This:C1470.activeFinder.en:=ds:C1482.newEntity(This:C1470.activeFinder.dClass; Null:C1517)  // return a NEW entity. Then it is all ready for fresh input if desired
	End if 
	This:C1470.activeFinder.en_Prev:=This:C1470.activeFinder.en  // remember the previous choice, in case of CANCEL. We wait until here in case .en was not defined.
	This:C1470.lbSetVisibility(False:C215)  // hide the listBox
	
Function lbSetVisibility($isVisible : Boolean)  // show or hide the LBFinder
	If (This:C1470.activeFinder.maxRows<1)  // if the LB is always 'invisible' because we are not going to display any rows
		OBJECT SET VISIBLE:C603(*; This:C1470.lbName; False:C215)
		OBJECT SET VISIBLE:C603(*; This:C1470.lbNameBox; False:C215)
	Else   // there are maxRows and it is eligible to be shown
		$currently:=OBJECT Get visible:C1075(*; This:C1470.lbName)
		If ($currently#$isVisible)  // if the state needs to be toggled, do so
			OBJECT SET VISIBLE:C603(*; This:C1470.lbName; $isVisible)
			OBJECT SET VISIBLE:C603(*; This:C1470.lbNameBox; $isVisible)
		End if 
	End if 
	
Function doQuery()  // re-search the database, getting the candidates. They get into This.LBFinder.es. We also keep track of how many matches at each level, to simplify font expression
	This:C1470.es:=This:C1470.activeFinder.searchFormulas[0].call().orderBy(This:C1470.activeFinder.orderByText).copy()  // primary search.
	$matches:=This:C1470.es.length
	This:C1470.col_Matches[0]:=$matches
/* —— OPTIONAL: Secondary searches. ——
—— — additional searches can append results to the main results.TheseformulatsareinThis.searchFormulas[1+]————*/
	$level:=0
	For each ($search; This:C1470.activeFinder.searchFormulas; 1)  // starting at the 1st secondary search...
		$level:=$level+1  // this is the 'level' of matches
		$es_Secondary:=$search.call().minus(This:C1470.es).orderBy(This:C1470.activeFinder.orderByText)  // secondary search. It will be MINUS whatever is already in the list
		$matches:=$matches+$es_Secondary.length
		This:C1470.col_Matches[$level]:=$matches
		For each ($en; $es_Secondary)  // add the 'additional matches' one entity at a time
			This:C1470.es.add($en)  // append in the order in which they were. We do not '.or()' because this would screw up the ordering
		End for each 
	End for each 
	
Function lbPick($itemPos : Integer)  // select this pick in the listBox
	var $position : Integer  // the actual position that gets the selection
	$position:=MinValue($itemPos; This:C1470.matchCount())  // if there are no matches, $position becomes 0
	If ($position=0)
		LISTBOX SELECT ROW:C912(*; This:C1470.lbName; 0; lk remove from selection:K53:3)  // select NONE
	Else 
		LISTBOX SELECT ROW:C912(*; This:C1470.lbName; $position; lk replace selection:K53:1)  // select this row
	End if 
	OBJECT SET SCROLL POSITION:C906(*; This:C1470.lbName)  // ensure that the 'selection' is visible
	// —— we also need to make the 'selection' clear by making it .en. 
	// —— note: it is the activeFinder that needs to receive the .en ——
	If ($position=0)  // no matches; make a NEW entity
		This:C1470.activeFinder.en:=ds:C1482.newEntity(This:C1470.activeFinder.dClass; Null:C1517)  // return a NEW entity. Then it is all ready for fresh input if desired
	Else 
		//Form.FC.es_Selected is not reliable at this juncture; it is based on the previous .es
		//This.activeFinder.en:=This.FC.en  // should be this entity, but it will be incorrect
		This:C1470.activeFinder.en:=This:C1470.es[$position-1]  // should be this entity
	End if 
	This:C1470.pickPosition:=$itemPos  // I have to 'record' this since 4D does not update the listbox itemPos until sometime later
	
Function doUpdate()  // handle the 'update' function. We re-search the database, getting the candidates. Then we select the top one in the listBox
	This:C1470.lbSetVisibility(True:C214)  // show the LBFinder
	This:C1470.doQuery()  // update the .es
	This:C1470.lbSetHeight()  // and set the height of the listbox
	If (This:C1470.activeFinder.searchFor="")  // special case; no search text. We can display the selection, but not select any
		This:C1470.lbPick(0)  //  if there are no matches, the selection will be nothing
	Else 
		This:C1470.lbPick(1)  // try and pick the top one. if there are no matches, the selection will be nothing
	End if 
	
Function doPrevious()  // handle an 'up-arrow'
	If (This:C1470.pickPosition>1)  // if there is any way of 'going up' then do so
		This:C1470.lbPick(This:C1470.pickPosition-1)  // go 'up' one
	End if 
	
Function doNext()  // handle a 'down-arrow'
	If (This:C1470.pickPosition<This:C1470.es.length)  // if there is any way of 'going down' then do so
		This:C1470.lbPick(This:C1470.pickPosition+1)  // go 'down' one
	End if 
	
Function do($event : Object) : Object  // perform the operation (this is at the CONTAINER level). It receives the 'FORM Event'. The caller can see what event was handled
	Case of 
		: ($event.code=On Getting Focus:K2:7)
			This:C1470.activeFinderName:=$event.objectName  // we know the active finder because of this event.
			This:C1470.activeFinder:=This:C1470[This:C1470.activeFinderName]  // simplify access to the parameters of the active Finder
			EXECUTE METHOD IN SUBFORM:C1085(This:C1470.activeFinderName; "FC_Widget_Do"; *; _msg_FC_Edit)  // get the active finder to prepare for edit
			This:C1470.configureLB()  // configure the LB to help
			If (This:C1470.activeFinder.showAllOnEntry)  // if they want us to show all the 'records' immediately upon getting focus
				This:C1470.doUpdate(False:C215)  // this will end up selecting all, if they are doing a search with a wildcard. DO NOT Message the container
			End if 
			
		: ($event.code=_msg_FCC_TextChange)
			This:C1470.doUpdate()  // perform the update
			$event.code:=_msg_FCC_Update  // get the CONTAINER to know about the update.
			
		: ($event.code=_msg_FCC_Previous)
			This:C1470.doPrevious()
			$event.code:=_msg_FCC_Update  // get the CONTAINER to know about the update
			
		: ($event.code=_msg_FCC_Next)
			This:C1470.doNext()
			$event.code:=_msg_FCC_Update  // get the CONTAINER to know about the update
			
		: ($event.code=_msg_FCC_Select)
			
		: ($event.code=_msg_FCC_Update)
			
		: ($event.code=_msg_FCC_Cancel)
			This:C1470.activeFinder.en:=This:C1470.activeFinder.en_Prev  // restore the previous entity choice
			This:C1470.lbSetVisibility(False:C215)  // hide the listBox
			
		: ($event.code=On Losing Focus:K2:8)  // we are exiting
			This:C1470.lbSetVisibility(False:C215)  // hide the listBox
			This:C1470.activeFinderName:=""  // clear our Group's 'activeFinderName' to prevent weird things from potentially happening
			
		Else 
			
	End case 
	$0:=$event  // let the caller know what event we handled
	