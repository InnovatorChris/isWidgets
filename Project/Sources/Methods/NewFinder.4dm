//%attributes = {"shared":true}
#DECLARE($finderGroup : cs:C1710.FinderGroup; $containerName : Text; $dClass : Text; $maxRows : Integer; $placeHolder : Text; $columns : Collection; $orderBy : Text; $col_QuerySpecs : Collection; $isShowAllOnEntry : Boolean; $isDoNotDraw : Boolean)->$finder : cs:C1710.Finder
$finder:=cs:C1710.Finder.new($finderGroup; $containerName; $dClass; $maxRows; $placeHolder; $columns; $orderBy; $col_QuerySpecs; $isShowAllOnEntry; $isDoNotDraw)
