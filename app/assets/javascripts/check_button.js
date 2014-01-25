function bindClickEvent(btn_id, short_url_id) {
    jQuery('#' + btn_id).on('click', function() {
        var short_url = jQuery('input#' + short_url_id).val();
        if(jQuery('#big_url_vc_short_url').val().length) {
            jQuery.post(
                '/',
                {
                    check_alias: true,
                    vc_short_url: short_url
                }
            );
        }
    });
}

// TODO: make event on field in any case (now event fire only after remove focus)
function bindChangeEvent(short_url_id) {
    var element_id = 'input#' + short_url_id;
    jQuery(element_id).on('change', function() {
        jQuery(element_id).removeClass('border_red').removeClass('border_green');
    });
}