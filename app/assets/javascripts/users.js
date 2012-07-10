
$(function(){
  best_in_place = BestInPlace.init();
  best_in_place.success_handler();
});


var BestInPlace = function() {
  function _init() {
    $('.best_in_place').best_in_place();
    return {
      success_handler:_success
    };
  }

  function _success() {
    $('.best_in_place').bind("ajax:success", function(e) {
      self  = this;
      value = self.innerHTML;

      if (value.isBlank() || value.isNotSpecified()) {
        self.className += ' blank';
      } else {
        $(self).removeClass('blank');
      }
    });
  }

  return { init: _init }
}();