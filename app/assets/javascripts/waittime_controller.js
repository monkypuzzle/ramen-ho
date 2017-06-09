$(document).ready(function(){

  $(".waitlist").on("submit", ".waittime-seat-form", function(event){
    event.preventDefault()
    var $form = $(this);
    var $chosenWaittimeItem = $(this).closest(".waittime-item");
    var waittimeId = $chosenWaittimeItem.attr("id").replace("waittime-","");
    console.log(waittimeId)
    var data = {'waittime': {'id': waittimeId}};
    // UPDATE Waittime object in the database (set seated to true)
    $.ajax({
      method: "PATCH",
      url: $form.attr("action"),
      dataType: "json",
      data: data
    })
    .done(function(response){
      // When done, remove the <li> from the list
      $chosenWaittimeItem.remove();
    });
  });

});