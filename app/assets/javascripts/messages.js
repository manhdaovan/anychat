$(document).on('click', '.list-user-item', function () {
    var $this = $(this);
    var msgBox = $('#any-messages-boxes');
    msgBox.loading(true);
    $.ajax({
        url: '/users/online',
        type: 'post',
        data: {username: $this.data('username')},
        success: function (data) {
            buildMessageBox($('input[name="current_username"]').val(), $this.data('username'), data);
        },
        error: function () {
            toastr.error('Error has been occurred. Please reload page and try again latter!');
        },
        complete: function () {
            msgBox.loading(false);
        }
    });
});

function buildMessageBox(from_username, to_username, extra_data) {
    $('.message-box-item').hide();
    var box = $('#msg-box-for-' + from_username + '-and-' + to_username);
    if (box.length > 0) {
        if (extra_data.online) {
            box.find('.user-info .icon-online').addClass('online');
        } else {
            box.find('.user-info .icon-online').removeClass('online');
        }
        box.find('.user-info .username').text(to_username);
        box.show(500);
    } else {
        var boxHtml = $($('#message-box-template').html());
        boxHtml.attr('id', 'msg-box-for-' + from_username + '-and-' + to_username);
        if (extra_data.online) {
            boxHtml.find('.user-info .icon-online').addClass('online');
        } else {
            boxHtml.find('.user-info .icon-online').removeClass('online');
        }
        boxHtml.find('form input[name="message[to_user]"]').val(to_username);
        boxHtml.find('.user-info .username').text(to_username);
        boxHtml.show();
        $('#any-messages-boxes').append(boxHtml);
    }
}