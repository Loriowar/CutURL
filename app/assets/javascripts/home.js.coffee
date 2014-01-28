# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require easyResponsiveTabs

jQuery(document).ready ->
  jQuery('#serviceTabs').easyResponsiveTabs
    type: 'default' #Types: default, vertical, accordion
    width: 'auto' #auto or any width like 600px
    fit: true # 100% fit in a container
    # Until now we have one h1 per page
    activate: () ->
      title = jQuery('#mainTitle')
      if title.hasClass('cut_url_title')
        # TODO: here must be I18n function for js
        title.html('OneTimeURL')
        title.removeClass('cut_url_title')
        title.addClass('one_time_url_title')
      else if title.hasClass('one_time_url_title')
        # TODO: here must be I18n function for js
        title.html('CutURL')
        title.removeClass('one_time_url_title')
        title.addClass('cut_url_title')