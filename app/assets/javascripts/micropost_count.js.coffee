$ ->
  countMax = 140
  count = $(".count")
  count.html countMax
  $("#micropost_content").on "keydown keyup keypress change click", ->
    thisValueLength = $(this).val().length
    countDown = countMax - thisValueLength
    count.html countDown

    if countDown < 0
      count.addClass "negative_number"
    else
      count.removeClass "negative_number"
