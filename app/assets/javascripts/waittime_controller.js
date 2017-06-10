$(document).ready(function(){

  //hides waitlist form
  //toggle form on Add Party button
  $("#add-party-button").click(function(event){
    $("#add-party-form").toggle();
  })

  $("body").on("submit", "form#add-party-form", function(event) {
    event.preventDefault();
    $.ajax({
      method: "post",
      url: $(this).attr("action"),
      data: $(this).serialize()
    }).done(function(response){
      console.log(response)
      $(".waitlist").append(response);
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

  $(".waitlist").on("click", ".table-ready-btn", function(event){
    var phoneNumber = $(this).val();
    $.ajax({
      method: "get",
      url: '/waittimes/send_notice',
      data: {
        phone_number: phoneNumber
      }
    }).done(function(response){
      console.log(response)
      //figure out what to do after sms is sent
      alert('sent!')
    })
  })

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
  // lockScreen();

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
