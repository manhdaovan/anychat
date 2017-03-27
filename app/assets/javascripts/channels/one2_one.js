App.one2_one = App.cable.subscriptions.create("One2OneChannel", {
    received: function(data) {
        toastr.info(data['msg']);
    }
});