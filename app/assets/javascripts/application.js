// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  $("#user_username").bind("keyup input paste", function() {
    $("#msgbox").removeClass().addClass('messagebox').text('Checking...').fadeIn("slow");
    $.post("/checkuser",{ user_username:$(this).val() } ,function(data) {
	  if(data=='true') { 
        $("#msgbox").fadeTo(200,0.1,function() { 
          $(this).html('<font color="red">This User name Already exists</font>').addClass('messageboxerror').fadeTo(400,1);
        });
        } else {
          $("#msgbox").fadeTo(200,0.1,function() { 
          $(this).html('<font color="339900">Username available to register</font>').addClass('messageboxok').fadeTo(400,1);
        });
      }
    });
  });
});