$(document).ready(function(){

  var $pinInput = $(".pin-input, .pin-btn");
  var $popouts = $(".admin-popout, .pin-popout")
  var $confirm = $(".confirm")

  var lockScreen = function(){
    $('.employee-visible').hide();
    $('.customer-visible').show();
    $pinInput.hide();
    $confirm.hide();
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

  var showConfirm = function(buttonToReplace){
    var $confirm = buttonToReplace.next(".confirm");
    buttonToReplace.hide();  $confirm.show();
  };

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
      $('.employee-visible').show(); $(".admin-dashboard").show();
      $pinInput.hide(); $('.customer-visible').hide(); $(".pin-popout").hide();
      $(".pin-input").val("");
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
