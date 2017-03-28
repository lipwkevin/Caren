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
  var csrf_token = '<%= token_value %>';
  $("body").bind("ajaxSend", function(elm, xhr, s){
     if (s.type == "POST") {
        xhr.setRequestHeader('X-CSRF-Token', csrf_token);
     }
  });
  $(document).on("click","#edit-modal .btn-success",function(){
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
