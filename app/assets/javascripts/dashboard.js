
jQuery(function() {
  $('body').prepend('<div id="fb-root"></div>');
  return $.ajax({
    url: "" + window.location.protocol + "//connect.facebook.net/en_US/all.js",
    dataType: 'script',
    cache: true
  });
});

window.fbAsyncInit = function() {
  FB.init({
    appId: '119635888197519',
    cookie: true
  });
  return $('#sign_out').click(function(e) {
    FB.getLoginStatus(function(response) {
      if (response.authResponse) {
        return FB.logout();
      }
    });
    return true;
  });
};


$(document).ready(function() {

  var id   = $('body').data('id');

 // Continous Loop
  window.setInterval(function(){
    appendNewTasks();
    speakNewTasks();
  }, 5000);



  //Methods
  function speakNewTasks() {
    var text = "";
    $.each($('li.task'), function() { 
      if ($(this).data('action') == "new") {
        text = text + $(this).text();
        $(this).data('action') = 'viewed';
      }
    });
    if (text.length > 0) {
      speak(text);
    }
  } 

  function updateTask() {
    var data = { action: 'viewed', id: this.id }
    $.ajax({
      type: 'PUT',
      url:  '/user/' + id + '/tasks/' + data['id'] + '.json',
      data: data,
      dataType: "JSON",
      success: function(data) {
        console.log("Updated task " + id + "-" + data['source']);
      }
    });
  }
  
  function appendNewTask(data) {
    $('ul#tasks').prepend("<li class='task' data-action='" + data.action + "'> <p class='source'>" + data.source + "</p> <p class='content'>" + data.content + "</li>");
    updateTask();
  }


  function appendNewTasks() {
    $.ajax({
      url: "/user/" + id + "/tasks.json",
      type: "get",
      dataType: "json",
      success: function(data) {
        $.each(data, function() {
          appendNewTask(data);
          console.log(data);
        });
      }
    });
  };


//Document.ready  
});
