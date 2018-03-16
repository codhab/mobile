
$(document).on('turbolinks:load', function() {

  $('.submit').click(function() {
    $(this).addClass('disabled');
    $(this).append("<p class='text-center'><i> Aguarde o envio dos arquivos. Isso pode demorar alguns minutos dependendo da velocidade de sua internet. </i></p>");
  });

  // $('input').focus(function() {
  //   if($(this).attr('type') != 'submit') {
  //     label_selector = "label[for=" + $(this).attr('id') +"]"
  //     $(label_selector).hide();
  //   }
  // })

  $('input').focusout(function() {
    if($(this).attr('type') != 'submit') {
      label_selector = "label[for=" + $(this).attr('id') +"]"
      $(label_selector).fadeIn();
      $(this).removeClass('xbig-input')
    }
  })

  /* Jquery Mask */
  $('.date').mask("00/00/0000", {placeholder: "__/__/____"});
  $('.hour').mask("00:00", {placeholder: "00:00"});
  $('.cpf').mask("000.000.000-00", {placeholder: "000.000.000-00"});
  $('.cnpj').mask("00.000.000/0000-00", {placeholder: "00.000.000/0000-00"});
  $('.document_number').mask("000-000.000/0000", {placeholder: "000-000.000/0000"});
  $('.cep').mask("00000-000", {placeholder: "00000-000"});
  $('.percent').mask("00.0", {placeholder: "00.0"});
  $('.coin').mask("00000.00", {reverse: true});
  $('.money').mask('000.000.000.000,00', {reverse: true});
  $('.phone').blur(function(event) {
    if($(this).val().length == 15){
      //(61)9916-60109
      $(this).mask('(00)0000-0000');
    } else {
      $(this).mask('(00)00000-0000');
    }
  });



});
