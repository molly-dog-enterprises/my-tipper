$(function () {
  $.each($('#picks td'), function() {
    var _this = $(this);

    function setPick() {
      var amount = _this.find('.amount').val();
      if (amount == 0) {
        _this.find('.pick').html('Draw - please select a winning team and margin')
      } else if(amount < 0) {
        _this.find('.pick').html(_this.find('.home').val() + ' by ' + Math.abs(amount))
      } else {
        _this.find('.pick').html(_this.find('.away').val() + ' by ' + amount)
      }
    };
    setPick();

    _this.find(".slider").slider({
      value: _this.find('.amount').val(),
      min: -100,
      max: 100,
      step: 1,
      slide: function (event, ui) {
        _this.find(".amount").val(ui.value);
        _this.find(".pick").html()
        setPick();
      }
    });
  })

});
