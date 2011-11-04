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
    $("#spin").hide()  if $("#spin")
    link = $(this)
    $("#" + link.attr("data-update")).html status
    eval link.attr("data-success")  if link.attr("data-success")

  $("form[data-update]").live "ajax:beforeSend", ->
    $("#spin").show() if $("#spin")

  $("a[data-update]").live "ajax:success", (data, status, xhr) ->
    $("#spin").slideUp()  if $("#spin")
    link = $ this
    $("#" + link.attr("data-update")).html status
    $("#" + link.attr("data-update")).show()
    location.hash = link.attr("data-hash")  if link.attr("data-hash")
    eval link.attr("data-success")  if link.attr("data-success")

  $("a[data-append]").live "ajax:success", (data, status, xhr) ->
    $("#spin").slideUp()  if $ "#spin"
    link = $(this)
    $("#" + link.attr("data-append")).append status
    $("#" + link.attr("data-append")).show()
    location.hash = link.attr("data-hash")  if link.attr("data-hash")

  $("a[data-update]").live "ajax:beforeSend", ->
    link = $(this)
    $("#spin").show() if $("#spin") && link.attr("data-load") == "true"
    eval link.attr("data-before")  if link.attr("data-before")

  $("#spin").hide() if $("#spin")

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
  $(".cat_list li a").click ->
    $(".cat_list li a").removeClass "active"
    console.log $(this).attr("data-value")
    $("#"+$(this).attr("data-form") + "_post_category_id").val $(this).attr("data-value")
    $(this).addClass "active"
  $(".no_focus").focus ->
    $(this).removeClass "no_focus"
    $(this).addClass "on_focus"
    $(".submit_fields").show()
  $(".option_fields").hide()
  $(".open_options").click ->
    console.log "hre"
    $(".option_fields").toggle()
    true
  $(".browse li a").bind "ajax:beforeSend", ->
    $("#spin").show()
  $(".browse li a").bind "ajax:complete", ->
    $(this).addClass("active");
    $("#spin").hide()
  $(".submit_fields").hide()
