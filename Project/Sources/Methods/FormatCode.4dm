//%attributes = {"invisible":true,"publishedWeb":true,"shared":true,"preemptive":"capable"}
// FormatCode( Text ) --> Text. Converts the 'Text' format code to one that is usable by OBJECT SET FORMAT ( ).
/* For DATES and TIMES, the format code in OBJECT SET FORMAT ( ) must be char(longint). Not the value you would expect. Really weird.
Also, to avoid displaying 00/00/00, Blank if null date must be added.
To simplify the process, we create this method to 'translate' the textual name of the format code to one 4D can use in the call
*/

var $1; $0 : Text  // 'source' format code; 'destination' format code. Will be the same if the special date/time/picture ones are not used
$0:=$1  // assume we just return the format code as-is
var $result : Variant
var $formula : Object

If ($1#_Blank)  // if it is, then $0 will be BLANK too
	If (($1[[1]]#"!") & ($1[[1]]#"|"))
		If ((Position:C15("#"; $1)<1) & (Position:C15("("; $1)<1) & (Position:C15(")"; $1)<1) & (Position:C15("&"; $1)<1))  // if # ( ) or & are in the string, just return it as is
			$formula:=Formula from string:C1601($1)
			$result:=New object:C1471("myFormula"; $formula).myFormula()  // this is the translated code
			If (Value type:C1509($result)=Is longint:K8:6)
				$0:=Char:C90($result)
			Else 
				$0:=$result
			End if 
		End if 
	End if 
End if 