Form:C1466.isCancel:=True:C214
CALL SUBFORM CONTAINER:C1086(_msg_FCC_Cancel)  // tell the CONTAINER that input was CANCELLED by the user (nothing should be updated)
//POST KEY(Tab)  // TAB OUT to force ending
// —— we cannot check for CR or TAB in this; those will cause us to LOSE FOCUS, invoking that part of this script –– NOTE
