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
  }, 4000);
    
  /* Add input-highlighted class on profile information edition */
  $('.best_in_place').on('click', function(){
    $(this).addClass('input-highlighted');
  });
  
  /* Add delete mask on tags on close button hover */
  var deleteTag = '<div class="delete-tag"><i class="icon-remove"></i> Delete</div>';

  $(".tag-pills button").on({
    mouseenter: function () {
      $(deleteTag).hide().appendTo($(this)).fadeIn(250);
    },
    mouseleave: function () {
      $(this).children('.delete-tag').remove();
    }
  });
  
}());