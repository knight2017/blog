$(document).ready(function() {

$.get("/jshomes", function(data){

    for( x in data) {
     $('#posts').prepend("<li data-id=" + data[x].id + ">"  + data[x].title + "</li><br>")

    }
});

$("#posts").on("click", "li", function(){
     var clickedElement = $(this);
    $.get("/jshomes/" + clickedElement.data("id"), function(data){
      for( x in data) {
       clickedElement.append("<br><i data-id=" + data[x].id + ">"  + data[x].body + "</i><br>")

      }
    })
    // window.location = "http://google.com";
    // $.ajax({
    //   method: "GET",
    //   url:    "/jshomes/" + $(this).data("id"),
    //   success: function(){
    //     console.log("/jshomes/" + $(this).data("id"));
    //     alert("hahha");
    //   }.bind(this),
    //   error: function() {
    //     console.log("/jshomes/" + $(this).attr("data-id"));
    //     console.log("/jshomes/" + $(this).data("id"));
    //     alert("123");
    //   }.bind(this)
    // });
  });






})
