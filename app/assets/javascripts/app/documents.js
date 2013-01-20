// TODO: Should only be loaded on relevant pages
$(function() {
    var doc;
    if( doc = $('#document') ) {
        var doc_id = (doc.attr('data-id'))
        doc.pad({
            'host'     : 'http://docs.cohoop.com',
            'padId'    : doc_id,
            'showChat' : true,
            'height'   : $(window).height() - ($('#navbar').height() * 2)
        });
        doc, doc_id    = null;
    }
});
