
$(function(){
  best_in_place = BestInPlace.init();
  best_in_place.handle_success();

  avatar_manager = AvatarManager.init();
  avatar_manager.handle_upload();
});

var AvatarManager = (function() {
  function _init() {
    return {
      handle_upload : _uploader
    }
  }

  function _uploader() {
    $('#upload-avatar').click(function(e) {
      e.preventDefault();
      $('#upload-popin').modal();
    });
  }

  return { init : _init }
}());

var BestInPlace = (function() {
  function _init() {
    $('.best_in_place').best_in_place();
    return {
      handle_success : _success
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

  return { init : _init }
}());