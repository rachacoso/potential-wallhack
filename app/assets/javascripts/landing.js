var hasBG = typeof bgImage != 'undefined';
var bgDefaultColor = "#D1E0ff";


$( document ).ready(function() {


// Background Img
	if (hasBG) {
		$.backstretch( bgImage, {fade: 500});	
	} else {
		var bg = (typeof bgColor != 'undefined') ? bgColor : bgDefaultColor
		$( 'body' ).css( "background", bg );
	};

// Date Picker
 
	$('.datepick').fdatepicker({
		format: "mm/yyyy",
		startView: 2,
		minViewMode: 2
	});

	// $('.datepick').fdatepicker({
	// 	changeMonth: true,
	// 	changeYear: true,
	// 	showButtonPanel: true,
	// 	dateFormat: 'MM yy',
	// 	onClose: function(dateText, inst) { 
	// 		var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	// 		var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	// 		$(this).datepicker('setDate', new Date(year, month, 1));
	// 	}
	// });
});
