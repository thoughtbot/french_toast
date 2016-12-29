App.cable.subscriptions.create({
  channel: "NotifierChannel"
}, {
  received: function(content) {
    if (content !== undefined) {
      $("[data-french-toast-content]").html(content);
    }
  }
});
