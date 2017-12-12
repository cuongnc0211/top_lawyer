$(document).on("turbolinks:load", function(){
  $(".create_comment").click(function(e){
    e.preventDefault();
    var answerId = $(this).attr("data");
    $("#answer-" + answerId).toggle();
  });

  $(".toggle_comments").click(function(e){
    e.preventDefault();
    var commentsId = $(this).attr("data");
    $("#comments-" + commentsId).toggle();
  });

  $(".prevent_default").click(function(e){
    e.preventDefault();
  });
});
