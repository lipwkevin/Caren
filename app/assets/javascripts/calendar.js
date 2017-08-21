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
    $.cookie('date',date,{path:'/'});
    location.href = location.href.replace(/[\?].*/,'');
    // location.reload();
    // window.location = location.href += "?date="+date;
  });
  $("#switchViewBtn").on('click',function(){
    $("#calendar-table").toggleClass("hidden");
    $("#calendar-list").toggleClass("hidden");
    $("#switchViewBtn").html($("#calendar-table").hasClass("hidden")? "Calendar View" : "Table View");
  });
  $(".calendar-div-true,.calendar-weekly").click(function(){
    date = $(this).attr('value')
    window.location.replace($DOMAIN+"/calendar/Daily?date="+date)
  });
});

function switchView(){
  debugger;
}
