# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require easyResponsiveTabs

jQuery(document).ready ->
  jQuery('#appTabs').easyResponsiveTabs
    type: 'default' #Types: default, vertical, accordion
    width: 'auto' #auto or any width like 600px
    fit: true # 100% fit in a container