Case of 
	: (Form event code:C388=On Load:K2:1)
		If (OB Is defined:C1231(Form:C1466; "yes"))  // adjust the name of the "OK" button if they provided an alternative
			OBJECT SET TITLE:C194(*; "bYes"; Form:C1466.yes)
		End if 
		If (OB Is defined:C1231(Form:C1466; "no"))  // adjust the name of the "CANCEL" button if they provided an alternative
			OBJECT SET TITLE:C194(*; "bNo"; Form:C1466.no)
		End if 
End case 