$(document).ready(function() {
  //hides waitlist form
  $("#add-party-form").toggle();
  //toggle form on Add Party button
  $("#add-party-button").click(function(event){
    $("#add-party-form").toggle();
  })

  $("#add-party-form").submit(function(event) {
    event.preventDefault();
    var partySize = $("#party_size").val();
    var customerName = $("#name").val();
    var customerPhone = $("#phone_number").val();
    $.ajax({
      method: "post",
      url: $(this).attr("action"),
      dataType: "json",
      data: {
        party_size: partySize
      }
    }).done(function(response){
      console.log(response);
      $(".waitlist").append("<li #id='waittime-" + response.id + "'><span>" + customerName + "</span> - <span>Wait Time</span><button type='submit'>Table Almost Ready!</button><form class='waittime-seat-form' action='/waittimes/1'><button type='submit'>Seat this Party</button></form></li>")
    })
  })
})
