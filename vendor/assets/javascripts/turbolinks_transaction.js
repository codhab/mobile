$(document).on('turbolinks:request-start', function() {
  $('#animate').fadeOut();
  Turbolinks.clearCache();
})

$(document).on('turbolinks:render', function() {
  Turbolinks.clearCache();
  $('#animate').hide();
  $('#animate').fadeIn();
})