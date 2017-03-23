$(document).on("focus", ".datepicker",function(e){
  // debugger
  var date = $(this).val();
  $(this).datepicker({
    dateFormat: "dd/mm/yy",
    autoclose: true,
    setDate: date
  });
});

$(function(){
  // $('.datepicker').datepicker(

  // );
  $('.datepicker').on('change',function(){
    var date = $(this).val();
    document.cookie = "date="+date;
    location.reload();
    // window.location = location.href += "?date="+date;
  })
});
