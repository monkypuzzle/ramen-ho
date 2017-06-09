$(document).ready(function(){

  //hides waitlist form
  $("#add-party-form").toggle();
  //toggle form on Add Party button
  $("#add-party-button").click(function(event){
    $("#add-party-form").toggle();
  })

  $("body").on("submit", "form#add-party-form", function(event) {
    event.preventDefault();
    var customer = new Customer(
      $("#name").val(),
      $("#phone_number").val(),
      $("#party_size").val()
      );
    $.ajax({
      method: "post",
      url: $(this).attr("action"),
      data: {
        customer: customer
      }
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

  $(".waitlist").on("click", ".almost-ready", function(event){
    var phoneNumber = $(this).val();
    $.ajax({
      method: "get",
      url: '/waittimes/send_notice',
      data: {
        phone_number: phoneNumber
      }
    }).done(function(response){
      console.log(response)
      alert('sent!')
    })
  })


});
