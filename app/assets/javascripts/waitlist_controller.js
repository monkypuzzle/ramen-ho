$(document).ready(function() {
  //hides waitlist form
  $("#add-party-form").toggle();
  //toggle form on Add Party button
  $("#add-party-button").click(function(event){
    $("#add-party-form").toggle();
  })

  $("#add-party-form").submit(function(event) {
    event.preventDefault();
    var waitList = $(this).serialize();
    console.log(JSON.stringify(waitList));
    // $.ajax({
    //   method: "post",
    //   data: $(this).serialize()
    // }).done(function(response){
    //   console.log(response);
    // })
  })
})
