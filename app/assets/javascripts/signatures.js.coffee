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

  $(".enterprise-selector").click (e) ->

    # Mark button as selected
    $(".enterprise-selector").removeClass("selected")
    $(this).addClass("selected")

    # Adapt signature preview to the selected enterprise
    slug = $(this).attr('data-slug')

    # Update form input value
    $("#signature_enterprise").val(slug)

    # Enterprise conditions
    if slug == "tenzing"
      $("#signature-preview .tenzing").removeClass('hidden')
      main_logo = $('*[data-slug="urbegi"] img')[0]
      main_logo = $(main_logo).clone().removeClass('img-responsive')
      $("#signature-preview .main-logo").html(main_logo)
    else
      $("#signature-preview .tenzing").addClass('hidden')
      main_logo = $(this).find("img").clone().removeClass('img-responsive')
      $("#signature-preview .main-logo").html(main_logo)


  # Signature generator form handler
  $(document).on 'ajax:beforeSend', ".signature-generator form", ->
    $("#generator-loading").removeClass("hidden")







