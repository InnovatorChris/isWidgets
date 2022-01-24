//%attributes = {}
// FORM_GetObjects( {pageNo} ) --> COLLECTION [ { .objName; .varPtr; .pageNo } ]   ——> Get the entryOrder in a collection of objects
var $1; $pageNo : Integer
var $0 : Collection  // collection of objects with attributes. // the collection of the object names, in order
var $pageNo : Integer

If (Count parameters:C259>0)  // if given a page number, use it. Otherwise default to current page
	$pageNo:=$1
Else 
	$pageNo:=FORM Get current page:C276
End if 

$0:=New collection:C1472
ARRAY TEXT:C222($arr_Objects; 0)
ARRAY POINTER:C280($arr_Vars; 0)
ARRAY LONGINT:C221($arr_Pages; 0)

FORM GET OBJECTS:C898($arr_Objects; $arr_Vars; $arr_Pages; Form all pages:K67:7)

var $include : Boolean
For ($i; 1; Size of array:C274($arr_Objects))
	$include:=True:C214  // assume we should include this object
	If ($pageNo#0)  // if they specifically only want page 0 & $pageNo
		$include:=(($arr_Pages{$i}=0) | ($arr_Pages{$i}=$pageNo))
	End if 
	If ($include)
		$0.push(New object:C1471("objName"; $arr_Objects{$i}; "varPtr"; $arr_Vars{$i}; "pageNo"; $arr_Pages{$i}))
	End if 
End for 