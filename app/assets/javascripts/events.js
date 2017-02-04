$(document).on("focus", "[data-behaviour~='datepicker']",function(e){
  $(this).datepicker({
    format: "mm/dd/yyyy",
    autoclose: true
    })
});

// $(document).on("focus", "[data-behaviour~='timepicker']",function(e){
//   $(this).datepicker({
//     format: "LT",
//     autoclose: true
//     })
// });
