$(document).ready(function(){

  $("waitlist").on("submit", "waittime-seat-form", function(){
    var $form = $(this)
    // UPDATE Waittime object in the database (set seated to true)
    $.ajax({
      method: "PUT",
      url: $form.attr("action"),

    })
    .done(function(response){
      // When done, remove the <li> from the list
    })
  })

});
