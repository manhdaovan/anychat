// Global setting for toastr
toastr.options.closeButton = true;
toastr.options.timeOut = 30 * 1000;
toastr.options.escapeHtml = true;

Object.size = function (obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};

$.fn.loading = function (show) {
    if (show) {
        console.log('show loading');
    } else {
        console.log('hide loading');
    }
};

var lastSubmit = Date.now();
function submitForm(submitBtn, preventSubmitCont) {
    var form = submitBtn.closest('form');
    var formValid = true;
    var validSubmitCont = true; // Default not prevent submit continuously
    if (preventSubmitCont) {
        validSubmitCont = lastSubmit <= Date.now() - 3000;
    }
    $.each(form.find('.required'), function (_, ele) {
        var $ele = $(ele);
        if ($ele.val() == '') {
            toastr.error($ele.data('required-msg'));
            formValid = false;
        }
    });
    if (formValid && validSubmitCont) {
        form.submit();
        if(preventSubmitCont){
            lastSubmit = Date.now();
        }
    }
}
$(document).on('autosearch', 'input[type="submit"]', function () {
    submitForm($(this), false);
});

$(document).on('click', 'input[type="submit"]', function (e) {
    e.preventDefault();
    e.stopPropagation();
    submitForm($(this), true);
});