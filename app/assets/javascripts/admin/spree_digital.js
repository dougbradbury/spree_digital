var SpreeDigital = function(route) {
  $('[data-id=dropbox-select]').click ( function (e) {
    e.preventDefault();
    variant = $(e.target).data('variant')
    $.ajax( {
      url: route,
      success: function (text, b, thing) {
        $('#dropbox-file-list').html(text);
        BindLs(variant);
      }
    });
  });
}
var BindLs = function(variant) {
  $('#dropbox-file-list li').click( function(event) {
    $('#' + variant + '_file_size').val($(event.target).data('file-size'));
    $('#' + variant + '_content_type').val($(event.target).data('content-type'));
    $('#' + variant + '_file_name').val($(event.target).data('file-name'));
    $('#dropbox-file-list').html("");
  });
}
