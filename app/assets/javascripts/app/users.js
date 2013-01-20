jQuery.railsAutocomplete.configuration.createWithDefaults = false;

$(function(){
  /* Best in place configuration */
  best_in_place = BestInPlace.init();
  best_in_place.handle_success();

  /* Avatar upload*/
  avatar_manager = AvatarManager.init();
  avatar_manager.handle_upload();

  /* Document creation */
  document_manager = DocumentManager.init();
  document_manager.handle_creation();

  /* Tag-pills hover  */
  Tags.init();
  Tags.display();
  Tags.autocomplete();
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

var DocumentManager = (function() {
  function _init() {
    return {
      handle_creation : _creator
    }
  }

  function _creator() {
    $('#add-document').click(function(e) {
      e.preventDefault();
      $('#new-document-popin').modal();
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

var Tags = (function() {
  var tags;

  function _init() {
    tags = $('.tag-pills');
  }

  function _display() {
    tags.on({
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

  function _autocomplete() {
    $('input[data-autocomplete]').railsAutocomplete({
      delimiter       : ',',
      insertDelimiter : true,
      focusOnNext     : true
    });

    $('textarea[data-autocomplete]').railsAutocomplete({
      delimiter         : '#',
      delimiterPosition : 'before',
      withText          : true
    });
  }

  return {
      init : _init,
      display: _display,
      autocomplete: _autocomplete
         }
}());
