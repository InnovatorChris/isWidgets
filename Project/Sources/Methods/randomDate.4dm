//%attributes = {}
var $1; $seedDate : Date
var $0 : Date  // result
If (Count parameters:C259>0)  // if a seed date was given...
	$0:=Add to date:C393($1; 0; 0; (Random:C100%150))
Else 
	$0:=Add to date:C393(Date:C102("2021-01-01"); 0; 0; (Random:C100%150))  // first 151 days of 2021
End if 