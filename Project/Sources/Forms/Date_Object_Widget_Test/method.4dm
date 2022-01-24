// Form Method: Date_WidgetTester (Colonel)
var date1_Var; date2_Var : Date
var YM1_Var; YM2_Var : Integer

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		Form:C1466.myEntity:=New object:C1471("Name"; "Chris"; "formDate"; Current date:C33; "entryDate"; Current date:C33-20; "formPicker1"; Current date:C33-2; "formPicker2"; Current date:C33+2)
		date1_Var:=!2016-09-04!
		date2_Var:=!2017-11-19!
End case 