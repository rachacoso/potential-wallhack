var hasBG = typeof bgImage != 'undefined';
var bgDefaultColor = "#FFFFFF";


$( document ).ready(function() {

// MODIFICATIONS FOR NO SVG SUPPORT
  if(!Modernizr.svg) {
    /* swap png for svgs */
    $('img[src*="svg"]').attr('src', function () {
    return $(this).attr('src').replace('.svg', '.png');
    });
  }

// FOR AJAX FORM SUBMIT LOADING MODAL

/* STILL NOT WORKING NEED TO FIX */

// $('.ajax-form').on('submit', function(e) {
//     $('#loading-modal').foundation('reveal', 'open');
// });


// for background map on matches
  var divWidth = $('#match-map-container').width();
  var setHeight = divWidth / 1.9;
  $('#match-map-container').height( setHeight );

  $(window).on('resize', function(e){
    var divWidth = $('#match-map-container').width();
    var setHeight = divWidth / 1.9;
    $('#match-map-container').height( setHeight );
  });



// for autocomplete
  var countriesArray = $.map(countries, function (value, key) { return { value: value, data: key }; });

// Background Img
	// if (hasBG) {
	// 	$.backstretch( bgImage, {fade: 500});	
	// } else {
	// 	var bg = (typeof bgColor != 'undefined') ? bgColor : bgDefaultColor
	// 	$( 'body' ).css( "background", bg );
	// };

  // FOR FORM COUNTRY AND DATE FIELDS
  initialize();


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

  $('.sectors').click(function(event) {  //on click of ANY SECTOR - make sure OTHER & SELECT ALL deselected
      if(this.checked) { // check select status
      	$('#sectors_other').each(function() { //loop through each checkbox
            this.checked = false; //deselect all checkboxes with id "sectors_other"                       
        });        
      }
    	$('#selectallsectors').each(function() { //loop through each checkbox
          this.checked = false; //deselect all checkboxes with id "sectors_other"                       
      });        
  });
    
  $('#sectors_other').click(function(event) {  //on click of 'OTHER' SECTOR
      if(this.checked) { // check select status
          $('.sectors,#selectallsectors').each(function() { //loop through each checkbox
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

  $('.channels').click(function(event) {  //on click of ANY CHANNEL - make sure SELECT ALL deselected
    	$('#selectallchannels').each(function() { //loop through each checkbox
          this.checked = false; //deselect all checkboxes with id "sectors_other"                       
      });        
  });



  // MATCHING FILTERS



  //Countries
  $('#selectallcountries').click(function(event) {  //on click 
      if(this.checked) { // check select status
          $('.mfcountry').each(function() { //loop through each checkbox
              this.checked = true;  //select all checkboxes with class "checkbox1"               
          });
      }else{
          $('.mfcountry').each(function() { //loop through each checkbox
              this.checked = false; //deselect all checkboxes with class "checkbox1"                       
          });         
      }
  });

  $('.mfcountry').click(function(event) {  //on click of ANY CHANNEL - make sure SELECT ALL deselected
    	$('#selectallcountries').each(function() { //loop through each checkbox
          this.checked = false; //deselect all checkboxes with id "sectors_other"                       
      });        
  });

  //Countries of Distribution
  $('#selectallcountriesofdistro').click(function(event) {  //on click 
      if(this.checked) { // check select status
          $('.mfcountryofdistro').each(function() { //loop through each checkbox
              this.checked = true;  //select all checkboxes with class "checkbox1"               
          });
      }else{
          $('.mfcountryofdistro').each(function() { //loop through each checkbox
              this.checked = false; //deselect all checkboxes with class "checkbox1"                       
          });         
      }
  });

  $('.mfcountryofdistro').click(function(event) {  //on click of ANY CHANNEL - make sure SELECT ALL deselected
      $('#selectallcountriesofdistro').each(function() { //loop through each checkbox
          this.checked = false; //deselect all checkboxes with id "sectors_other"                       
      });        
  });

  //Sizes
  $('#selectallsizes').click(function(event) {  //on click 
      if(this.checked) { // check select status
          $('.mfsize').each(function() { //loop through each checkbox
              this.checked = true;  //select all checkboxes with class "checkbox1"               
          });
      }else{
          $('.mfsize').each(function() { //loop through each checkbox
              this.checked = false; //deselect all checkboxes with class "checkbox1"                       
          });         
      }
  });

  $('.mfsize').click(function(event) {  //on click of ANY CHANNEL - make sure SELECT ALL deselected
    	$('#selectallsizes').each(function() { //loop through each checkbox
          this.checked = false; //deselect all checkboxes with id "sectors_other"                       
      });        
  });

  //Sectors
  $('#selectallsectors').click(function(event) {  //on click 
      if(this.checked) { // check select status
          $('.mfsector').each(function() { //loop through each checkbox
              this.checked = true;  //select all checkboxes with class "checkbox1"               
          });
      }else{
          $('.mfsector').each(function() { //loop through each checkbox
              this.checked = false; //deselect all checkboxes with class "checkbox1"                       
          });         
      }
  });

  $('.mfsector').click(function(event) {  //on click of ANY CHANNEL - make sure SELECT ALL deselected
    	$('#selectallsectors').each(function() { //loop through each checkbox
          this.checked = false; //deselect all checkboxes with id "sectors_other"                       
      });        
  });

  //Channels
  $('#selectallchannels').click(function(event) {  //on click 
      if(this.checked) { // check select status
          $('.mfchannel').each(function() { //loop through each checkbox
              this.checked = true;  //select all checkboxes with class "checkbox1"               
          });
      }else{
          $('.mfchannel').each(function() { //loop through each checkbox
              this.checked = false; //deselect all checkboxes with class "checkbox1"                       
          });         
      }
  });

  $('.mfchannel').click(function(event) {  //on click of ANY CHANNEL - make sure SELECT ALL deselected
    	$('#selectallchannels').each(function() { //loop through each checkbox
          this.checked = false; //deselect all checkboxes with id "sectors_other"                       
      });        
  });    


  // SUBMIT FORM ON FILTER SELECT
  $('.filterform :checkbox').on('click', function(e) {
    $('#filters-form').submit();
  });
  

  // ADDING CUSTOM CHANNELS
  $('#btnSave').click(function() {
    if ($('#ccName').val()) {
      addCheckbox($('#ccName').val());
    };
  });

  $('#customchannellist').on( "click", "input", function() {
    $( this ).parent('span').remove();
  });

  $('#ccName').on('click focusin', function() {
    this.value = '';
  });


  // LOGO PREVIEW
  $("#brand_logo").change(function(){
      if (this.files && this.files[0]) {
          var reader = new FileReader();
          reader.onload = function (e) {
              $('#logo-preview').attr('src', e.target.result);
          }
          reader.readAsDataURL(this.files[0]);
      }
  });
  $("#distributor_logo").change(function(){
      if (this.files && this.files[0]) {
          var reader = new FileReader();
          reader.onload = function (e) {
              $('#logo-preview').attr('src', e.target.result);
          }
          reader.readAsDataURL(this.files[0]);
      }
  });


  // DASHBOARD UI  

  $('#dashboard-marketplace-header').on('click', function(e) {
    if ( $('#dashboard-marketplace-container').hasClass('medium-8') ) {
      $('#dashboard-marketplace-container').hide().removeClass('medium-8').addClass('medium-4').fadeIn(500);
      $('#dashboard-insights-container, #dashboard-agency-container').hide().removeClass('medium-2').addClass('medium-4').fadeIn(500);
      $('#dashboard-marketplace-content-inner, #dashboard-insights-content-inner, #dashboard-agency-content-inner').fadeIn(500);
      $('#marketplace-h2, #insights-h2, #agency-h2').hide();
      $('#marketplace-h1, #insights-h1, #agency-h1').show();      
    } else {
      $('#dashboard-marketplace-container').hide().removeClass('medium-4 medium-2').addClass('medium-8').fadeIn(500);
      $('#dashboard-insights-container, #dashboard-agency-container').hide().removeClass('medium-4 medium-8 medium-centered').addClass('medium-2').fadeIn(500);
      $('#dashboard-insights-content-inner, #dashboard-agency-content-inner').hide();
      $('#dashboard-marketplace-content-inner').fadeIn(500);
      $('#marketplace-h2, #insights-h1, #agency-h1').hide();
      $('#marketplace-h1, #insights-h2, #agency-h2').show();         
    }
      $(document).foundation();
      $(document).foundation('equalizer', 'reflow');           
  });

  $('#dashboard-insights-header').on('click', function(e) {
    if ( $('#dashboard-insights-container').hasClass('medium-8') ) {
      $('#dashboard-insights-container').hide().removeClass('medium-8').addClass('medium-4').fadeIn(500);
      $('#dashboard-marketplace-container, #dashboard-agency-container').hide().removeClass('medium-2').addClass('medium-4').fadeIn(500);
      $('#dashboard-marketplace-content-inner, #dashboard-insights-content-inner, #dashboard-agency-content-inner').fadeIn(500);
      $('#marketplace-h2, #insights-h2, #agency-h2').hide();
      $('#marketplace-h1, #insights-h1, #agency-h1').show();      
    } else {
      $('#dashboard-insights-container').hide().removeClass('medium-4 medium-2').addClass('medium-8').fadeIn(500);
      $('#dashboard-marketplace-container, #dashboard-agency-container').hide().removeClass('medium-4 medium-8').addClass('medium-2').fadeIn(500);
      $('#dashboard-marketplace-content-inner, #dashboard-agency-content-inner').hide();
      $('#dashboard-insights-content-inner').fadeIn(500);
      $('#marketplace-h1, #insights-h2, #agency-h1').hide();
      $('#marketplace-h2, #insights-h1, #agency-h2').show();
    }    
    $(document).foundation();
    $(document).foundation('equalizer', 'reflow');         
  });


  $('#dashboard-agency-header').on('click', function(e) { 
    if ( $('#dashboard-agency-container').hasClass('medium-8') ) {
      $('#dashboard-agency-container').hide().removeClass('medium-8').addClass('medium-4').fadeIn(500);
      $('#dashboard-insights-container, #dashboard-marketplace-container').hide().removeClass('medium-2').addClass('medium-4').fadeIn(500);
      $('#dashboard-marketplace-content-inner, #dashboard-insights-content-inner, #dashboard-agency-content-inner').fadeIn(500);
      $('#marketplace-h2, #insights-h2, #agency-h2').hide();
      $('#marketplace-h1, #insights-h1, #agency-h1').show();      
    } else {
      $('#dashboard-agency-container').hide().removeClass('medium-4 medium-2').addClass('medium-8').fadeIn(500);
      $('#dashboard-insights-container, #dashboard-marketplace-container').hide().removeClass('medium-4 medium-8').addClass('medium-2').fadeIn(500);
      $('#dashboard-insights-content-inner, #dashboard-marketplace-content-inner').hide();
      $('#dashboard-agency-content-inner').fadeIn(500);
      $('#marketplace-h1, #insights-h1, #agency-h2').hide();
      $('#marketplace-h2, #insights-h2, #agency-h1').show();
    }       
    $(document).foundation();
    $(document).foundation('equalizer', 'reflow');      
  });


});


$(document).foundation({
  accordion: {
    // specify the class used for accordion panels
    // content_class: 'content',
    // specify the class used for active (or open) accordion panels
    // active_class: 'active',
    // allow multiple accordion panels to be active at the same time
    multi_expand: true,
    // allow accordion panels to be closed by clicking on their headers
    // setting to false only closes accordion panels when another is opened
    toggleable: true
  }
});

function addCheckbox(name) {
    var container = $('#customchannellist');
    var inputs = container.find('input');
    var id = inputs.length+1;

    $('<span />', { id: 'ccspan'+id }).appendTo(container)
    $('<input />', { type: 'checkbox', id: 'cb'+id, value: name, name: 'customchannels['+id+']', checked: 'checked', class: 'customchannelinput' }).appendTo( '#' + 'ccspan' + id );
    $('<label />', { 'for': 'cb'+id, text: name }).appendTo( '#' + 'ccspan' + id );
  }

function initialize () {
  // Date Picker
 
  $('.datepick').fdatepicker({
    format: "mm/yyyy",
    startView: 2,
    minViewMode: 2
  });

  $('.datepick_full').fdatepicker({
    format: "mm/dd/yyyy",
    startView: 2,
    minViewMode: 2
  });


  // Autocomplete 

  // Select all on focus (note: makes it so that one can't select a part of an input, 
  // but can only ever select all... shouldn't be a problem, hopefully??)

  // for autocomplete
  var countriesArray = $.map(countries, function (value, key) { return { value: value, data: key }; });

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
}


$(document)
  .ajaxStart(function () {
    $('.ajax-wait').show();
  })
  .ajaxStop(function () {
    $('.ajax-wait').hide();
  });

