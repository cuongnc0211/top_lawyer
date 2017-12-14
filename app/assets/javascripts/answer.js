$(document).on("turbolinks:load", function(){
  $(".edit_answer_icon").click(function(e){
    e.preventDefault();
    var ansId = $(this).attr("data");
    $("#answer-content-" + ansId).toggle();
    $("#answer-form-" + ansId).toggle();
  });
});
