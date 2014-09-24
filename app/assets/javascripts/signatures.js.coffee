# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery.validate
#= require jquery.validate.additional-methods
#= require jquery.validate.bootstrap.popover
#= require jquery.validate.localization/messages_es

$(document).ready ->
  $(".signature-generator form").validate_popover
    popoverPosition: 'right'

  $(".signature-generator form #toggleOptions").click (e) ->
    $(this).toggleClass("active")
    e.preventDefault()
    $("#signature-options").toggleClass('hidden')

