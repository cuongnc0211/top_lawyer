$(document).on("turbolinks:load", function(){
  $(".edit_cm_icon").click(function(e){
    e.preventDefault();
    var cmId = $(this).attr("data");
    $("#cm-content-" + cmId).toggle();
    $("#cm-form-" + cmId).toggle();
  });
});
