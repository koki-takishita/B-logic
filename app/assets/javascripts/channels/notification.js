App.notification = App.cable.subscriptions.create("NotificationChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log('接続しました');
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
    console.log('接続解除しました');
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    //return $('#task_name').after('<li>' + data.message + '</li>');
    alert(data.message);
  },

  post: function(message) {
    return this.perform('post', { message: message });
  }
}, $(document).on('keypress', '.task-field', function(event) {
    // 0を押したら発動
    if (event.keyCode === 48) {
          var chatForm = $('#task_name');
          App.notification.post(chatForm.val());
          return chatForm.val('');
        }
}));
