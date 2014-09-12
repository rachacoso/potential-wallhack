var hasBG = typeof bgImage != 'undefined';
var bgDefaultColor = "#D1E0ff";


$( document ).ready(function() {

// for autocomplete
var countriesArray = $.map(countries, function (value, key) { return { value: value, data: key }; });

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

	$('.datepick_full').fdatepicker({
		format: "dd/mm/yyyy",
		startView: 2,
		minViewMode: 2
	});


	// Autocomplete 

	$('.country-autocomplete').focus(function() {
	   $(this).val('');
	});

	$('.country-autocomplete').devbridgeAutocomplete({
		lookup: countriesArray,
		minChars: 0,
		// delimiter: ',',
		// onSelect: function (suggestion) {
		//     // $('#selection').html('You selected: ' + suggestion.value + ', ' + suggestion.data);
		//     $('#<%=id_name%>_selected').val(suggestion.data);
		// },
		showNoSuggestionNotice: true,
		noSuggestionNotice: 'Sorry, no matching results',
		tabDisabled: true
	});

	$('.country-autocomplete-multi').devbridgeAutocomplete({
		lookup: countriesArray,
		minChars: 0,
		delimiter: ', ',
		// onSelect: function (suggestion) {
		//     // $('#selection').html('You selected: ' + suggestion.value + ', ' + suggestion.data);
		//     $('#<%=id_name%>_selected').val(suggestion.data);
		// },
		showNoSuggestionNotice: true,
		noSuggestionNotice: 'Sorry, no matching results',
		tabDisabled: true
	});

});




