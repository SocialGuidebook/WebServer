/* DO NOT MODIFY. This file was compiled Thu, 20 Oct 2011 11:30:33 GMT from
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
      if ($("#spin")) {
        $("#spin").hide();
      }
      link = $(this);
      $("#" + link.attr("data-update")).html(status);
      if (link.attr("data-success")) {
        return eval(link.attr("data-success"));
      }
    });
    $("form[data-update]").live("ajax:beforeSend", function() {
      if ($("#spin")) {
        return $("#spin").show();
      }
    });
    $("a[data-update]").live("ajax:success", function(data, status, xhr) {
      var link;
      if ($("#spin")) {
        $("#spin").slideUp();
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
      if ($("#spin")) {
        $("#spin").slideUp();
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
      if ($("#spin") && link.attr("data-load") === "true") {
        $("#spin").show();
      }
      if (link.attr("data-before")) {
        return eval(link.attr("data-before"));
      }
    });
    if ($("#spin")) {
      return $("#spin").hide();
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
    $(".photo-list").colorbox();
    $(".cat_list li a").click(function() {
      $(".cat_list li a").removeClass("active");
      console.log($(this).attr("data-value"));
      $("#" + $(this).attr("data-form") + "_post_category_id").val($(this).attr("data-value"));
      return $(this).addClass("active");
    });
    $(".no_focus").focus(function() {
      $(this).removeClass("no_focus");
      $(this).addClass("on_focus");
      return $(".submit_fields").show();
    });
    $(".option_fields").hide();
    $(".open_options").click(function() {
      console.log("hre");
      $(".option_fields").toggle();
      return true;
    });
    $(".browse li a").bind("ajax:beforeSend", function() {
      return $("#spin").show();
    });
    $(".browse li a").bind("ajax:complete", function() {
      $(this).addClass("active");
      return $("#spin").hide();
    });
    return $(".submit_fields").hide();
  });
}).call(this);
