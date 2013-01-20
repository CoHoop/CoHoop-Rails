/*
* Unobtrusive autocomplete
*
* To use it, you just have to include the HTML attribute autocomplete
* with the autocomplete URL as the value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete">
*
* Optionally, you can use a jQuery selector to specify a field that can
* be updated with the element id whenever you find a matching value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete" data-id-element="#id_field">
*/

(function(jQuery)
{
  jQuery.fn.caretPosition = function() {
      el = this[0];
      if (el.selectionStart) {
          return el.selectionStart;
      } else if (document.selection) {
          el.focus();

          var r = document.selection.createRange();
          if (r == null) {
              return 0;
          }

          var re = el.createTextRange(),
          rc = re.duplicate();
          re.moveToBookmark(r.getBookmark());
          rc.setEndPoint('EndToStart', re);

          return rc.text.length;
      }
      return 0;
  };

  var self = null;
  jQuery.fn.railsAutocomplete = function(opts) {
    return this.on('focus',function() {
      if (!this.railsAutoCompleter) {
        this.railsAutoCompleter = new jQuery.railsAutocomplete(this, opts);
      }
    });
  };

  jQuery.railsAutocomplete = function (e, opts) {
    _e        = e;
    e.options = merge(opts, railsAutocompleteConfig.DEFAULT_OPTIONS)

    this.init(_e);
  };

  jQuery.railsAutocomplete.fn = jQuery.railsAutocomplete.prototype = {
    railsAutocomplete: '0.0.1'
  };
  jQuery.railsAutocomplete.configuration = { createWithDefaults : true }

  jQuery.railsAutocomplete.fn.extend = jQuery.railsAutocomplete.extend = jQuery.extend;
  jQuery.railsAutocomplete.fn.extend({
    init: function(e) {
      e.options.delimiter = e.options.delimiter || jQuery(e).attr('data-delimiter') || null;
      e.options.url       = e.options.url || jQuery(e).attr('data-autocomplete')

      railsAutocompleteTag.init(e);
      if( e.options.withText ) {
        if( !e.options.delimiter ) {
          throw 'When working with joined text, autocomplete rails needs a delimiter to be defined.';
        }
        railsAutocompleteTag.autocomplete(e.options.delimiter);
      } else {
         railsAutocompleteTag.autocomplete();
      }
    }
  });

  jQuery(document).ready(function(){
      if(jQuery.railsAutocomplete.configuration.createWithDefaults) {
          jQuery('input[data-autocomplete]').railsAutocomplete({
              delimiter       : ',',
              insertDelimiter : true,
              focusOnNext     : true
          });
          jQuery('textarea[data-autocomplete]').railsAutocomplete({
              delimiter       : ',',
              insertDelimiter : true
          });
      }
  });

  function merge(source, other){
    for(var p in other){
      if(source[p] === undefined) source[p] = other[p];
    }
    return source;
  }
})(jQuery);

var railsAutocompleteTag = (function() {
    var callbacks, self;

    function _init(e) {
        self      = e;
        callbacks = railsAutocompleteConfig.autocompleteCallbacks(self);
    };

    function _autocomplete(symbol) {
        if (symbol) {
            _autocompleteWithSymbol(symbol)
        } else {
            jQuery(self).autocomplete(callbacks);
        }
    }

    function _autocompleteWithSymbol(symbol) {
        var code          = symbol.charCodeAt(0),
            autocompleter = null;

        jQuery(self).on('keypress', function(e) {
            if( e.which === code ) {
                /* We don't want to re-assign all the callbacks on each keypress */
                if (null === autocompleter) {
                    autocompleter = jQuery(self).autocomplete(callbacks);
                } else {
                    jQuery(self).autocomplete("enable");
                }
            } else if (e.which === ','.charCodeAt(0)) {
                jQuery(self).autocomplete("disable");
            }
        });
    }

    return {
        init        : _init,
        autocomplete: _autocomplete
    };
})();

