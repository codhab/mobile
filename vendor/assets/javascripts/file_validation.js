function validate_file(input) {
  var maxExceededMessage = "Este arquivo é excede o tamanho máximo permitido de 5Mb";
  var extErrorMessage = "Arquivo com formato inválido. Envie somente arquivos do tipo (.jpg, .jpeg, .gif, .bmp, .png ou .pdf)";
  var allowedExtension = ["jpg", "jpeg", "gif", "png", "bmp", "pdf"];

  var extName;
  var maxFileSize = 5000000;
  var sizeExceeded = false;
  var extError = false;

  $.each(input.files, function() {
    console.log(this.size)
    if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) {sizeExceeded=true;};
    extName = this.name.split('.').pop();
    if ($.inArray(extName, allowedExtension) == -1) {extError=true;};
  });

  var html = "<div class='ui red pointing above label error'>"

  if (sizeExceeded || extError) {

    $(input).next('.error').remove()

    if (sizeExceeded) {
      html += "<p>" + maxExceededMessage + "</p>"
    }
 
    if (extError) {
      html += "<p>" + extErrorMessage + "</p>"
    }

    $(input).after(html)
    $(input).closest("div").addClass('error')
    $(input).val('');
  } else {
    $(input).next('.error').remove()
    $(input).closest("div").removeClass('error')
  }

}