# Have problem with bind event throw coffeescript
# It create own scope for script content, therefore it is not comfortable move all
# bind method from view to coffee. I prefer see the binds near the element declaration.
# We can use -b option for coffee and evade wrapping, but it is not coffescript-way.
#
#jQuery(document).ready ->
#  class CheckButton
#    constructor: (@btn_id, @short_url_id) ->
#
#    bindClickEvent: ->
#      jQuery('#' + @btn_id).on 'click', ->
#        short_url = jQuery('input#' + @short_url_id).val()
#        if jQuery('#big_url_vc_short_url').val().length
#          jQuery.post '/',
#          check_alias: true
#          vc_short_url: short_url
#
#
#    # TODO: make event on field in any case (now event fire only after remove focus)
#    bindChangeEvent: ->
#      element_id = 'input#' + @short_url_id
#      jQuery(element_id).on 'change', ->
#        jQuery(element_id).removeClass('border_red').removeClass 'border_green'
#
## It must be in script-part of _forum template
#  check_button = new CheckButton('check_alias_btn', 'big_url_vc_short_url')
#  check_button.bindClickEvent()
#  check_button.bindChangeEvent()