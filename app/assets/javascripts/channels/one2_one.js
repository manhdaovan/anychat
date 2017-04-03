App.one2_one = App.cable.subscriptions.create("One2OneChannel", {
    received: function (data) {
        if (!isLoggedIn()) {
            return;
        }
        var box = getMessageBox(data['to_user'], data['from_user']);
        if (box.length == 0) {
            toastr.warning(' He just said: "' +
            data['msg'] + '". Search and chat with him if you want.', data['from_user'] +
            ' wants to chat with you.');
            this.addNotification(data['from_user'], data['msg']);
            return;
        }
        addMessageItemToBox(data['to_user'], data['from_user'], buildMessageItem(false, data['msg']));
    },
    addNotification: function (from_user, message) {
        $('#a-notification-icon i').addClass('text-red');
        var notiHtml = $('<li><span class="noti-from-user"></span>:&nbsp;<span class="noti-msg-content"></span></li>');
        notiHtml.find('.noti-from-user').text(from_user);
        notiHtml.find('.noti-msg-content').text(message.substr(0, 30) + ' ...');
        $('#ul-my-notification').prepend(notiHtml);
    }
});