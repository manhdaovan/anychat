App.cable.subscriptions.create("AppearanceChannel", {
    lastOnOff: {},
    isRecentOnlineOrOffline: function (username, type) {
        var lastMsgAt = this.lastOnOff[type] || {} || this.lastOnOff[type][username];
        var now = Date.now();
        if (Object.size(lastMsgAt) > 0) {
            if (now - lastMsgAt >= 1000 * 60 * 90) { // 90 minutes
                this.lastOnOff[type][username] = now;
                return true;
            }
            return false;
        } else {
            this.lastOnOff[type] = {};
            this.lastOnOff[type][username] = now;
            return true;
        }
    },
    received: function (data) {
        if (data['username'] != getCurrentUser() && this.isRecentOnlineOrOffline(this, data['username'], data["type"])) {
            toastr.info(data['username'] + ' ' + data['type'], '', {timeOut: 3000});
            var extraData = {
                online: data['type'] == 'online',
                lock_send_msg: data['lock_send_msg']
            };
            if (extraData.online) {
                $('#user-' + data['username']).addClass('text-info');
            } else {
                $('#user-' + data['username']).removeClass('text-info');
            }
            buildMessageBox(getCurrentUser(), data['username'], extraData);
        }
    }
});