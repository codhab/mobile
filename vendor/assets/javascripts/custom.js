
$(document).on('turbolinks:load', function() {
  $('input').focus(function() {
    if($(this).attr('type') != 'submit') {   
      label_selector = "label[for=" + $(this).attr('id') +"]"
      $(label_selector).hide();
      $(this).addClass('xbig-input')
    }
  })

  $('input').focusout(function() {
    if($(this).attr('type') != 'submit') {   
      label_selector = "label[for=" + $(this).attr('id') +"]"
      $(label_selector).fadeIn();
      $(this).removeClass('xbig-input')
    }
  })

});