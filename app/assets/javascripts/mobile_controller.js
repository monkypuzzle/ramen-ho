$(document).ready(function(){

  function checkAllWaittime() {
    $(".restaurants-wrapper").children().each(function() {
    var htmlId = $(this).prop('id')
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
      $("#restaurant-" + restaurantId).find("p").eq(1).replaceWith("<p>" + response + "</p>")
    })
  }

  function getRestaurantId(htmlId) {
    var match = htmlId.match(/\d+/g);
    return match[0];
  }

  setInterval(checkAllWaittime, 60000)
})
