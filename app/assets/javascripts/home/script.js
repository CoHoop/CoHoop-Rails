/mobile/i.test(navigator.userAgent) && !location.hash && setTimeout(function () {
    if (!pageYOffset) window.scrollTo(0, 1);
}, 1000);

jQuery(document).ready(function ($) {

    /* Stretch background */
    $.backstretch('assets/home/bg.jpg');

    // Placeholder for IE
    $('input.mail_input, input.university_input').placeholder();

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

    /* Sequence.js */
    var options = {
        animateStartingFrameIn: true,
        transitionThreshold: 250,
        autoPlayDelay: 8000
    };

    $("#sequence").sequence(options);

});
