//%attributes = {}
// FORM_GetNextEntryObjName( {ThisObjectName} ) —> NEXT OBJECT NAME;   If not given ThisObjectName, it will use OBJECT Get Name (and assume in context of an object script)
var $1; $thisObjName; $0 : Text
var $col_Objects : Collection
var $whereIAm : Integer

If (Count parameters:C259>0)  // if given an object name, use it. Otherwise use  OBJECT Get name
	$thisObjName:=$1
Else 
	$thisObjName:=OBJECT Get name:C1087
End if 

$col_Objects:=FORM_GetObjects/* get all of the objects, since we may have temporarily disabled the next one.   
collection of objects:.objName, .varPtr, .pageNo*/

$whereIAm:=colFind($col_Objects; "objName"; $thisObjName)

Case of 
	: ($whereIAm>=(($col_Objects.length)-1))  // if we are at the end, then go to the beginning
		$0:=$col_Objects[0].objName
		
	: ($whereIAm=-1)  // not found? Go to beginning
		$0:=$col_Objects[0].objName
		
	Else 
		$0:=$col_Objects[$whereIAm+1].objName
End case 

