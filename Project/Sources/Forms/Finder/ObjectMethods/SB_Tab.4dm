If (Form:C1466.searchFor=_Blank)  // if nothing in this, cancel
	CALL SUBFORM CONTAINER:C1086(_msg_FCC_Cancel)
Else 
	CALL SUBFORM CONTAINER:C1086(_msg_FCC_Select)  // tell the CONTAINER to select the SELECT the entry in the LB_Search (if applicable)
End if 
//POST KEY(Tab)  // TAB OUT to force ending
// —— we cannot check for CR or TAB in this; those will cause us to LOSE FOCUS, invoking that part of this script –– NOTE

//Form.isCancel:=True
//CALL SUBFORM CONTAINER(_msg_FCC_Cancel)  // tell the CONTAINER that input was CANCELLED by the user (nothing should be updated)
//// —— we cannot check for CR or TAB in this; those will cause us to LOSE FOCUS, invoking that part of this script –– NOTE
