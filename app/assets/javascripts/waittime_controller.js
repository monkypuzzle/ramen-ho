$(document).ready(function(){

  //hides waitlist form
  //toggle form on Add Party button
  $("#add-party-button").click(function(event){
    $(".form-container").toggle();
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
      console.log(response)
      $("#add-party-form").trigger("reset");
      if (Array.isArray(response)) {
        $(".errors").html(listErrors(response))
      }
      else {
      $(".errors").hide();
      $(".form-container").toggle();
      $(".waitlist").append(response);
      $(".errors").html("");
      $(".employee-visible").hide();
      }
    })
  })

  $("#cancel-party-button").on("click", function(event){
    $(".form-container").hide();
  })

  function listErrors(errors) {
    html = ""
    $(".errors").show();
    errors.forEach(function(error) {
      html += ("<li>" + error + "</li>")
    })
    return html
  }

  var updateWaittimes = function(est_waittimes){
    Object.keys(est_waittimes).forEach(function(property){
      id = "#waittime-" + property
      $(id).find(".customer-visible .waittime").html("").html(est_waittimes[property] + " minutes")
    })
  }

  $(".waitlist").on("submit", ".seat-party", function(event){
    event.preventDefault();
    $(this).toggle();
    var $chosenWaittimeItem = $(this).closest(".waittime-item");
    var waittimeId = $chosenWaittimeItem.attr("id").replace("waittime-","");
    var data = {'waittime': {'id': waittimeId}};
    $.ajax({
      method: "PATCH",
      url: $(this).attr("action"),
      dataType: "json",
      data: data
    })
    .done(function(response){
      updateWaittimes(response)
      var keyOfMostRecentWaittime = Object.keys(response).reduce(function(a,b){return Math.max(a,b)});
      var currentWaitTime = (response[(keyOfMostRecentWaittime)]) + 6
      $(".current-estimated-wait").html(currentWaitTime + " min")
      $chosenWaittimeItem.remove();
    });
  });


  $(".waitlist").on("click", ".almost-ready", function(event){
    $(this).toggle();
    $(this).next(".almost-ready-confirm").slideDown(150);
  })

  $(".waitlist").on("click", ".seat-party-btn", function(event){
    $(this).toggle();
    $(this).siblings(".seat-party").show()
    $(this).siblings(".seat-party").find('.seat-party-confirm').slideDown(150);
  })

  $(".waitlist").on("click", ".almost-ready-confirm", function(event){
    $(this).toggle();
    $(this).siblings(".seat-party-btn").show();
    var waittimeId = $(this).closest("li").prop("id");
    $.ajax({
      method: "get",
      url: '/waittimes/send_notice',
      data: {
        id: waittimeId
      }
    }).done(function(response){
      $("#" + response).find('.status .waittime').toggle()
      $("#" + response).find('.status .ready').toggle()
    })
  })

  function pollCurrentWaittime() {
    var restaurantUrl = "/restaurants/" + $('#restaurant-name-header').data('id') + "/currentwaittime"
    $.ajax({
      method: "get",
      url: restaurantUrl
    }).done(function(response){
      console.log(response)
      var time = response.time
      $('.current-estimated-wait').text(time + " min")
    })
  }
  setInterval(pollCurrentWaittime, 60000)


});
