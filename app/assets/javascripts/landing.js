var hasBG = typeof bgImage != 'undefined';
var bgDefaultColor = "#D1E0ff";


$( document ).ready(function() {

	if (hasBG) {
		$.backstretch( bgImage, {fade: 500});	
	} else {
		var bg = (typeof bgColor != 'undefined') ? bgColor : bgDefaultColor
		$( 'body' ).css( "background", bg );
	};

});