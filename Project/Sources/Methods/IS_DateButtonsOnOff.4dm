//%attributes = {"invisible":true,"publishedWeb":true}
// IS_DateButtonsOnOff ( On Flag ; Choice Name )
#DECLARE($onFlag : Boolean; $choiceName : Text)  // ON or OFF (true or false); Widget being handled (_Is_DateEntry or IS_DatePicker)

var $onFlag : Boolean  // ON or OFF (True or False)
var $2 : Text  // the Widget being handled

If ($onFlag)  // the widget is getting focus; activate certain buttons
	If ($choiceName="Is_DateEntry")
		// for IS_DateEntry ———
		OBJECT SET VISIBLE:C603(*; "bumper@"; True:C214)  // enable the 'bumper' buttons to work
		OBJECT SET VISIBLE:C603(*; "@Arrow"; True:C214)  // enable the 'arrow' buttons to work
		OBJECT SET VISIBLE:C603(*; "btn_@"; True:C214)  // enable the 'btn_' buttons to work
		//End if 
	Else 
		// for IS_DatePicker ———
		OBJECT SET VISIBLE:C603(*; "Day@"; True:C214)  // enable the 'Day' buttons to work
		OBJECT SET VISIBLE:C603(*; "Week@"; True:C214)  // enable the 'Week' buttons to work
		OBJECT SET VISIBLE:C603(*; "Year@"; True:C214)  // enable the 'Year' buttons to work
		OBJECT SET VISIBLE:C603(*; "Month@"; True:C214)  // enable the 'Year' buttons to work
		OBJECT SET VISIBLE:C603(*; "dummy@"; True:C214)  // enable the 'dummy_accept' button to work
	End if 
	
Else   // the widget is losing focus; inactivate certain buttons
	If ($choiceName="Is_DateEntry")
		// for IS_DateEntry ———
		OBJECT SET VISIBLE:C603(*; "bumper@"; False:C215)  // disable the 'bumper' buttons 
		OBJECT SET VISIBLE:C603(*; "@Arrow"; False:C215)  // disable the 'arrow' buttons
		OBJECT SET VISIBLE:C603(*; "btn_@"; False:C215)  // disable the 'btn_' buttons 
		//End if 
	Else 
		// for IS_DatePicker ———
		OBJECT SET VISIBLE:C603(*; "Day@"; False:C215)  // disable the 'Day' buttons
		OBJECT SET VISIBLE:C603(*; "Week@"; False:C215)  // disable the 'Week' buttons
		OBJECT SET VISIBLE:C603(*; "Year@"; False:C215)  // disable the 'Year' buttons
		OBJECT SET VISIBLE:C603(*; "Month@"; False:C215)  // enable the 'Year' buttons to work
		OBJECT SET VISIBLE:C603(*; "dummy@"; False:C215)  // disable the 'dummy_accept' button
	End if 
End if 