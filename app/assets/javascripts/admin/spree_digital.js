var SpreeDigitalSearch = function(route) {
  $('[data-id=dropbox-search]').keyup ( function (e) {
    variant = $(e.target).parent().data('variant')
    term = $(e.target).val()
    if(term.length >= 3)
      {
        $.ajax( {
          url: route+ "?query="+term,
          success: function (text, b, thing) {
            $('[data-variant='+variant+'] [data-id=dropbox-file-list]').html(text);
            BindLs(variant);
          }
        });
      }
  });
}

var SpreeDigital = function(route) {
  $('[data-id=dropbox-select]').click ( function (e) {
    e.preventDefault();
    variant = $(e.target).parent().data('variant')
    $.ajax( {
      url: route,
      success: function (text, b, thing) {
        $('[data-variant='+variant+'] [data-id=dropbox-file-list]').html(text);
        BindLs(variant);
      }
    });
  });
}
var BindLs = function(variant) {
  $('[data-id=dropbox-file-list] li').click( function(event) {
    console.log(variant);
    $('#' + variant + '_file_size').val($(event.target).data('file-size'));
    $('#' + variant + '_content_type').val($(event.target).data('content-type'));
    $('#' + variant + '_file_name').val($(event.target).data('file-name'));
    $('[data-id=dropbox-file-list]').html("");
  });
}
