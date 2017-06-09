$(document).ready(function(){

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
      $(".waitlist").append("<li #id='waittime-" + response.id + "'><span>" + customerName + "</span> - <span>Wait Time</span> - <button type='submit'>Table Almost Ready!</button><form class='waittime-seat-form' action='/waittimes/1'><button type='submit'>Seat this Party</button></form></li>")
    })
  })


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

  // =============================================
  // Screen can be unlocked (for Cabin Boys/Girls)
  // =============================================
  var $privilegedButtons = $(".table-ready-btn, .seat-party-btn");
  var $pinInput = $(".pin-input, .pin-btn");
  var lockScreen = function(){
    $privilegedButtons.hide();
    $pinInput.hide();
    $(".unlock-screen-btn").show();
    $(".lock-screen-btn").hide();
    $(".lock-status").html("")
  };
  // Default screen to locked
  lockScreen();

  // Cabin Boy/Girl can show pin form
  $(".unlock-screen-btn").on("click", function(event){
    $(this).hide();
    $pinInput.show();
  });
  
  // Cabin Boy/Girl can enter pin to unlock screen
  $(".pin-btn").on("click", function(event){
    // If pin correct, unlock screen
    if ( $(".pin-input").val() === '1234' ) {
      $pinInput.hide();
      $privilegedButtons.show();
      $(".lock-screen-btn").show();
      // (Lock screen automatically after 15 seconds)
      setTimeout(lockScreen, 15000);
      $(".lock-status").html("<p style='color:seagreen;'>Screen unlocked!</p><p style='color:orange;'>Will lock automatically in 5 seconds.</p>")
    }
    // If pin incorrect, give alert
    else {
      $(".lock-status").html("<p style='color:red;'>Incorrect pin!</p>")
    }
  });

  // Cabin Boy/Girl can re-lock screen when they are done
  $(".lock-screen-btn").on("click", function(event){
    lockScreen();
  });


});