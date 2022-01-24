//%attributes = {"invisible":true,"publishedWeb":true,"shared":true,"preemptive":"capable"}
// FirstDayOfYear(Date) --> DATE ;  returns the first day of this date's year
var $1; $0 : Date
var $Month; $year; $day : Integer
$Month:=Month of:C24($1)
$0:=Add to date:C393($1; 0; (-1*$month)+1; 0)
$day:=Day of:C23($0)
$0:=Add to date:C393($0; 0; 0; (-1*$day)+1)
