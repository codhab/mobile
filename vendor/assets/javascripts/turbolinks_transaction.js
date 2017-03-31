$(document).on('turbolinks:request-start', function() {
  Turbolinks.clearCache();
})

$(document).on('turbolinks:render', function() {
  Turbolinks.clearCache();
})