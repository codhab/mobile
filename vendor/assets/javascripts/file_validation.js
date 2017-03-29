function validate_file(input) {
  var maxExceededMessage = "Este arquivo é excede o tamanho máximo permitido de (5 MB)";
  var extErrorMessage = "Arquivo com formato inválido. Envie somente arquivos do tipo: (.jpg .jpeg .gif .bmp .png ou .pdf)";
  var allowedExtension = ["jpg", "jpeg", "gif", "png", "bmp", "pdf"];

  var extName;
  var maxFileSize = 5000000;
  var sizeExceeded = false;
  var extError = false;

  $.each(input.files, function() {
    if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) {sizeExceeded=true;};
    extName = this.name.split('.').pop();
    if ($.inArray(extName, allowedExtension) == -1) {extError=true;};
  });

  var message = ""

  if (sizeExceeded || extError) {

    $(input).next('.error').remove()

    if (sizeExceeded) {
      message += "<p>" + maxExceededMessage + "</p>"
    }
 
    if (extError) {
      message += "<p>" + extErrorMessage + "</p>"
    }

    html = "<div class='content'>"+
              "<div class='header text-center'>"+
                "<h3> Atenção!</h3>"+
              "</div>"+
              "<div class='description text-center'>"+
                "<h5><b>" + message + "</b></h4>"+
              "</div>"+
            "</div>"+
            "<div class='actions'>"+
              "<div class='ui aligned center text-center'>"+
                "<div class='ui grau deny button'> Fechar mensagem</div>"+
              "</div>"+
            "</div>"+
            "<div class='divider'></div>"
            
    $('.ui.modal').html(html);
    $('.ui.modal').modal('show');

    if ($(input).data('destroy') == true) {
      $(input).val(null);
      $("#"+ input.id).parents('label').contents('span').text('Toque para inserir um documento')
      $("#"+ input.id).parents('label').removeClass("yellow")
      $(input).closest('fieldset').nextAll(".add_fields").addClass('disabled')

    } else {
      $(input).closest('fieldset').nextAll(".add_fields").removeClass('disabled')
      $(input).closest('fieldset').remove();
    }

    
  } else {
    $("#"+ input.id).parents('label').contents('span').text('Arquivo carregado')
    $("#"+ input.id).parents('label').addClass("yellow").addClass("fluid")
    $(input).closest('fieldset').nextAll(".add_fields").removeClass('disabled')

  }

  if($("fieldset input[type='file']").filter(function () { return $.trim($(this).val()).length == 0 }).length == 0) {
    $('form').find('input:submit').removeClass('disabled')
  } else {
    $('form').find('input:submit').addClass('disabled')
  } 

}

