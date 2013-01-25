#= require jquery
#= require ./lib/jquery_browser_patch/jquery_browser_patch
#= require jquery_ujs
#= require jquery.ui.core
#= require jquery.ui.widget
#= require jquery.ui.mouse
#= require jquery.ui.resizable
#= require jquery.ui.position
#= require jquery.ui.draggable
#= require jquery.ui.dialog
#= require jquery.effects.highlight
#= require jquery.effects.fade
#= require jquery.effects.slide
#= require jquery.ui.autocomplete
#= require turbolinks
#= require_self
#= require_tree .

$.ajaxSetup({
  beforeSend: (xhr) ->
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
})

window.hide_alerts = ->
  $('.alert').fadeOut(800)

$(document).on('pjax:end', window.hide_alerts)

jQuery.curCSS = jQuery.css