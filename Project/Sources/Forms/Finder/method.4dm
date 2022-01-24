Case of 
	: (Form event code:C388=On Activate:K2:9)  // activate the 'helper buttons'
		OBJECT SET ENABLED:C1123(*; "SB_CancelBtn"; True:C214)
		OBJECT SET VISIBLE:C603(*; "SB_CancelBtn"; True:C214)
		OBJECT SET ENABLED:C1123(*; "SB_YesButton"; True:C214)
		OBJECT SET VISIBLE:C603(*; "SB_YesButton"; True:C214)
		OBJECT SET ENABLED:C1123(*; "SB_Tab"; True:C214)
		OBJECT SET VISIBLE:C603(*; "SB_Tab"; True:C214)
		OBJECT SET ENABLED:C1123(*; "SB_ShiftTab"; True:C214)
		OBJECT SET VISIBLE:C603(*; "SB_ShiftTab"; True:C214)
		EDIT ITEM:C870(*; "searchFor")  // go to the searcher
		
	: (Form event code:C388=On Deactivate:K2:10)
		OBJECT SET ENABLED:C1123(*; "SB_CancelBtn"; False:C215)  // disable the buttons
		OBJECT SET VISIBLE:C603(*; "SB_CancelBtn"; False:C215)
		OBJECT SET ENABLED:C1123(*; "SB_YesButton"; False:C215)
		OBJECT SET VISIBLE:C603(*; "SB_YesButton"; False:C215)
		OBJECT SET ENABLED:C1123(*; "SB_Tab"; False:C215)
		OBJECT SET VISIBLE:C603(*; "SB_Tab"; False:C215)
		OBJECT SET ENABLED:C1123(*; "SB_ShiftTab"; False:C215)
		OBJECT SET VISIBLE:C603(*; "SB_ShiftTab"; False:C215)
End case 
