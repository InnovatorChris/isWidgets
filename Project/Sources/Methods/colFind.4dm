//%attributes = {}
// colFind(collection;attributeName;Textvalue) --> int; -1 if not found
var $1 : Collection
var $2; $3 : Text  // attribute name; the text value
var $0 : Integer  // the  RESULT —> int; -1 if not found
var $idx; $found : Integer  // used the figure out if it was found
var $guy : Object
$found:=-1  // assume it is not found

For each ($guy; $1) Until ($found>-1)  // stop the iterations as sound as $found is >-1  (i.e. the searched-for value has been located)
	$val:=$guy[$2]
	If ($val=$3)
		$found:=$idx
	End if 
	$idx:=$idx+1
End for each 

$0:=$found  // based on 0-starting sequencing. -1 means not found, which is the default condition  { $found:=-1 above }