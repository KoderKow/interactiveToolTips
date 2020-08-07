$( document ).ready(function() {
  let github = "body > nav > div > ul > li:nth-child(4) > a";
  $(github).attr({
    href: "https://github.com/KoderKow/interactiveToolTips",
    target: "_blank"
    });
  $(github).removeAttr("data-toggle");
  
  // Website
  let website = "body > nav > div > ul > li:nth-child(5) > a";
  $(website).attr({
    href: "https://koderkow.rbind.io/",
    target: "_blank"
    });
  $(website).removeAttr("data-toggle");
});
