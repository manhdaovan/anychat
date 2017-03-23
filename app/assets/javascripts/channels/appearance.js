App.cable.subscriptions.create("AppearanceChannel", {
    received: function(data) {
        console.log(data);
    }
});