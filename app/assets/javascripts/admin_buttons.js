$(document).ready(function(){

  var lockScreen = function(){
    $employeeVisible.hide();
    $customerVisible.show();
    $pinInput.hide();
    $(".unlock-screen-btn").show();
    $(".lock-screen-btn").hide();
    $(".lock-status").html("")
  };
  $(".lock-screen-btn").on("click", function(event){
    lockScreen();
  });

  var unlockScreen = function(){
    $(".unlock-screen-btn").hide();
    $pinInput.show();
    $(".lock-screen-btn").show();
  }
  $(".unlock-screen-btn").on("click", function(event){
    unlockScreen();
  });

  var setTablesNotReady = function(){
    $(".status .ready, .status .seat-party").hide()
  }

  // Default screen to locked, tables to not ready
  lockScreen();
  setTablesNotReady();

  // Cabin Boy/Girl can enter pin to unlock screen
  $(".pin-btn").on("click", function(event){
    // If pin correct, unlock screen
    if ( $(".pin-input").val() === '1234' ) {
      $pinInput.hide();
      $customerVisible.hide();
      $employeeVisible.show();
      // (Lock screen automatically after 15 seconds)
      setTimeout(lockScreen, 15000);
      $(".lock-status").html("<p style='color:seagreen;'>Screen unlocked!</p><p style='color:orange;'>Will lock automatically in 5 seconds.</p>")
    }
    // If pin incorrect, give alert
    else {
      $(".lock-status").html("<p style='color:red;'>Incorrect pin!</p>")
    }
  });

}
