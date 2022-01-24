//%attributes = {"invisible":true,"publishedWeb":true,"shared":true,"preemptive":"capable"}
// MinValue ( val1; val2; val3 ... ) --> Min.  Works for any scalar value type
C_VARIANT:C1683($0; ${1})  // all are variants

$0:=$1  // assume this is the max
For ($i; 2; Count parameters:C259)
	If (${$i}<$0)
		$0:=${$i}
	End if 
End for 
