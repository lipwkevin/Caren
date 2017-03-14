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
  // console.log($DOMAIN);
  $(document).on("click","#edit-modal .btn-success",function(){
    debugger
    $(this).parent().siblings(".modal-body").children("form").trigger("submit.rails");
    console.log("wow");
  });
})
function setCheck(){
  $(".table").on("change",".checkbox",function(){
    var id = $(this).attr("check-id");
    $.ajax({
        type: "GET",
        url: $DOMAIN+"/events/check/"+id,
        success: function(data){
          $('#event-'+data.id).prop('checked',data.completed)
          $('#event-'+data.id).parents('tr').toggleClass('strikeout')
        },
        error: function(response){
          console.log("WARNING")
        }
      })
  })
}
