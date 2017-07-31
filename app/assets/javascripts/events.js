$(document).on("focus", "[data-behaviour~='datepicker']",function(e){
  date = $(this).val();
  $(this).datepicker({
    dateFormat: "mm/dd/yy",
    autoclose: true,
    setDate: date
  });
});

$(function(){
  setCheck();
  $(document).on("click","#edit-modal .btn-success",function(){
    $(this).parent().siblings(".modal-body").children("form").trigger("submit.rails");
    console.log("wow");
  });
  $("#toggleRepeatBtn").click(function(){
    $("#RepeatForm").removeClass("hidden");
  });
  $("#repeatSelector").change(function(){
      var repeatOption = $(this).val();
      var response = "";
      $("#repeatQuantityDiv").removeClass("hidden")
      $("#repeatSelectionDiv").removeClass("col-sm-offset-3")
      switch(repeatOption){
        case "Daily":
          response = "Days";
          break;
        case "Weekly":
          response = "Weeks";
          break;
        case "Monthly":
          response = "Months";
          break;
        default:
        $("#repeatQuantityDiv").addClass("hidden")
        $("#repeatSelectionDiv").addClass("col-sm-offset-3")
          break;
      }
      $("#repeatUnitIndex").html(response);
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
