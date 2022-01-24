Case of 
	: (Form event code:C388=On Load:K2:1)
		IS_DATEENTRY_INIT("formDate"; "entryDate")  // operate on .formDate; NEXT OBJECT name is entryDate
		
	: (Form event code:C388=_msgUpdate)
		BEEP:C151
		
End case 