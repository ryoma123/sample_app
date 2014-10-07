$ ->
  countMax = 140
  $(".count").html countMax
  $("#micropost_content").on "keydown keyup keypress change click", ->
    thisValueLength = $(this).val().length
    countDown = countMax - thisValueLength
    $(".count").html countDown

    if countDown < 0
      $(".count").css
        color: "#ff0000"
        fontWeight: "bold"
    else
      $(".count").css
        color: "#000000"
        fontWeight: "normal"
