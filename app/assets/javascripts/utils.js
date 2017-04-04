// Global setting for toastr
toastr.options.closeButton = true;
toastr.options.timeOut = 30 * 1000;
toastr.options.escapeHtml = true;

Object.size = function(obj){
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};

$.fn.loading = function(show) {
    if(show){
        console.log('show loading');
    }else{
        console.log('hide loading');
    }
};

var lastSubmit = Date.now();
$(document).on('click', 'input[type="submit"]',function(e){
    e.preventDefault();
    e.stopPropagation();
    var form = $(this).closest('form');
    var formValid = true;
    $.each(form.find('.required'), function(_, ele){
        var $ele = $(ele);
        if ($ele.val() == ''){
            toastr.error($ele.data('required-msg'));
            formValid = false;
        }
    });
    // Prevent submit continuously 3seconds
    if(formValid && (lastSubmit <= Date.now() - 3000)){
        lastSubmit = Date.now();
        form.submit();
    }
});