$(document).ready(function(){

  var $customerVisible = $('.customer-visible')
  var $employeeVisible = $('.employee-visible');
  var $pinInput = $(".pin-input, .pin-btn");
  var $popouts = $(".admin-popout, .pin-popout")

  var lockScreen = function(){
    $employeeVisible.hide();
    $customerVisible.show();
    $pinInput.hide();
    $(".unlock-screen-btn").show();
    $(".lock-screen-btn").hide();
    $(".lock-status").html("")
    $(".admin-dashboard").hide();
  };

  var unlockScreen = function(){
    $(".unlock-screen-btn").hide();
    $pinInput.show();
    $(".lock-screen-btn").show();
  }

  var hidePopouts = function(){
    $popouts.hide();
  }

  var setTablesNotReady = function(){
    $(".status .ready, .status .seat-party").hide()
  }

  $(".unlock-screen-btn").on("click", function(event){
    unlockScreen();
    $(".pin-popout").show();
  });
  $(".lock-screen-btn").on("click", function(event){
    lockScreen();
    $(".pin-popout").hide();
  });

  lockScreen();
  hidePopouts();
  setTablesNotReady();

  $(".pin-btn").on("click", function(event){
    if ( $(".pin-input").val() === '1234' ) {
      $pinInput.hide();
      $customerVisible.hide();
      $employeeVisible.show();
      $(".pin-popout").hide();
      $(".admin-dashboard").show();
      setTimeout(lockScreen, 15000);
      $(".lock-status").html("<p style='color:seagreen;'>Screen unlocked!</p><p style='color:orange;'>Will lock automatically in 5 seconds.</p>")
    }
    else {
      $(".lock-status").html("<p style='color:red;'>Incorrect pin!</p>")
    }
  });

  $(".admin-dashboard").on("click", function(){
    $(".admin-popout").toggle();
  });

});
