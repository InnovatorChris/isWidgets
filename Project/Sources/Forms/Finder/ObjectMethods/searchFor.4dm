// inputText Object
Case of 
	: (Form event code:C388=On Getting Focus:K2:7)
		//Self->:=Form.searchFor  // this is the text we are to search for. In case it was updated somewhere since last time we displayed it, we default it
		Form:C1466.isCancel:=False:C215  // assume that the input will NOT be cancelled
		Form:C1466.isChanged:=False:C215  // we also tell the caller if the value here was changed
		If (Is macOS:C1572)
			If (Not:C34(Bool:C1537(Form:C1466.isDoNotDraw)))  // if we are NOT told to override drawing
				OBJECT SET VISIBLE:C603(*; "mac_Focus@"; True:C214)
			End if 
		End if 
		OBJECT SET VISIBLE:C603(*; "LB_Browser"; (Form:C1466.maxRows>0))  // show it if we have some 'maxRows' set. If it is less than 1, then it is 'invisible'
		
	: (Form event code:C388=On Losing Focus:K2:8)
		If (Is macOS:C1572)
			OBJECT SET VISIBLE:C603(*; "mac_Focus@"; False:C215)
		End if 
		Self:C308->:=""  // clear our search value out
		
	: (Form event code:C388=On After Keystroke:K2:26)
		C_LONGINT:C283($keyCode; $textLength)  // keycode entered; length of the text input to this point
		$keyCode:=Character code:C91(Keystroke:C390)
		Case of 
			: ($keyCode=Up arrow key:K12:18)
				CALL SUBFORM CONTAINER:C1086(_msg_FCC_Previous)  // tell the CONTAINER to select the PREVIOUS entry in the LB_Search (if applicable)
				$textLength:=Length:C16(Get edited text:C655)  // this is the current size of our inputText object's input
				HIGHLIGHT TEXT:C210(*; "searchFor"; $textLength+1; $textLength+1)  // keep the highlight at the end (otherwise up arrow puts it to the front)
				
			: ($keyCode=Down arrow key:K12:19)
				CALL SUBFORM CONTAINER:C1086(_msg_FCC_Next)  // tell the CONTAINER to select the NEXT entry in the LB_Search (if applicable)
				
		End case 
		
		
	: (Form event code:C388=On After Edit:K2:43)  // after any change has been made to the text
		If (Form:C1466.searchFor#Get edited text:C655)
			Form:C1466.searchFor:=Get edited text:C655  // update this so we can compare next time
			Form:C1466.isChanged:=True:C214  // so caller will know the search was changed (particularly when they move away from the search)
			CALL SUBFORM CONTAINER:C1086(_msg_FCC_TextChange)  // tell the CONTAINER (which will then get processed in cs.FinderGroup.do( ) ) that the Text has been changed (selection will be re-done)
		End if 
End case 
