
$(function(){
  /* Best in place configuration */
  best_in_place = BestInPlace.init();
  best_in_place.handle_success();

  /* Avatar upload*/
  avatar_manager = AvatarManager.init();
  avatar_manager.handle_upload();

  /* Tag-pills hover  */
  tag_display = TagDisplay.init();
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

var TagDisplay = (function() {
  function _init() {
    $('.tag-pills').on({
      'mouseenter': function(e) {
         var self = $(this);
         self.removeClass('icon-white');
      },
      'mouseleave': function(e) {
         var self = $(this);
        self.addClass('icon-white');
      }
    }, 'button[type="submit"] i');
  }
  return { init : _init }
}());
