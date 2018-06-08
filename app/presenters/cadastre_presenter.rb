class CadastrePresenter < ApplicationPresenter
  
  def hello
    case Time.now.strftime("%H").to_i
    when 18..23
      @string = "Boa noite"
    when 0..6
      @string = "Boa noite"
    when 6..12
      @string = "Bom dia"
    when 12..18
      @string = "Boa tarde"
    end

    "#{@string}, #{self.humanize_first_name}"
  end

  def humanize_first_name
    self.name.split(' ')[0]
  end

  def humanize_complete_name
    formater_name = ""

    self.name.split(' ').each do |char|
      formater_name += "#{char.humanize} " if char.length > 2
    end

    return formater_name
  end

  # current status

  def special_condition_name
    self.special_condition.name rescue nil
  end

  def civil_state_name
    self.civil_state.name rescue nil
  end 

  # => cadastre_situation

  def current_situation
    self.cadastre_situations.order('created_at ASC').last rescue nil
  end

  def current_situation_name
    current_situation.situation_status.name.mb_chars.upcase rescue nil
  end

  def current_situation_id
    current_situation.situation_status_id rescue nil
  end

  # => convocation

  def current_convocation
    self.cadastre_convocations.where(status: true).order('created_at ASC').last rescue nil
  end

  def current_convocation_name
    "#{current_convocation.convocation.id} - #{current_convocation.convocation.description}" rescue nil
  end
  
  def current_convocation_id
    current_convocation.convocation_id rescue nil
  end

end