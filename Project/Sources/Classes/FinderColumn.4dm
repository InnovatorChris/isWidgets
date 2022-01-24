// Class: FinderColumn.  Supports  Class: Finder. this is just a consistent way to create a 'column' definition
Class constructor($colNo : Integer; $theFormula : Text; $width : Integer; $dataType : Integer)
	This:C1470.colNo:=$colNo
	This:C1470.theFormula:=$theFormula
	This:C1470.width:=$width
	This:C1470.dataType:=$dataType
	This:C1470.colName:=This:C1470.lbColName($colNo)  // hard-code the columnName relative to the LB_Finder
	
	// duplicated from cs.Finder()
Function lbName : Text  // the name of our LB_Finder. Doing it this way for simplicity
	$0:="LB_Finder"
	
	// duplicated from cs.Finder()
Function lbColName($index : Integer) : Text  // the name of the listbox column in LB_Finder
	$0:="LBCol"+String:C10($index)
	
	
Function setLBColumn()  // configure our column in the listbox
	LISTBOX SET COLUMN WIDTH:C833(*; This:C1470.colName; This:C1470.width)  // size the column...
	LISTBOX SET COLUMN FORMULA:C1203(*; This:C1470.colName; This:C1470.theFormula; This:C1470.dataType)
	