// When a different entity is used, then you must 'nudge' the widget to update its value.
// changing the dates to simulate a change in entity
// NOTE: randomDate( ) is not a useful project method for anything other than this demo
Form:C1466.myEntity.formDate:=randomDate(Form:C1466.myEntity.formDate)
Form:C1466.myEntity.entryDate:=randomDate(Form:C1466.myEntity.entryDate)
Form:C1466.myEntity.formPicker1:=randomDate(Form:C1466.myEntity.formPicker1)
Form:C1466.myEntity.formPicker2:=randomDate(Form:C1466.myEntity.formPicker2)

var date1_Var; date2_Var : Date  // 4D was throwing an error in the component because this var is not initialized until later (in the Form ON LOAD)
date1_Var:=randomDate(date1_Var)
date2_Var:=randomDate(date2_Var)

IS_DATEENTRY_REFRESH("formDate")  // NOTE: On Bound Variable Changed does not trigger when the 'entity 'changes, so we need to induce the refresh
IS_DATEENTRY_REFRESH("entryDate")
//IS_DATEENTRY_REFRESH("procDate1") // ... however, On Bound Variable Changed DOES execute when a process variable changes, so we do not need to induce the refresh
//IS_DATEENTRY_REFRESH("procDate2")
IS_DATEPICKER_REFRESH("formDate_Picker")  // NOTE: On Bound Variable Changed does not trigger when the 'entity 'changes, so we need to induce the refresh
IS_DATEPICKER_REFRESH("entryDate_Picker")
