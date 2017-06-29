function toggleShow (target) {
  var active = $(".active")
  active.slideUp(800);
  if(!target.hasClass("active")){
    target.slideDown(800);
    target.addClass("active");
  }
  active.toggleClass("active");
}

$(function(){
  $('.user-info').not('.btn').click(function() {
    toggleShow($(this).children(".no-show"));
  });
})
