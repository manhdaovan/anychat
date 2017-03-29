App.one2_one = App.cable.subscriptions.create("One2OneChannel", {
    received: function (data) {
        if (!isLoggedIn()) {
            return;
        }
        var box = getMessageBox(data['to_user'], data['from_user']);
        if (box.length == 0) {
            toastr.warning(' He just said: "' +
            data['msg'] +'". Search and chat with him if you want.', data['from_user'] +
            ' wants to chat with you.');
            return;
        }
        addMessageItemToBox(data['to_user'], data['from_user'], buildMessageItem(false, data['msg']));
    }
});