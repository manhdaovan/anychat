App.cable.subscriptions.create("AppearanceChannel", {
    lastOnOff: {},
    isRecentOnlineOrOffline: function (_this, username, type) {
        var lastMsgAt = _this.lastOnOff[type] || {} || _this.lastOnOff[type][username];
        var now = Date.now();
        if (Object.size(lastMsgAt) > 0) {
            if (now - lastMsgAt >= 1000 * 60 * 90) { // 90 minutes
                _this.lastOnOff[type][username] = now;
                return true;
            }
            return false;
        } else {
            _this.lastOnOff[type] = {};
            _this.lastOnOff[type][username] = now;
            return true;
        }
    },
    received: function (data) {
        if (data['username'] != getCurrentUser() && this.isRecentOnlineOrOffline(this, data['username'], data["type"])) {
            toastr.info(data['username'] + ' ' + data['type']);
        }
    }
});