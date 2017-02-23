$(document).on("focus", "[data-behaviour~='datepicker']",function(e){
  date = $(this).val();
  $(this).datepicker({
    dateFormat: "dd/mm/yy",
    autoclose: true,
    setDate: date
  });
});

// $(document).on("focus", "[data-behaviour~='timepicker']",function(e){
//   $(this).datepicker({
//     format: "LT",
//     autoclose: true
//     })
// });

$(function(){
  setCheck();
  console.log($DOMAIN);
})
function setCheck(){
  $(".table").on("change",".checkbox",function(){
    var id = $(this).attr("check-id");
    $.ajax({
        type: "GET",
        url: $DOMAIN+"/events/check/"+id,
        success: function(data){
          $('#event-'+data.id).prop('checked',data.completed)
        },
        error: function(response){
          console.log("WARNING")
        }
      })
  })
}
