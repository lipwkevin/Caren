$(function(){
  $('.modal').on('hidden.bs.modal', function(){
    $(this).find(".error-message").html("");
  });
});
