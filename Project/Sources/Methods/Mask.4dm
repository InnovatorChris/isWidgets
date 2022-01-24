//%attributes = {"invisible":true,"publishedWeb":true,"shared":true,"preemptive":"capable"}
// Mask ( Text ; Mask ) --> Masked Text. Any extraneous 'Mask' characters are removed
var $1; $2 : Text  // the text, the mask
var $0 : Text  // the result
var $col_Str : Collection
var $char : Text
var $pos_Hash : Integer  // position of the first remaining '#' (if any)

If ($1#_Blank)
	$0:=$2  // seed it
	$col_Str:=Split string:C1554($1; "")
	
	For each ($char; $col_Str)
		$0:=Replace string:C233($0; "#"; $char; 1)
	End for each 
	
	$pos_Hash:=Position:C15("#"; $0)
	If ($pos_Hash>0)  // if the hash mark was found, delete the rest of the mask stuff
		$0:=Substring:C12($0; 1; $pos_Hash-1)  // strip off the rest of the mask from the result
	End if 
	
End if 