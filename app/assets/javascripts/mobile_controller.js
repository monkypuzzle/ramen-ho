$(document).ready(function(){
  $(".restaurant-info").hide();

  $(".restaurant-tab-container").on("click", function(event) {
    var restaurant = $(this).find(".restaurant-tab").prop('id');
    var restaurantId = getRestaurantId(restaurant)
    $("#restaurant-info-" + restaurantId).slideToggle("slow");
  })

  function checkAllWaittime() {
    $(".restaurants-wrapper").children().each(function() {
    var htmlId = $(this).prop('id')
    console.log(htmlId);
    getWaittime(getRestaurantId(htmlId));
  })
  }

  function getWaittime(restaurantId) {
    var restaurantUrl = "/restaurants/" + restaurantId +"/waittime"
    $.ajax({
      method: "get",
      url: restaurantUrl,
      data: { id: restaurantId }
    }).done(function(response){
      console.log(response)
      $("#restaurant-" + restaurantId).find(".waittime-display").replaceWith("<p class='waittime-display'>" + response + " minutes</p>")
    })
  }

  function getRestaurantId(htmlId) {
    var match = htmlId.match(/\d+/g);
    return match[0];
  }

  setInterval(checkAllWaittime, 60000)
})
