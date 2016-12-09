App.cable.subscriptions.create({
 channel: "NotifierChannel"
}, {
 received: function(data) {
   jQuery("body").append(data);
 }
});