var railsAutocompleteConfig = (function() {
    function _autocompleteCallbacks(e) {
        // We instanciate it every time, as the helpers uses the element object
        e.helpers = new _railsAutocompleteHelpers(e);

        return  {
            source: function( request, response ) {
                jQuery.getJSON( e.options.url , {
                    term: e.helpers.extractCurrent( request.term )
                }, function(data) {
                    if(arguments[0].length == 0) {
                        arguments[0] = []
                        arguments[0][0] = { id: "", label: "no existing match" }
                    }
                    jQuery(arguments[0]).each(function(i, el) {
                        var obj = {};
                        obj[el.id] = el;
                        jQuery(e).data(obj);
                    });
                    response.apply(null, arguments);
                });
            },
            change: function( event, ui ) {
                if(jQuery(jQuery(this).attr('data-id-element')).val() == "") {
        	  	      return;
        	      }
                jQuery(jQuery(this).attr('data-id-element')).val(ui.item ? ui.item.id : "");
                var update_elements = jQuery.parseJSON(jQuery(this).attr("data-update-elements")),
                    data            = ui.item ? jQuery(this).data(ui.item.id.toString()) : {};
                if(update_elements && jQuery(update_elements['id']).val() == "") {
            	      return;
                }
                for (var key in update_elements) {
                    jQuery(update_elements[key]).val(ui.item ? data[key] : "");
                }
            },
            search: function() {
                // custom minLength
                var term = e.helpers.extractCurrent( this.value );
                if ( term.length < 2 ) {
                    return false;
                }
            },
            focus: function() {
                // prevent value inserted on focus
                return false;
            },
            close : function() {
                /* Disabled because we don't want autocompletion
                 * when writing normal text
                 */
                if (e.options.withText) {
                    jQuery(this).autocomplete("disable");
                    /* Simulates a keypress for nothing,
                     * as the previous line blocked the keyboard input
                     */
                    jQuery(this).focus().trigger( jQuery.Event( 'keypress', { which: 13 } ) );
                }
            },
            select: function( event, ui ) {
                var terms = e.helpers.split( this.value );
                // Replace the current input with the completion
                terms[e.helpers.currentTermIndex(terms)] = ui.item.value

                if (this.options.delimiter != null) {
                    terms = jQuery.map(terms, function(v, i) {
                        // If the value is blank, we remove it
                        // Otherwise, we trim all whitespaces
                        if(!(v == '' || v == ' ')) {
                            return jQuery.trim(v);
                        }
                    });

                    if (this.options.insertDelimiter == true) {
                        if (this.options.delimiterPosition === 'after') {
                            // Add placeholder to get the delimiter-and-space at the end
                            terms.push( "" );
                        }
                    }

                    this.value = e.helpers.getValue(terms);
                } else {
                    this.value = terms.join("");
                    if (jQuery(this).attr('data-id-element')) {
                        jQuery(jQuery(this).attr('data-id-element')).val(ui.item.id);
                    }
                    if (jQuery(this).attr('data-update-elements')) {
                        var data = jQuery(this).data(ui.item.id.toString());
                        var update_elements = jQuery.parseJSON(jQuery(this).attr("data-update-elements"));
                        for (var key in update_elements) {
                            jQuery(update_elements[key]).val(data[key]);
                        }
                    }
                }
                var remember_string = this.value;
                jQuery(this).bind('keyup.clearId', function(){
                    if(jQuery(this).val().trim() != remember_string.trim()){
                        jQuery(jQuery(this).attr('data-id-element')).val("");
                        jQuery(this).unbind('keyup.clearId');
                    }
                });

                jQuery(e).trigger('railsAutocomplete.select', ui);

                /* If we hit tab, we stay in the same element
                 * and fullfil the autocompletion process
                 */
                if (event.keyCode === 9 && !e.options.focusOnNext) {
                    event.preventDefault();
                    jQuery(e).focus();
                }
                return false;
            }
        }
    }
    function _defaultOptions() {
        return {
            /* Wether of not to use a delimiter, and in the case
             * we do, a String specifying it.
             * Can also be specified through the HTML data-delimiter attribute.
             *
             * Examples:
             *
             *   // Possibles values:
             *   '@', '#', ',', <any unique character>
             */
            delimiter         : null,

            /* Were is the delimiter positionned : before or after the term.
             *
             * Examples:
             *
             *   // Values
             *   'after', 'before'
             */
            delimiterPosition : 'after',

            /* Wether or not to insert a new blank delimiter when autocompleting
             *
             * Examples:
             *
             *   // Values
             *   true, false
             */
            insertDelimiter   : false,

            /* Wether or not to focus on the next element when pressing tab.
             *
             * Examples:
             *
             *   // Values
             *   true, false
             */
            focusOnNext       : false,

            /* URL to get autocompletion results from.
             * Can also be specified through the HTML data-autocomplete attribute.
             *
             * Examples:
             *
             *   // Possible values:
             *   'http://localhost:3000/terms/autocomplete_term', '/terms/autocomplete_term', <any_url_string>
             */
            url               : null,

            /* Wether or not it is possible to write pure non autocompleted text
             * and trigger autocompletion when typing the delimiter
             *
             * Examples:
             *
             *   // Values:
             *   true, false
             */
            withText          : false,

            /* Public: a Function to filter the term under the keyboard cursor
             *         before it is processed.
             *
             * element - The HTML DOMElement we are autocompleting.
             * index   - The index of the current term, as a Number.
             * terms   - The Array of terms.
             *
             * Examples:
             *
             *   // Mainly, the default behavior is strictly equivalent to a
             *   // filter function just as this one :
             *   {
             *     filter: function() {
             *       return terms[index];
             *     }
             *   }
             */
            filter            : null
        };
    }

    return {
        autocompleteCallbacks : _autocompleteCallbacks,
        DEFAULT_OPTIONS       : _defaultOptions()
    }
})();

