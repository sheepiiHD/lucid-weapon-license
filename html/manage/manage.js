// Load Manage Page
function openManage(data) {

    console.log(data.map((x) => x.citizenID))
    //Load application.html
    $.ajax({
      url : "manage/manage.html",
      success : function(result){
        $("#clipboard").fadeOut(0).fadeIn(300);
        $("#main_container").html(result).fadeOut(0).fadeIn(300);
        data.forEach((application, index) => {
          $("#application-container")
              .append(`
                <div id="container-${application.citizenID}" class="carousel-item ${index === 0 ? `active`: ``}">
                  <div class="carousel-body">
                    <div class="d-flex align-items-end justify-content-around">

                      <button id="${application.citizenID}-accept" type="button" class="btn btn-success btn-lg app-button accept-button">✓</button>
                      <button id="${application.citizenID}-deny" type="button" class="btn btn-danger btn-lg app-button deny-button">X</button>
                  </div>
                </div>
              `);
        })
      }
    });
  }


  const inputGroupBox = (label, value) => {
    return(
      `<div class="input-group mb-2">`+
        `<div class="input-group-prepend">`+
          `<div class="input-group-text min-input-label input-group-prepend-custom">${label}</div>`+
        `</div>`+
        `<input value="${value}" readonly disabled class="form-control input-group-text-custom white-text" id="inlineFormInputGroup">`+
      `</div>`
    )
  }

  const getSpacer = (index, maxValue) => {
    console.log(index)
    console.log(maxValue)
    if(index == maxValue -1) return  `<div class="spacer"/>`
    return ``;
  }