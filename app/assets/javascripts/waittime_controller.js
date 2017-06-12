$(document).ready(function(){

  //hides waitlist form
  //toggle form on Add Party button
  $("#add-party-button").click(function(event){
    $("#add-party-form").toggle();
  })

  //add to wailist grays out unless all fields are filled
  $('#name, #party_size, #phone_number').bind('keyup', function() {
    if(allFilled()) $('#add-to-waitlist').removeAttr('disabled');
  })

  //checks that all fields are filled in
  function allFilled() {
    if (!($('#name').val() === '') && !($('#party_size').val() === '') && !($('#phone_number').val() === '')) {
      return true;
    }
    else {
      return false;
    }
  }

  $("body").on("submit", "form#add-party-form", function(event) {
    event.preventDefault();

    $.ajax({
      method: "post",
      url: $(this).attr("action"),
      data: $(this).serialize()
    }).done(function(response){
      $("#add-party-form").trigger("reset");
      $(".waitlist").append(response);
    }).fail(function(response){
      console.log(response)
      $(".errors").html(response)
    })
  })


  $(".waitlist").on("submit", ".seat-party", function(event){
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

  $(".waitlist").on("click", ".almost-ready", function(event){
    var waittimeId = $(this).parent().prop("id");
    $.ajax({
      method: "get",
      url: '/waittimes/send_notice',
      data: {
        id: waittimeId
      }
    }).done(function(response){
      $("#" + response).find('.almost-ready').css('background-color', 'red');
    })
  })

  // =============================================
  // Screen can be unlocked (for Cabin Boys/Girls)
  // =============================================


  var $customerVisible = $('.customer-visible')
  var $employeeVisible = $('.employee-visible');
  var $pinInput = $(".pin-input, .pin-btn");
  var lockScreen = function(){
    $employeeVisible.hide();
    $customerVisible.show();
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
      $customerVisible.hide();
      $employeeVisible.show();
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
