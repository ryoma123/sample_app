# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  countMax = 140
  $("textarea#micropost_content").bind "keydown keyup keypress change click", ->
    thisValueLength = $(this).val().length
    countDown = (countMax) - (thisValueLength)
    $(".count").html countDown

    if countDown < 0
      $(".count").css
        color: "#ff0000"
        fontWeight: "bold"
    else
      $(".count").css
        color: "#000000"
        fontWeight: "normal"
    return
  $(window).load ->
    $(".count").html countMax
    return
  return
