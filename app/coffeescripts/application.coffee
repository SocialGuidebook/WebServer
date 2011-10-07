basic_colorbox = ->
  $(".box").show()
  $(".post_form").hide()
  $(".option_fields").hide()
  $(".attach_description").hide()

color_box_iframe = ->
  onOpen: ->
    $("iframe").css "visibility", "hidden"
  onClosed: ->
    $("iframe").css "visibility", "visible"
    $(".box").hide()
  width: "50%"
  inline: true
  href: ".box"

$ ->
  $("form[data-update]").live "ajax:success", (data, status, xhr) ->
    $("#loading").hide()  if $("#loading")
    link = $(this)
    $("#" + link.attr("data-update")).html status
    eval link.attr("data-success")  if link.attr("data-success")

  $("form[data-update]").live "ajax:beforeSend", ->
    $("#loading").show()  if $("#loading")

  $("a[data-update]").live "ajax:success", (data, status, xhr) ->
    $("#loading").slideUp()  if $("#loading")
    link = $ this
    $("#" + link.attr("data-update")).html status
    $("#" + link.attr("data-update")).show()
    location.hash = link.attr("data-hash")  if link.attr("data-hash")
    eval link.attr("data-success")  if link.attr("data-success")

  $("a[data-append]").live "ajax:success", (data, status, xhr) ->
    $("#loading").slideUp()  if $ "#loading"
    link = $(this)
    $("#" + link.attr("data-append")).append status
    $("#" + link.attr("data-append")).show()
    location.hash = link.attr("data-hash")  if link.attr("data-hash")

  $("a[data-update]").live "ajax:beforeSend", ->
    link = $(this)
    $("#loading").show() if $("#loading") && link.attr("data-load") == "true"
    eval link.attr("data-before")  if link.attr("data-before")

  $("#loading").hide() if $("#loading")

jQuery.fn.reset = ->
  $(this).each ->
    @reset()

$ ->
  $(".show_post_form").click ->
    $(".show_post_form").colorbox $.extend(true,
      onLoad: ->
        basic_colorbox()
        $(".add_colums").hide()
        $(".show_post_form").removeClass "active"
        $(this).addClass "active"
        $("." + $(this).attr("data-label")).show()
        $("#post_post_type_id").val($(this).attr("data-post-type"))
      height: (if $(this).attr("data-height") then $(this).attr("data-height") else null)
    , color_box_iframe())
  $(".photo-list").colorbox();