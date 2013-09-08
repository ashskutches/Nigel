
// Setup
var create_email = false;
var final_transcript = '';
var recognizing = false;
var ignore_onend;
var start_timestamp;
var response;

if (!('webkitSpeechRecognition' in window)) {
  upgrade();
}
else {
  var recognition = new webkitSpeechRecognition();
  recognition.continuous = true;
  recognition.interimResults = true;
  recognition.onstart = function() {
    console.log("Starting");
    if (recognizing) {
      recognition.stop();
      return;
    }
  }

  recognition.onresult = function(event) {
    var interim_transcript = '';

    for (var i = event.resultIndex; i < event.results.length; ++i) {
      if (event.results[i].isFinal) {
        if (event.results[i][0].transcript.indexOf("Nigel") > -1) {
          final_transcript = event.results[i][0].transcript;
          $('#results').text(final_transcript);
          console.log(final_transcript);
$.ajax({
   type: "POST",
   url: "/nigal",
   data: { content: final_transcript },
   success: function(msg){
     speak(msg['text']) ;
    $('#nigal_says').text(msg['text']);
    console.log(msg['text']);
   }
 });
        }
      } else {
        interim_transcript += event.results[i][0].transcript;
        $('#results').text(interim_transcript);
      }
    }
  }


  recognition.onerror = function(event) {}

  recognition.onend = function() {}

}



function startButton() {
  final_transcript = '';
  recognition.start();
}

function upgrade() {
  start_button.style.visibility = 'hidden';
  showInfo('info_upgrade');
}
