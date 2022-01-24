//%attributes = {"invisible":true,"publishedWeb":true,"shared":true,"preemptive":"capable"}
// FirstDayOfMonth(Date) --> DATE ;  returns the first day of this date's month
var $1; $0 : Date
var $DayOfMonth : Integer
$DayOfMonth:=Day of:C23($1)
$0:=Add to date:C393($1; 0; 0; ((-1*$DayOfMonth)+1))
