$(document).on('click', '.list-user-item', function () {
    var $this = $(this);
    $this.removeClass('search').addClass('current');
    var msgBox = $('#any-messages-boxes');
    msgBox.loading(true);
    $.ajax({
        url: '/users/online',
        type: 'post',
        data: {username: $this.data('username')},
        success: function (data) {
            if (data.online) {
                $('#user-' + $this.data('username')).addClass('text-info');
            }
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

$(document).on('keyup', 'textarea[name="message[msg_content]"]', function (e) {
    var $this = $(this);
    var box = $this.closest('.textarea-action');
    var displaySpan = box.find('#message-text-length');
    var textLen = $this.val().length;
    var sendButton = box.find('input[type="submit"]');
    if (textLen > 255) {
        sendButton.attr('disabled', 'disabled');
    } else {
        sendButton.removeAttr('disabled');
    }

    displaySpan.html(textLen);
});

function getCurrentUser() {
    return $('input[name="current_username"]').val();
}

function isLoggedIn() {
    return getCurrentUser();
}

function getMessageBox(from_user, to_user) {
    return $('#msg-box-for-' + from_user + '-and-' + to_user);
}

function buildMessageBox(from_username, to_username, extra_data) {
    $('.message-box-item').hide();
    var box = getMessageBox(from_username, to_username);
    var messageInput = box.find('textarea[name="message[msg_content]"]');

    if (box.length > 0) {
        if (extra_data.online) {
            box.find('.user-info .icon-online').addClass('online');
            messageInput.removeAttr('disabled');
            messageInput.attr('placeholder', 'Say something to that guy!');
            box.find('input[type="submit"]').removeAttr('disabled');
        } else {
            box.find('.user-info .icon-online').removeClass('online');
            messageInput.attr('disabled', 'disabled');
            messageInput.attr('placeholder', 'This guy is offline now. You cannot send message to him.');
            box.find('input[type="submit"]').attr('disabled', 'disabled');
        }
        box.find('.user-info .username').text(to_username);
        box.show(500);
    } else {
        var boxHtml = $($('#message-box-template').html());
        var messageInput = boxHtml.find('textarea[name="message[msg_content]"]');
        boxHtml.attr('id', 'msg-box-for-' + from_username + '-and-' + to_username);
        if (extra_data.online) {
            boxHtml.find('.user-info .icon-online').addClass('online');
        } else {
            boxHtml.find('.user-info .icon-online').removeClass('online');
            messageInput.attr('disabled', 'disabled');
            messageInput.attr('placeholder', 'This guy is offline now. You cannot send message to him.');
            boxHtml.find('input[type="submit"]').attr('disabled', 'disabled');
        }
        boxHtml.find('form input[name="message[to_user]"]').val(to_username);
        boxHtml.find('.user-info .username').text(to_username);
        boxHtml.show();
        $('#any-messages-boxes').append(boxHtml);
    }
}

function buildMessageItem(isMyMessage, message) {
    var messageItem = $('<div class="bubble"></div>');
    messageItem.text(message);
    if (isMyMessage) {
        messageItem.addClass('bubble--alt');
    }
    return messageItem;
}

function addMessageItemToBox(from_user, to_user, messageItem) {
    var box = getMessageBox(from_user, to_user);
    if (box.length == 0) return;
    box.find('.anychat-message-box-item').append(messageItem);
    scrollEleToBottom(box.find('.anychat-message-boxes'));
}

function clearMsgInput(from_user, to_user) {
    var box = getMessageBox(from_user, to_user);
    box.find('textarea[name="message[msg_content]"]').val('');
}

function scrollEleToBottom(ele) {
    ele.scrollTop(ele[0].scrollHeight);
}