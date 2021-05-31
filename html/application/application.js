//Load Application Page
function openApplication(data) {

    //Load application.html
    $.ajax({
      url : "application/application.html",
      success : function(result){
        $("#clipboard").fadeOut(0).fadeIn(300);
        $("#main_container").html(result)
            .fadeOut(0).fadeIn(300, function() {
              
            /** Set Charge Amount **/
            $('#amount').text(`$${data.amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")} USD`);

            document.getElementById('citizenID').value = data.citizenID;
            document.getElementById('firstName').value = data.first;
            document.getElementById('lastName').value = data.last;
            document.getElementById('age').value = data.age;
            document.getElementById('job').value = data.job;
        });
      }
    });
  }