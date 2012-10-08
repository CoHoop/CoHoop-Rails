(function( $ ){

  $.fn.pad = function( options ) {

    var $self = this;
    if (!$self.length) return;
    if (!$self.attr('id')) throw new Error('No "id" attribute');

    var pad = new embedPad(this, options);

    return $self;

  };

  var embedPad = function( element, options ){

    this.elm = $(element);
    this.options = options;
    this.useValue = this.elm[0].tagName.toLowerCase() == 'textarea';
    this.selfId = this.elm.attr('id');
    this.epframeId = 'epframe' + this.selfId;

    // Settings
    this.settings = {};
    this.settings.host = 'http://0.0.0.0:8080';
    this.settings.baseUrl = '/p/';
    this.settings.showControls = "true";
    this.settings.showChat = "false";
    this.settings.alwaysShowChat = "false";
    this.settings.showLineNumbers = "false";
    this.settings.userName = 'CoHooper';
    this.settings.useMonospaceFont = "false";
    this.settings.noColors = "true";
    this.settings.hideQRCode = "false";
    this.settings.width = '100%';
    this.settings.height = $(window).height()-5;
    this.settings.toggleTextOn = 'Disable Rich-text';
    this.settings.toggleTextOff = 'Enable Rich-text';

    this.init();
  };

  embedPad.prototype = {

    init: function()
    {
      // This writes a new frame if required
      if ( !this.options.getContents ) {

        if ( this.options ) {
          $.extend( this.settings, this.options );
        }

        this.getIFrame();
        this.onResize();

      // Export HTML
      } else {

        this.getHTMLExport();

      }
    },

    onResize: function()
    {
      var self = this;
      $(window).resize(function(){
        $('#'+ self.epframeId).attr('height', $(window).height()-5);
      });
    },

    getHTMLExport: function()
    {
      var frameUrl = $('#'+ this.epframeId).attr('src').split('?')[0];
      var contentsUrl = frameUrl + "/export/html";

      // perform an ajax call on contentsUrl and write it to the parent
      $.get(contentsUrl, function(data) {
        
        if (useValue) {
          this.elm.val(data).show();
        }
        else {
          this.elm.html(data);
        }
        
        $('#'+ this.epframeId).remove();
      });
    },

    getIFrame: function(){
      var iFrameLink = '';
      var src = this.settings.host + this.settings.baseUrl + this.settings.padId;
      
      iFrameLink  = '<iframe id="' + this.epframeId;
      iFrameLink += '" name="' + this.epframeId;
      iFrameLink += '" src="' + src;
      iFrameLink += '?showControls=' + this.settings.showControls;
      iFrameLink += '&showChat=' + this.settings.showChat;
      iFrameLink += '&alwaysShowChat=' + this.settings.alwaysShowChat;
      iFrameLink += '&showLineNumbers=' + this.settings.showLineNumbers;
      iFrameLink += '&useMonospaceFont=' + this.settings.useMonospaceFont;
      iFrameLink += '&userName=' + this.settings.userName;
      iFrameLink += '&noColors=' + this.settings.noColors;
      iFrameLink += ';" width="' + this.settings.width;
      iFrameLink += '" height="' + this.settings.height;
      iFrameLink += '"></iframe>';
    
      var $iFrameLink = this.elm.prepend(iFrameLink);

      if (this.useValue) {
        var self = this;
        var $toggleLink = $('<a href="#' + this.selfId + '">' + this.settings.toggleTextOn + '</a>').click(function(){
          var $this = $(this);
          $this.toggleClass('active');
          if (self.elm.hasClass('active')) $this.text(this.settings.toggleTextOff);
          self.elm.pad({getContents: true});
          return false;
        });

        this.elm.hide().after($toggleLink).after($iFrameLink);
      }
    },

  };

})( jQuery );