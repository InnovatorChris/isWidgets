/* NOTE: If you use a process variable as a datasource, the variable must be 'known' by 4D BEFORE  IS_DATEENTRY_INIT( ) is called.
otherwise 4D may thrown an error message 'bad usage of pointer...to an unknown variable' (interpreted mode only)
If the variable is defined, there is no error*/
var date2_Var : Date  // 4D was throwing an error in the component because this var is not initialized until later (in the Form ON LOAD)
Case of 
	: (Form event code:C388=On Load:K2:1)
		IS_DATEENTRY_INIT(""; "formDate")  // operate on process var (dataSource); NEXT OBJECT name is formDate
		
	: (Form event code:C388=_msgUpdate)
		BEEP:C151
		
End case 