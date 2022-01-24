//%attributes = {"invisible":true,"publishedWeb":true,"preemptive":"capable"}
// colGetPropertyNames( OBJECT ) --> COLLECTION containing the property names
var $1 : Object  // if we are checking out a COLLECTION, then just pass $col[0] assuming it exists
var $0 : Collection  // the collection containing the properties names for OBJECT
ARRAY TEXT:C222($props; 0)  // how the properties
$0:=New collection:C1472  // we have an empty collection if there are no objects in it

If ($1#Null:C1517)  // if we can even see any...
	OB GET PROPERTY NAMES:C1232($1; $props)
	ARRAY TO COLLECTION:C1563($0; $props)  // convert the ARRAY to a collection!
End if 
