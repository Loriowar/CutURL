# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require easyResponsiveTabs

jQuery(document).ready ->
  jQuery('#serviceTabs').easyResponsiveTabs
    type: 'default' #Types: default, vertical, accordion
    width: 'auto' #auto or any width like 600px
    fit: true # 100% fit in a container
    activate: change_title_action

change_title_action = () ->
  #TODO: find how change tabs name
  active_tab = jQuery('.resp-tab-active')
  title = jQuery('#mainTitle')
  if active_tab.hasClass('cut_url_tail')
    title.html(I18n.t('home_cut_url.title'))
  else if active_tab.hasClass('one_time_url_tail')
    title.html(I18n.t('home_one_time_url.title'))