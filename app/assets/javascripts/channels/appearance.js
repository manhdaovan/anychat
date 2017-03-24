App.cable.subscriptions.create("AppearanceChannel", {
    received: function(data) {
        toastr.info(data['username'] + ' ' + data['type']);
    }
});