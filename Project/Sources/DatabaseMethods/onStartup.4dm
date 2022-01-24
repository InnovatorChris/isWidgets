If (Not:C34(Is compiled mode:C492))
	
	ARRAY TEXT:C222($tTxt_components; 0x0000)
	COMPONENT LIST:C1001($tTxt_components)
	
	If (Find in array:C230($tTxt_components; "4DPop")>0)
		
		EXECUTE METHOD:C1007("4DPop_Palette")
		
	End if 
End if 
