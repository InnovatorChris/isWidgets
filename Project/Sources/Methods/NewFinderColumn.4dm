//%attributes = {"shared":true}
#DECLARE($colNo : Integer; $formula : Text; $width : Integer; $valueType : Integer)->$finderCol : cs:C1710.FinderColumn
$finderCol:=cs:C1710.FinderColumn.new($colNo; $formula; $width; $valueType)
