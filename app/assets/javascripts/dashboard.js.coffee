# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init(appId: '119635888197519', cookie: true)

  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true

$(document).ready ->
  # Variables
  user_id = $("body")[0].id
  tasks_url = "/user/" + user_id + "/tasks.json?action=new"



  # Snych tasks
  $.ajax
    type: "GET"
    dataType: "json"
    url: tasks_url
    success: (data) ->
      add_tasks_to_page data

  # Add tasks to html list
  add_tasks_to_page = (data) ->
    $.each data, (index, value) ->
      content = value.source + ": " + value.content
      $("ul#tasks").append "<li class=\"task\" data-action=\"new\"><p> " + content + "</p></li>"
      speak content
	

  # Speak tasks outloud 
  $("li").each ->
    if $(this).data("action") is "viewed"
      $(this).css "background", "grey"
    else if $(this).data("action") is "new"
      text = $("li.task").text()
      console.log "Speaking " + text
      speak text

  #poller
  #doPoll =  ->
    #console.log "Polling" # process results here
    #add_new_tasks ->
      ##console.log "Polling" # process results here
      #setTimeout doPoll, 5000
