//%attributes = {"invisible":true,"publishedWeb":true,"shared":true,"preemptive":"capable"}
// FirstDayOfWeek(Date) --> DATE ;  returns the first day of this date's week
var $1; $0 : Date
var $DayNumber : Integer
$DayNumber:=Day number:C114($1)
$0:=Add to date:C393($1; 0; 0; (-1*($DayNumber-1)))