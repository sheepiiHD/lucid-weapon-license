//GUI -- Handle Events
$(document).ready(function() {

    // ## CONFIG (You can change this)
    var minimum_characters_allowed = 30;
    
    //##################################

    var len = 0;
    var maxchar = 0;
    var allowed = false;

    // Validation (Character count, and minimum characters on reason)
    $('#reason').keyup(function(){
        len = this.value.length

        if(len > minimum_characters_allowed && allowed){
            $("#submit-button").prop('disabled', false);
        }else{
            $("#submit-button").prop('disabled', true);
        }

        if(len < maxchar){
            return false;
        } else if (len < minimum_characters_allowed){
            $("#remaining" ).html('<span class="warning">' + len  + "/1000 </span>");
        }else {
            $("#remaining" ).html('<span>' + len  + "/1000 </span>");
        }
    })

    // Validation (Agreeing to be charged)
    $('#charged').click(function() {
        allowed = this.checked
        
        if(len > minimum_characters_allowed && allowed){
            $("#submit-button").prop('disabled', false);
        }else{
            $("#submit-button").prop('disabled', true);
        }
    });


    // Submit Button - Application
    $('#submit-button').click(function() {
        let values = {
            citizenID: $("#citizenID").val(),
            description: $("#reason").val(),
            conviction: document.getElementById('convicted').checked,
        };

        // Send a post to submit the application
        $.post('https://lucid-weapon-license/submitApplication', values);
    })
});