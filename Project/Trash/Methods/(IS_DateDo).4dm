//%attributes = {"invisible":true,"publishedWeb":true}
/* IS_DateDo( AttributeName; Placeholder Text; Form Event Code ) — These parameters are meaningful only in initialization.
Handle the intricacies of the date entry, including enabling/disabling buttons and shortcuts
—— works for both the IS_DateEntry and IS_DatePicker widgets.*/
var $1; $2 : Text  // Attribute Name; Placeholder Text
var $3 : Integer  // the form event code (from the container)
Case of 
	: ($3=On Load:K2:1)  // 
		IS_DATEENTRY_INIT($1; $2)  // initialize this input area
		
	: ($3=On Getting Focus:K2:7)  // the widget is getting focus; activate certain buttons
		// for IS_DateEntry ———
		OBJECT SET ENABLED:C1123(*; "bumper@"; True:C214)  // enable the 'bumper' buttons to work
		OBJECT SET ENABLED:C1123(*; "@Arrow"; True:C214)  // enable the 'arrow' buttons to work
		OBJECT SET ENABLED:C1123(*; "btn_@"; True:C214)  // enable the 'btn_' buttons to work
		
		// for IS_DatePicker ———
		OBJECT SET ENABLED:C1123(*; "Day@"; True:C214)  // enable the 'Day' buttons to work
		OBJECT SET ENABLED:C1123(*; "Week@"; True:C214)  // enable the 'Week' buttons to work
		OBJECT SET ENABLED:C1123(*; "Year@"; True:C214)  // enable the 'Year' buttons to work
		OBJECT SET ENABLED:C1123(*; "dummy@"; True:C214)  // enable the 'dummy_accept' button to work
		
		
	: ($3=On Losing Focus:K2:8)  // the widget is losing focus; inactivate certain buttons
		// for IS_DateEntry ———
		OBJECT SET ENABLED:C1123(*; "bumper@"; False:C215)  // disable the 'bumper' buttons 
		OBJECT SET ENABLED:C1123(*; "@Arrow"; False:C215)  // disable the 'arrow' buttons
		OBJECT SET ENABLED:C1123(*; "btn_@"; False:C215)  // disable the 'btn_' buttons 
		
		// for IS_DatePicker ———
		OBJECT SET ENABLED:C1123(*; "Day@"; False:C215)  // disable the 'Day' buttons
		OBJECT SET ENABLED:C1123(*; "Week@"; False:C215)  // disable the 'Week' buttons
		OBJECT SET ENABLED:C1123(*; "Year@"; False:C215)  // disable the 'Year' buttons
		OBJECT SET ENABLED:C1123(*; "dummy@"; False:C215)  // disable the 'dummy_accept' button
End case 