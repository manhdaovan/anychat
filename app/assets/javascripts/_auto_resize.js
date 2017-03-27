/**
 * Auto increase textarea height
 */
$.fn.autoResize = function () {
    this.each(function () {
        var textarea = $(this),
            maxHeight = parseInt(textarea.data('max-height')) || 300,
            borderWidth = parseInt(textarea.css('border-top-width')) + parseInt(textarea.css('border-bottom-width'));

        // if this is not an textarea then do nothing
        if (!textarea.is('textarea')) return;

        // add style to textarea
        textarea.css('overflow', 'auto');

        // calculate line height
        var defaultValue = textarea.val(), offset, rows = textarea.attr('rows');
        textarea.css('height', 'auto').attr('rows', 2);
        offset = 10;
        textarea.val(defaultValue);

        textarea.off('keydown change cut paste drop').on('keydown change cut paste drop', function () {
            setTimeout(function () {
                var scrollLeft = window.pageXOffset ||
                    (document.documentElement || document.body.parentNode || document.body).scrollLeft;

                var scrollTop = window.pageYOffset ||
                    (document.documentElement || document.body.parentNode || document.body).scrollTop;

                textarea.css('height', 'auto');
                var height = textarea[0].scrollHeight + borderWidth;
                if (height <= maxHeight) {
                    height += offset;
                } else {
                    height = maxHeight;
                }
                textarea.css('height', height + 'px');
                window.scrollTo(scrollLeft, scrollTop);
            }, 0);
        });
    });
};
