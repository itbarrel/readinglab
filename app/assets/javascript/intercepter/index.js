import {addRequestCallback, addResponseCallback, wire, unwire} from './intercepter'

let apiCount = 0

addRequestCallback(function(xhr) {
  apiCount+= 1;
  if (apiCount > 0){
    document.getElementById('loadingOverlay').style.display = 'flex';
  }
});

addResponseCallback(function(xhr) {
  apiCount-= 1;
  if (apiCount <= 0){
    document.getElementById('loadingOverlay').style.display = 'none';
  }
});

// Will proxify XHR to fire the above callbacks
wire();

// // Will restore XHR and not fire anymore the callbacks
// unwire();