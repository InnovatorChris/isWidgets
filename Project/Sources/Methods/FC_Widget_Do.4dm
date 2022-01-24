//%attributes = {"shared":true}
// FC_Widget_Do( message ) —   FINDER WIDGET HELPER
/* we need to use a METHOD to communicate with our Finder Widget, because we cannot use a class function or formula
NOTE: This happens in the context of the FINDER WIDGET, so Form. is our FC Object
*/
var $1 : Integer  // avoided #DECLARE() because it seems flakey
Form:C1466.doWidget($1)
