Number.prototype.toHHMMSS = function () {
  var days = Math.floor(this / (3600 * 24));
  var hours = Math.floor((this - (days * 3600 * 24)) / 3600);
  var minutes = Math.floor((this - (hours * 3600)) / 60);
  var seconds = Math.floor(this - (hours * 3600) - (minutes * 60));

  if (days > 0) {
    return days + ' day(s) ' + hours + ' hour(s)';
  } else if (hours > 0) {
    return hours + ' hour(s) ' + minutes + ' minute(s)';
  } else {
    return minutes + ' minute(s) ' + seconds + ' second(s)';
  }
};

$(function () {
  function updateNextGameInterval() {
    $.each($('.next-game-in'), function () {
      var _this = $(this),
        d = new Date(),
        f = parseInt(_this.data('at')) * 1000;
      if (d.getTime() > f) {
        _this.html('Already started')
      } else {
        _this.html(((f - d.getTime()) / 1000).toHHMMSS())
      }
    })
  }

  setInterval(updateNextGameInterval, 1000);
  updateNextGameInterval();
});
