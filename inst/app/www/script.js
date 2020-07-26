$( document ).ready(function() {
  let github_icon = "body > nav > div > ul > li:nth-child(4) > a";
  $(github_icon).attr({
    href: "https://github.com/",
    target: "_blank"
    });
  $(github_icon).removeAttr("data-toggle");
});
