$(document).on("focus", ".datepicker",function(e){
  $(this).datepicker({
    format: "dd/mm/yyyy",
    autoclose: true
    })
});

$(function(){
  // $('.datepicker').datepicker(

  // );
  $('.datepicker').on('change',function(){
    debugger
    var date = $(this).val();

  })
});
