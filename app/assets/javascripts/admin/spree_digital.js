var SpreeDigital = function(route) {
  $('[data-id=dropbox-select]').click ( function (e) {
    e.preventDefault();
    $.ajax( {
      url: route,
      success: function (text, b, thing) {
        $('#dropbox-file-list').html(text);
        BindLs();
      }
    });
  });
}
var BindLs = function() {
  $('#dropbox-file-list li').click( function(event) {
    $('#digital_attachment_file_size').val($(event.target).data('file-size'));
    $('#digital_attachment_content_type').val($(event.target).data('content-type'));
    $('#digital_attachment_file_name').val($(event.target).data('file-name'));
    $('html, body').animate({
              scrollTop: $("#digital_attachment_file_name").offset().top
                  }, 200);
  });
}
