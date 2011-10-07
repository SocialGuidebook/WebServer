/* DO NOT MODIFY. This file was compiled Thu, 06 Oct 2011 12:40:22 GMT from
 * /Users/nakatsugawa/Dropbox/socialguidebook/app/coffeescripts/application.coffee
 */

(function() {
  var basic_colorbox, color_box_iframe;
  basic_colorbox = function() {
    $(".box").show();
    $(".post_form").hide();
    $(".option_fields").hide();
    return $(".attach_description").hide();
  };
  color_box_iframe = function() {
    return {
      onOpen: function() {
        return $("iframe").css("visibility", "hidden");
      },
      onClosed: function() {
        $("iframe").css("visibility", "visible");
        return $(".box").hide();
      },
      width: "50%",
      inline: true,
      href: ".box"
    };
  };
  $(function() {
    $("form[data-update]").live("ajax:success", function(data, status, xhr) {
      var link;
      if ($("#loading")) {
        $("#loading").hide();
      }
      link = $(this);
      $("#" + link.attr("data-update")).html(status);
      if (link.attr("data-success")) {
        return eval(link.attr("data-success"));
      }
    });
    $("form[data-update]").live("ajax:beforeSend", function() {
      if ($("#loading")) {
        return $("#loading").show();
      }
    });
    $("a[data-update]").live("ajax:success", function(data, status, xhr) {
      var link;
      if ($("#loading")) {
        $("#loading").slideUp();
      }
      link = $(this);
      $("#" + link.attr("data-update")).html(status);
      $("#" + link.attr("data-update")).show();
      if (link.attr("data-hash")) {
        location.hash = link.attr("data-hash");
      }
      if (link.attr("data-success")) {
        return eval(link.attr("data-success"));
      }
    });
    $("a[data-append]").live("ajax:success", function(data, status, xhr) {
      var link;
      if ($("#loading")) {
        $("#loading").slideUp();
      }
      link = $(this);
      $("#" + link.attr("data-append")).append(status);
      $("#" + link.attr("data-append")).show();
      if (link.attr("data-hash")) {
        return location.hash = link.attr("data-hash");
      }
    });
    $("a[data-update]").live("ajax:beforeSend", function() {
      var link;
      link = $(this);
      if ($("#loading") && link.attr("data-load") === "true") {
        $("#loading").show();
      }
      if (link.attr("data-before")) {
        return eval(link.attr("data-before"));
      }
    });
    if ($("#loading")) {
      return $("#loading").hide();
    }
  });
  jQuery.fn.reset = function() {
    return $(this).each(function() {
      return this.reset();
    });
  };
  $(function() {
    $(".show_post_form").click(function() {
      return $(".show_post_form").colorbox($.extend(true, {
        onLoad: function() {
          basic_colorbox();
          $(".add_colums").hide();
          $(".show_post_form").removeClass("active");
          $(this).addClass("active");
          $("." + $(this).attr("data-label")).show();
          return $("#post_post_type_id").val($(this).attr("data-post-type"));
        },
        height: ($(this).attr("data-height") ? $(this).attr("data-height") : null)
      }, color_box_iframe()));
    });
    return $(".photo-list").colorbox();
  });
}).call(this);
