//= require jquery
//= require jquery_ujs
//= require_tree .

App.cable.subscriptions.create({
  channel: "FrenchToast::NotifierChannel"
}, {
  received: function(content) {
    if (content !== undefined) {
      $("[data-french-toast-content]").html(content);
    }
  }
});
