$(function(){
  // mergecell('day-col');
  // mergecell('time-col');
});


function mergecell(colClass){
  var topMatchTd;
  var previousValue = "";
  var rowSpan = 1;
  $('.'+colClass).each(function(){
     if($(this).text() == previousValue){
       rowSpan++;
       $(topMatchTd).attr('rowspan',rowSpan);
       $(this).remove();
     } else {
       topMatchTd = $(this);
       rowSpan = 1;
     }
     previousValue = $(this).text();
  });
}
