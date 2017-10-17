$(document).on('turbolinks:load', function() {
 var notifies = $('#notifies');
   App.notifications = App.cable.subscriptions.create({
     channel: "NotificationsChannel",
     account_id: $("#current-account-id").attr("value"),
   }, {
     connected: function() {},
     disconnected: function() {},
     received: function(data) {
       return notifies.prepend("<p>" + data["message"] + "</p>");
     },
   });
});
