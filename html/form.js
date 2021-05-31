
window.addEventListener('message', function(event) {
  let data = event.data;
  let meta = data.meta_data;
  switch(data.type) {

    /** Opening menu event */
    case 'open':
      switch(data.menu){
        case 'application':
          return openApplication(meta);
        case 'manage':
          return openManage(meta);
        default:
          return;
      }
    
    /** Closing menu event */  
    case 'close':
      $("#main_container").html("");
      $("#main_container").css({
          display: 'none'
      });
      
      $("#clipboard").css({
        display: 'none'
      });
  }
});



/** Testing **/
$(document).ready(function() {
  $('#test-button-application').button().click(function () {
    console.log("Hello world!")
    openApplication(dummyApplicationData)
  });

  $('#test-button-manage').button().click(function () {
    console.log("Hello other world!");
    openManage(dummyManageData)
  });
});