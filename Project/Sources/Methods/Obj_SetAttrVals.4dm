//%attributes = {"shared":true}
// Obj_SetAttrVals(Object (can be an ENTITY); Object: Settings ) --> For the given object, set specific Attributes to values, as defined in Settings
var $1; $2 : Object  // Destination Object / Entity ;  Settings Object { Attribute: Value }. Each Attribute must be a member attribute of the entity
var $i : Integer
var $col_Properties : Collection  // the Properties of the Settings Object
var $attr : Text

$col_Properties:=colGetPropertyNames($2)  // these are the attributes
For ($i; 0; $col_Properties.length-1)
	$attr:=$col_Properties[$i]
	
	If (Not:C34(Undefined:C82($1[$attr])))  // if this attribute actually exists in the record...
		If (Value type:C1509($1[$attr])=Is object:K8:27)  // if they want us to set an OBJECT FIELD, we just make the mod without comparing  ( = does not work between objects)
			$1[$attr]:=$2[$attr]  // copy it to the entity!
		Else 
			If ($1[$attr]#$2[$attr])  // conditionally set the attribute's value, depending on if it is different. This way we avoid triggering .touched() unnecessarily
				$1[$attr]:=$2[$attr]  // copy it to the entity!
			End if 
		End if 
	Else 
		ALERT:C41("Programming Error: EntitySetAttrVals given a default attribute that does not exist: "+$attr; "EntityNew")
	End if 
End for 
