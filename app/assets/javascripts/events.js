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
