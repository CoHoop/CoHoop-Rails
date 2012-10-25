// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function(){
  
  /* Flash message */
  var flashMessage = $('.flash-messages');
  
  $('body').on('click', function(){
    flashMessage.hide(250);
  });
  
  setTimeout(function(){
    flashMessage.hide(250);
    console.log('bye !');
  }, 4000);
    
  
  
}());