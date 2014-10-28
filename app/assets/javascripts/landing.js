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



// Sector/Channel - Select All & Other functionality

	// Sector

  $('#selectallsectors').click(function(event) {  //on click 
      if(this.checked) { // check select status
	      	$('#sectors_other').each(function() { //loop through each checkbox
              this.checked = false; //deselect checkboxes with id "sectors_other"                       
          });
          $('.sectors').each(function() { //loop through each checkbox
              this.checked = true;  //select all checkboxes with class "sectors"               
          });
          
      }else{
          $('.sectors').each(function() { //loop through each checkbox
              this.checked = false; //deselect all checkboxes with class "sectors"                       
          });         
      }
  });

  $('.sectors').click(function(event) {  //on click of ANY SECTOR - make sure OTHER deselected
      if(this.checked) { // check select status
	      	$('#sectors_other').each(function() { //loop through each checkbox
              this.checked = false; //deselect all checkboxes with id "sectors_other"                       
          });
      }
  });
    
  $('#sectors_other').click(function(event) {  //on click of 'OTHER' SECTOR
      if(this.checked) { // check select status
          $('.sectors').each(function() { //loop through each checkbox
              this.checked = false;  //select all checkboxes with class "sectors"               
          });
      }
  });

  // Channels

  $('#selectallchannels').click(function(event) {  //on click 
      if(this.checked) { // check select status
          $('.channels').each(function() { //loop through each checkbox
              this.checked = true;  //select all checkboxes with class "checkbox1"               
          });
      }else{
          $('.channels').each(function() { //loop through each checkbox
              this.checked = false; //deselect all checkboxes with class "checkbox1"                       
          });         
      }
  });


});


// Adding Custom Channels

$(document).ready(function() {

    $('#btnSave').click(function() {
      addCheckbox($('#ccName').val());
    });

		$('#customchannellist').on( "click", "input", function() {
		  $( this ).parent('span').remove();
		});

		$('#ccName').on('click focusin', function() {
	    this.value = '';
		});

});

function addCheckbox(name) {
	var container = $('#customchannellist');
	var inputs = container.find('input');
	var id = inputs.length+1;

	$('<span />', { id: 'ccspan'+id }).appendTo(container)
	$('<input />', { type: 'checkbox', id: 'cb'+id, value: name, name: 'customchannels['+id+']', checked: 'checked', class: 'customchannelinput' }).appendTo( '#' + 'ccspan' + id );
	$('<label />', { 'for': 'cb'+id, text: name }).appendTo( '#' + 'ccspan' + id );
}




