$(document).ready(() => {
  const keys = ["1", "2", "3", "4", "5"];
  var selectKey;
  var selectValue;
  var percent = 0;

  document.onkeydown = function (data) {
    if (data["key"] === selectKey) {
      const width = $(".progress").width();
      if (width >= selectValue - 15 && width <= selectValue + 32 - 15) {
        sendTask(true);
      } else {
        sendTask(false);
      }
    } else {
      sendTask(false);
    }
  };

  function sendTask(state) {
    $("body").css("display", "none");
    $.post("http://taskbar/taskEnd", JSON.stringify(state));
    $(".progress").animate({ width: "0px" }, { duration: 0 });
    $(".progress").stop();
    $(".progress").css("width", "0px");
  }

  window.addEventListener("message", function (event) {
    var item = event["data"];

    if (item["runProgress"] === true) {
      percent = 0;
      $(".legends").html(
        `${[...Array(item["quantity"]).keys()].map(
          (_, key) => `<legend class="${key}"></legend>`
        )}`
      );

      [...Array(item["taskFinished"]).keys()].map((_, key) =>
        $(`.${key}`).addClass("checked")
      );

      selectKey = keys[Math.floor(Math.random() * 4)];
      selectValue = Math.floor(Math.random() * 240) + 50;
      $(".progress-button").html(selectKey);
      $(".progress-button").css("left", selectValue + "px");
      $(".progress").animate({ width: "100%" }, item["Length"]);
      $("body").css("display", "flex");
    }

    if (item["runUpdate"] === true) {
      percent = item["Length"];
    }

    if (item["closeProgress"] === true) {
      $("body").css("display", "none");
    }
  });
});
