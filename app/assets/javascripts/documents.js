// TODO: Should only be loaded on relevant pages
$(function() {
    var doc;
    if( doc = $('#document') ) {
        var doc_id = (doc.attr('data-id'))
        doc.pad({
            'host'     : 'http://beta.etherpad.org',
            'padId'    : doc_id,
            'showChat' : true
        });
        doc, doc_id    = null;
    }
});
