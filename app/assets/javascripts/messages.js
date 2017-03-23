$(document).on('click', '.list-user-item', function () {
    console.log("dmmmOUT");
    buildMessageBox('manhdv', 'manhdv222');
});

function buildMessageBox(from_username, to_username) {
    console.log("dmmm");
    $('.message-box-item').hide();
    var box = $('#msg-box-for-' + from_username + '-and-' + to_username);
    if (box.length > 0) {
        box.show();
    } else {
        var boxHtml = $($('#message-box-template').html());
        boxHtml.attr('id', 'msg-box-for-' + from_username + '-and-' + to_username);
        boxHtml.show();
        $('#any-messages-boxes').append(boxHtml);
    }
}