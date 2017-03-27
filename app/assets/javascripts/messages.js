$(document).on('click', '.list-user-item', function () {
    var $this = $(this);
    var msgBox = $('#any-messages-boxes');
    msgBox.loading(true);
    $.ajax({
        url: '/users/online',
        type: 'post',
        data: {username: $this.data('username')},
        success: function (data) {
            buildMessageBox('manhdv', 'manhdv222', data);
        },
        error: function () {
            toastr.error('Error has been occurred. Please reload page and try again latter!');
        },
        complete: function(){
            msgBox.loading(false);
        }
    });
});

function buildMessageBox(from_username, to_username, extra_data) {
    console.log("extra_data", extra_data);
    $('.message-box-item').hide();
    var box = $('#msg-box-for-' + from_username + '-and-' + to_username);
    if (box.length > 0) {
        box.show(500);
    } else {
        var boxHtml = $($('#message-box-template').html());
        boxHtml.attr('id', 'msg-box-for-' + from_username + '-and-' + to_username);
        boxHtml.show(500);
        $('#any-messages-boxes').append(boxHtml);
    }
}