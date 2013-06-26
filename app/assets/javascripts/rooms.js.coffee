$ ->
  $review = $(".review")

  $review.bind "ajax:beforeSend", ->
    $(this).find("input").attr "disabled", true

  $review.bind "ajax:error", ->
    replaceButton this, "icon-remove", "#B94A48"

  $review.bind "ajax:success", ->
    replaceButton this, "icon-ok", "#468847"

  replaceButton = (container, icon_class, color) ->
    $(container).find("input:submit").
      replaceWith $("<i/>").
      addClass(icon_class).
        css("color", color)

  highlightStars = (elem) ->
    elem.parent().children("label").removeClass "toggled"
    elem.addClass("toggled").prevAll("label").addClass "toggled"

  highlightStars $(".review input:checked + label")

  $stars = $(".review input:enabled ~ label")

  $stars.on "mouseenter", ->
    highlightStars $(this)

  $stars.on "mouseleave", ->
    highlightStars $(".review input:checked + label")

  $(".review input").on "change", ->
    $stars.off("mouseenter").off("mouseleave").off "click"
    $(this).parent("form").submit()