/* Private: Having the helpers as an instanciable class
 * helps having multiple autocomplete fields in a same page
 * as they all have a different set (instance) of helpers and options.
 *
 * e - The element for which the helpers are.
 *
 * Returns an instance of _railsAutocompleteHelpers.
 */
_railsAutocompleteHelpers = (function(e){
    this.options = e.options;
    this.element = e;
});

_railsAutocompleteHelpers.prototype =  {
    split: function( val ) {
        return val.split( this.options.delimiter );
    },
    /* Public: Same as Array.join() but joins on the left side of the string.
     * An other difference is that it also appends the separator to the first
     * character.
     *
     * array  - The Array to join.
     * string - The separator, as a String.
     *
     * Returns a joined String.
     */
    leftJoin: function( array, string ) {
        var a = '';
        for (var i = 0; i < array.length; i++) {
            a += string + array[i];
        }
        return a;
    },
    /* Public: Chooses between Array.join() and this.leftJoin() according to
     * set options.
     *
     * array  - The Array to join.
     * string - The separator, as a String.
     *
     * Returns a joined String.
     */
    join: function( array, string ) {
        return (this.options.delimiterPosition === 'after') ? array.join(string) : this.leftJoin(array, string);
    },
    /* Public: see extractCurrent(), currentIndex(), find the term right under
     * the cursor's position in an Array.
     *
     * array     - An Array to search
     * onlyIndex - A Boolean indicating if we want to return
     *             only the index or the whole word (default: false).
     *
     * Returns a String with the found word or a Number with the index of the found word.
     */
    findTermIn: function(array, onlyIndex) {
        var position      = jQuery(this.element).caretPosition(),
            total_length  = 0,
            string_length = 0;

        /* If position < 0 || position > total array strings' length,
         * normalize position.
         */
        string_length = array.join('').length;
        if(position > string_length) {
            position = string_length;
        } else if(position < 0) {
            position = 0;
        }

        for(var i = 0; i < array.length; i++) {
            total_length += array[i].length;
            if(position <= total_length) {
                return onlyIndex ? i : array[i];
            }
        }
    },
    /* Private API - Deprecated: Find the last term in a string.
     *
     * terms - A String containing multiple terms.
     *
     * Returns the term, as a leading-whitespace-clean String.
     */
    extractLast: function( terms ) {
        return this.split( terms ).pop().replace(/^\s+/,"");
    },

    /* Public: Returns the term under the cursor. Can be filtered
     * through this.options.filter callback;
     *
     * term - A String from which to extract
     *
     * Returns a String with the extracted term.
     */
    extractCurrent: function( term, filter ) {
        var terms_array = this.split( term ),
        term        = '';
        // We can filter the terms manualy through
        if( this.options.filter ) {
            term = this.options.filter.call(this.element, this.findTermIn( terms_array, true ), terms_array);
        } else {
            term = this.findTermIn( terms_array );
        }
        return term.replace(/^\s+/,"");
    },

    /* Public: Returns the id of the term under the cursor
     *
     * - An Array in which to search the current term
     *
     * Returns a the index as a Number.
     */
    currentTermIndex: function( terms ) {
        return this.findTermIn( terms, true )
    },

    /* Public: returns the delimiter according to the options
     *
     * Examples :
     *
     * // With this.options.delimiter set to ','
     * // delimiterPosition set to after : 'bla, '
     * // delimiterPosition set to before : ' ,bla'
     *
     * Returns the delimiter, as a String.
     */
    delimiter: function() {
        var delimiter = '';
        delimiter     += (this.options.delimiterPosition === 'before') ? ' ' : '';
        // " delimiter" || "delimiter"
        delimiter     += this.options.delimiter;
        // "delimiter " || "delimiter"
        delimiter     += (this.options.delimiterPosition === 'after')  ? ' ' : '';
        return delimiter;
    },

    /* Public: Returns the first term of an array if it does not start with a delimiter
     *
     * terms - An Array of String, the terms.
     *
     * Returns the first term, as a String.
     */
    firstTerm: function(terms) {
        var firstTerm = null;
        if (this.options.withText) {
            /* If the first character of the first term is not a
             * delimiter, we extract and store it because we
             * don't want the delimiter to be appened to it.
             */
            if (this.element.value[0] !== this.options.delimiter) {
                firstTerm = terms.shift();
            }
        }
        return firstTerm;
    },

    /* Private: Get the new element value from an Array of terms.
     *
     * terms - An Array of String, the terms.
     *
     * Returns the joined and processed terms as a String.
     */
    getValue: function(terms) {
        var firstTerm = this.firstTerm(terms)
        value = this.join( terms, this.delimiter() );

        // If there is no insertion of a delimiter, we append a whitespace
        if (this.options.insertDelimiter == false) {
            value += ' '
        }
        // If, the first element was not a term we added it back
        if (firstTerm) {
            value = firstTerm + value;
        } else if (this.options.delimiterPosition === 'before') {
            // Else the first element was a term and we remove the space before
            value = value.substring(1)
        }
        return value;
    }
};
