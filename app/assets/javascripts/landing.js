var hasBG = typeof bgImage != 'undefined';
var bgDefaultColor = "#FFFEF7";


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

	// Select all on focus (note: makes it so that one can't select a part of an input, 
	// but can only ever select all... shouldn't be a problem, hopefully??)
	$('.country-autocomplete, .country-autocomplete-multi').on('focus',
		function (e) {
			$(this).on('mouseup',
				function() {
					$(this).select();
					return false;
				})
			.select();
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


	$('#login').on('click', Foundation.utils.debounce(function(e){
	  $("#loginform").fadeToggle();
	}, 300, true));


});






