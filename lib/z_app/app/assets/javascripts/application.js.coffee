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

init_tooltip = (element) ->
  content = element.find(".tooltip-content").text()
  if content == ""
    content = element.attr("data-tooltip-content")
  element.tooltip(
    title: content,
    placement: element.attr('data-tooltip-placement') || 'left',
    trigger: element.attr('data-tooltip-trigger') || 'hover'
  )

init_tooltips = ->
  $(".tooltip-anchor").each( ->  
    init_tooltip($(this))
  )

$(".tooltip-anchor").livequery( ->
  init_tooltip($(this))
)

# $(document).bind('ready page:load', ->
#   init_tooltips()
# )