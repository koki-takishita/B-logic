$(function(){
  var error_msg = document.getElementById('error_msg');
  var error_nil_msg = document.getElementById('error_nil_msg');
  if ( error_nil_msg === null && error_msg != null ){
    var errorModal = new bootstrap.Modal(document.getElementById('errorModal'), {
    keyboard: false
    });
  errorModal.show(); 
  }
});
