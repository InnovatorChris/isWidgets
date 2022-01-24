Case of 
	: (Form event code:C388=On Load:K2:1)
		IS_DATEENTRY_INIT("entryDate"; "procDate1")  // operate on .entryDate; NEXT OBJECT name is procDate1
		
	: (Form event code:C388=_msgUpdate)
		BEEP:C151
		
		
		
End case 