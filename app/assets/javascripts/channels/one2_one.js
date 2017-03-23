App.one2_one = App.cable.subscriptions.create("One2OneChannel", {
    received: function(data) {
        //Called when there's incoming data on the websocket for this channel
    }
});