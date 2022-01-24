//%attributes = {"invisible":true,"publishedWeb":true,"shared":true,"preemptive":"capable"}
// ArrayToCollection( ->Array ) --> Collection
var $1 : Pointer  // the ->Array
var $0 : Collection  // the array converted to a collection
C_POINTER:C301($1)
C_COLLECTION:C1488($0)
$0:=New collection:C1472
For ($i; 1; Size of array:C274($1->))
	$0.push($1->{$i})
End for 