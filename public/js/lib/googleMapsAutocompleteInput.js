// This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.

var autocompleteGoogleAddressInput;
window.addressDetails = {}; 
function initializeAutocompleteAddress() {
  var inputs = [].slice.call(document.getElementsByClassName('autocompleteAddress'));

  inputs.forEach(function(input) {
    // Create the autocomplete object, restricting the search
    // to geographical location types.
    autocompleteGoogleAddressInput = new google.maps.places.Autocomplete(
        /** @type {HTMLInputElement} */(input),
        { types: ['geocode'] });
    // When the user selects an address from the dropdown,
    // populate the address fields in the form.
    google.maps.event.addListener(autocompleteGoogleAddressInput, 'place_changed', function() {
      fillInAddress();
    });
  });
}

// [START region_fillform]
function fillInAddress() {
  // Get the place details from the autocomplete object.
  var place = autocompleteGoogleAddressInput.getPlace();
  var componentForm = {
    street_number: 'short_name',
    route: 'long_name',
    locality: 'long_name',
    administrative_area_level_1: 'short_name',
    country: 'long_name',
    postal_code: 'short_name'
  };

  // for (var component in componentForm) {
  //   document.getElementById(component).value = '';
  //   document.getElementById(component).disabled = false;
  // }

  // Get each component of the address from the place details
  // and fill the corresponding field on the form.
  window.addressDetails = {}; //reset it 
  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = place.address_components[i].types[0];
    if (componentForm[addressType]) {
      var val = place.address_components[i][componentForm[addressType]];
      window.addressDetails[addressType] = val;
      //console.log(addressType, val);
      //document.getElementById(addressType).value = val;
    }
    window.addressDetails.lat = place.geometry.location.lat();
    window.addressDetails.lng = place.geometry.location.lng();
  }
}
// [END region_fillform]

// [START region_geolocation]
// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
  return; //ignore atm. 
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocompleteGoogleAddressInput.setBounds(circle.getBounds());
    });
  }
}
// [END region_geolocation]

if ($('.autocompleteAddress').length) initializeAutocompleteAddress();