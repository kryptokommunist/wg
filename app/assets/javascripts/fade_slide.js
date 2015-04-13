function fade() {
    var $span = $(".fade-in");
    var $span2 = $(".fade-in2");
    $span2.hide()
    $('.slide').hide();
    $span.fadeOut(0, function() {
        
        $span.fadeIn(1400);
    });
    setTimeout(function(){
        $span2.fadeIn(1400);
    }, 1000);
};

function slide() {

    
	$('.slide').slideDown();

};

fade();
slide();