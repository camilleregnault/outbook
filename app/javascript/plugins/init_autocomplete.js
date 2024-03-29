import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('place_address');
  if (addressInput) {
    places({ container: addressInput });
  }
};

const initAutocompleteBis = () => {
  const addressInput = document.getElementById('address');
  if (addressInput) {
    places({ container: addressInput });
  }
};


export { initAutocomplete, initAutocompleteBis };
