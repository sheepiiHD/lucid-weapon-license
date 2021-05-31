
$(document).ready(function() {
    $('.accept-button').click(function () {
        let citizenID = $(this).attr("id").split('-')[0];

        $.post('https://lucid-weapon-license/acceptApplication', {citizenID: citizenID});
        $('#container-' + citizenID).remove();
    });

    $('.deny-button').click(function () {
        let citizenID = $(this).attr("id").split('-')[0];

        $.post('https://lucid-weapon-license/denyApplication', {citizenID: citizenID});
        $('#container-' + citizenID).remove();
    });

    $('.carousel-control-next').click(function () {
        console.log("done")
        $('.carousel').carousel('next');
    })

    $('.carousel-control-prev').click(function () {
        console.log("done asdfasdfs")
        $('.carousel').carousel('prev');
    })
    $('.carousel').carousel({
        interval: false,
    });

});