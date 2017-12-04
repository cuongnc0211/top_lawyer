$(document).on("turbolinks:load", function(){
  $(".vote_button").click(function(e){
    e.preventDefault();
    $(this).parent().submit();
  });
});