$(document).on("focus", "[data-behaviour~='datepicker']",function(e){
  date = $(this).val();
  $(this).datepicker({
    dateFormat: "dd/mm/yy",
    autoclose: true,
    setDate: date
  });
});

$(function(){
  setCheck();
  // console.log($DOMAIN);
  $(document).on("click","#edit-modal .btn-success",function(){
    $(this).parent().siblings(".modal-body").children("form").trigger("submit.rails");
    console.log("wow");
  });
})
function setCheck(){
  $(".table").on("change",".checkbox",function(){
    var id = $(this).attr("check-id");
    $.ajax({
        url: $DOMAIN+"/events/check/"+id,
        type: "GET",
        crossDomain: true,
        dataType: "JSONP",
        success: function(data){

        },
        error: function(response){
          console.log("WARNING")
        }
      })
  })
}
