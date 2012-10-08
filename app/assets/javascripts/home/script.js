/mobile/i.test(navigator.userAgent) && !location.hash && setTimeout(function () {
    if (!pageYOffset) window.scrollTo(0, 1);
}, 1000);

jQuery(document).ready(function ($) {

    /* Sequence.js */
    var options = {
        animateStartingFrameIn: true,
        transitionThreshold: 250,
        autoPlayDelay: 8000
    };

    $("#sequence").sequence(options);
    
    // This is something ugly but I can't figuired out why hash tags are stille present
    location.hash = '';

    /* Stretch background */
    $.backstretch('http://tduforest.fr/cohoop/frontpage/img/bg.jpg');

    // Placeholder for IE
    $('input[name=mail], input[name=university]').placeholder();

    $('input').focus(function() {
        $(this).siblings('label').css({
            color: 'rgba(255, 255, 255, 1)'
        });
    });

    $('input').focusout(function(){
        $(this).siblings('label').css({
            color: 'rgba(255, 255, 255, 0.8)'
        });
    });

    // Hide message sent confirm
    $('#mailMsg').on('click', function(){
        console.log(this);
        $('#mailMsg').fadeOut(200);
        
    });

});