App.cable.subscriptions.create({
  channel: "NotifierChannel"
}, {
  received: function(data) {
    $("[data-french-toast-message]").text(data);
  }
});
