//%attributes = {"invisible":true,"publishedWeb":true}
// FO_Get ( RequestConstant; { FormName ; { pageNo }} ) -->  Object
#DECLARE($reqNo : Integer; $formName : Text; $pageNo : Integer)->$result : Variant
/*      $reqNo         — the type of form information requested
       $formName — name of Form (for _FO_Properties and _FO_Screenshot)
       $pageNo      — page number
»   $result          — may be an OBJECT or a COLLECTION or a PICTURE
*/
ARRAY TEXT:C222($arr_Names; 0)  // some things we retrieve using an array
ARRAY POINTER:C280($arr_varPtrs; 0)  // variables pointer array
ARRAY LONGINT:C221($arr_Pages; 0)  // page numbers array
var $collect : Collection  // a collection that we use
var $resize : Boolean
var $max; $min : Integer

Case of 
	: ($reqNo=_FO_EntryOrder)  // Get Form Entry Order    — FO_Get ( _FO_EntryOrder; {pageNo} )
		If (Count parameters:C259>2)  // given a page number?
			FORM GET ENTRY ORDER:C1469($arr_Names; $pageNo)
		Else 
			FORM GET ENTRY ORDER:C1469($arr_Names)
		End if 
		ARRAY TO COLLECTION:C1563($collect; $arr_Names)
		$result:=$collect
		
	: ($reqNo=_FO_Resizing)  // Get the Form Resizing   .horiz { .resize  .min  .max }  .vert { .resize  .min  .max }    — FO_Get ( _FO_Resizing )
		FORM GET HORIZONTAL RESIZING:C1077($resize; $min; $max)
		$result:=New object:C1471("horiz"; New object:C1471("resize"; $resize; "min"; $min; "max"; $max))
		FORM GET VERTICAL RESIZING:C1078($resize; $min; $max)
		$result.vert:=New object:C1471("resize"; $resize; "Min"; $min; "Max"; $max)
		
	: ($reqNo=_FO_Objects)  // get the FORM OBJECTS    — FO_Get ( _FO_Objects; {formPageOption} )
		// formPageOption:  1=Form current page,  2=Form all pages,  4=Form inherited
		If (Count parameters:C259=1)
			FORM GET OBJECTS:C898($arr_Names; $arr_varPtrs; $arr_Pages)
		Else 
			FORM GET OBJECTS:C898($arr_Names; $arr_varPtrs; $arr_Pages; $pageNo)
		End if 
		$collect:=New collection:C1472
		For ($i; 1; Size of array:C274($arr_Names))  // now concoct a collection of object information
			$collect.push(New object:C1471("name"; $arr_Names{$i}; "ptr"; $arr_varPtrs; "pageNo"; $arr_Pages{$i}))
		End for 
		$result:=$collect  // return the collection of object information!
		
	: ($reqNo=_FO_Properties)  // get the FORM PROPERTIES   .name (form name)   .width  .height  .numPages  .isFixedWidth  .isFixedHeight  .title
		var $width; $height; $numPages : Integer
		var $fixedHeight; $fixedWidth : Boolean
		var $title : Text
		FORM GET PROPERTIES:C674($formName; $width; $height; $numPages; $fixedWidth; $fixedHeight; $title)
		$result:=New object:C1471("name"; $formName; "width"; $width; "height"; $height; "numPages"; $numPages; "fixedWidth"; $fixedWidth; "fixedHeight"; $fixedHeight; "title"; $title)
		
	: ($reqNo=_FO_Screenshot)  // get a SCREENSHOT of formName (form editor version) or current form.  FO_Get(_FO_ScreenShot; {formName ; {pageNumber}} )
		var $formPict : Picture
		If (Count parameters:C259>1)  // if caller supplied name of a form
			If (Count parameters:C259>2)  // if they gave a page number
				FORM SCREENSHOT:C940($formName; $formPict; $pageNo)
			Else 
				FORM SCREENSHOT:C940($formName; $formPict)
			End if 
		Else   // currently-displayed form
			FORM SCREENSHOT:C940($formPict)
		End if 
		$result:=$formPict  // return the PICTURE
		
End case 