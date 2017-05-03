$(document).on("focus", ".datepicker",function(e){
  var date = $(this).val();
  $(this).datepicker({
    dateFormat: "mm/dd/yy",
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
