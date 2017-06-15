$(document).ready(function(){

  var lockScreen = function(){
    $('.employee-visible').hide();
    $('.customer-visible').show();
    $(".pin-input, .pin-btn").hide();
    $(".pin-popout, .admin-popout").hide();
    $(".confirm").hide();
    $(".unlock-screen-btn").show();
    $(".lock-screen-btn").hide();
    $(".lock-status").html("").hide();
    $(".admin-dashboard").hide();
    console.log("lockScreen fired!")
  };

  var unlockTimeout
  var setTimedLockout = function(){
    console.log('setTimedLockout starting!')
    unlockTimeout = setTimeout(lockScreen, 30000)
  };

  var unlockScreen = function(){
    $(".unlock-screen-btn").hide();
    $(".pin-input, .pin-btn").show();
    $(".lock-screen-btn").show();
  }

  var hidePopouts = function(){
    $(".admin-popout, .pin-popout").hide();
  }

  var setTablesNotReady = function(){
    $(".status .ready, .status .seat-party").hide()
  }

  var showConfirm = function(buttonToReplace){
    var $confirm = buttonToReplace.next(".confirm");
    buttonToReplace.hide();
    $confirm.show();
  };

  $(".unlock-screen-btn").on("click", function(event){
    console.log("Unlock click!")
    unlockScreen();
    $(".pin-popout").show();
    clearTimeout(unlockTimeout)
  });
  $(".lock-screen-btn").on("click", function(event){
    console.log("Lock click!")
    lockScreen();
    $(".pin-input").val("");
    $(".pin-popout").hide();
    clearTimeout(unlockTimeout);
  });

  lockScreen();
  hidePopouts();
  setTablesNotReady();

  $(".pin-btn").on("click", function(event){
    if ( $(".pin-input").val() === '1234' ) {
      $('.employee-visible').show();
      $(".admin-dashboard").show();
      $(".pin-input, .pin-btn").hide(); $('.customer-visible').hide(); $(".pin-popout").hide();
      $(".pin-input").val("");
      setTimedLockout();
    }
    else {
      $(".lock-status").html("Incorrect pin!")
      $(".lock-status").show();
    }
  });

  $(".admin-dashboard").on("click", function(){
    $(".admin-popout").toggle();
  });

});
