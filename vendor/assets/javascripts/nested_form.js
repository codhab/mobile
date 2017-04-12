$(document).on('turbolinks:load', function() {


  $('form').on('click', '.remove_fields', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').remove();
    $('.add_fields').removeClass('disabled')


    if($(".inputfile").filter(function () { return $.trim($(this).val()).length == 0 }).length == 0) {
      $('form').find('input:submit').removeClass('disabled')
    } else {
      $('form').find('input:submit').addClass('disabled')
    }

    return event.preventDefault();
  });
  
  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    $(this).addClass('disabled')

    if($(".inputfile").filter(function () { return $.trim($(this).val()).length == 0 }).length == 0) {
      $('form').find('input:submit').removeClass('disabled')
    } else {
      $('form').find('input:submit').addClass('disabled')
    }


    return event.preventDefault();
  });

  

});


