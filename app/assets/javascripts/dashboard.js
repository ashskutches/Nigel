
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

  var text = ""

  $.each($('li.task'), function() { 
    if ($(this).data('action')) {
      text = text + $(this).text();
    }
  });


  window.setInterval(function(){
    addNewTasks();
  }, 5000);
  
  function addNewTasks() {
    $.ajax({
      url: "/user/1/tasks.json",
      type: "get",
      dataType: "json",
      success: function(data) {
        $.each(data, function() {
          data = { action: 'viewed', id: this.id }
          $('ul#tasks').prepend("<li class='task' data-action='" + this.action + "'> <p class='source'>" + this.source + "</p> <p class='content'>" + this.content + "</li>");
	  updateTask(data);
	  speak(this.source + this.content);
        });
      }
    });
  };

  function updateTask(data) {
    $.ajax({
      type: 'PUT',
      url:  '/user/1/tasks/' + data['id'] + '.json',
      data: data,
      dataType: "JSON",
      success: function(data) {
        console.log("Updated");
      }
    });
  }


//Document.ready  
});
