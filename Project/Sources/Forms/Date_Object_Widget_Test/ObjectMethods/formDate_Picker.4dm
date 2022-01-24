Case of 
	: (Form event code:C388=On Load:K2:1)
		IS_DATEPICKER_INIT("formPicker1")  // initialize the datePicker widget. Since the bound var is a DATE, we do not need to give any other information
		
	: (Form event code:C388=_msgUpdate)
		BEEP:C151
End case 