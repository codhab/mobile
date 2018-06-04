require_dependency 'entity/application_controller'

module Entity
  class InterestsController < ApplicationController
    before_action :set_address, only: [:new, :create, :send_mail]

    def index
      @enterprise = Core::Entity::Enterprise.where(entity_id: current_entity.id)
      #@enterprise = (!current_entity.enterprises.present? && !@enterprise.present?)

      @entities = ['05780347000118',
      '05982489000168',
      '18079352000140',
      '06179614000169',
      '04116769000120',
      '06178744000187',
      '02603768000185',
      '07754155000162',
      '03850205000154',
      '07467933000132',
      '08094562000153',
      '02077074000151',
      '02573517000103',
      '03876665000151',
      '07382122000139',
      '07275715000104',
      '12362388000150',
      '10569203000157',
      '04114317000100',
      '03891370000154',
      '02575884000138',
      '02389599000122',
      '07176958000187',
      '01716752000116',
      '04797706000187',
      '06097385000133',
      '04646213000146',
      '06215509000138',
      '03400436000166',
      '06250855000157',
      '07276690000155',
      '01379405000145',
      '02577542000157',
      '09008204000143',
      '01635507000184',
      '08094572000199',
      '01332136000161',
      '06299516000165',
      '23053324000193',
      '02616651000136',
      '05432490000119',
      '20968679000114',
      '06207580000179',
      '02578961000103',
      '02196049000197',
      '07075679000127',
      '03412091000160',
      '02949994000112',
      '13721271000188',
      '04116266000155',
      '02519512000194',
      '08069029000131',
      '04109147000175',
      '04113405000197',
      '04114349000105',
      '20137905000115',
      '07176976000169',
      '04922595000193',
      '07387857000236',
      '15486497000177',
      '07263425000132',
      '04043530000178',
      '07711754000107',
      '03755707000104',
      '04899517000115',
      '01632533000159',
      '02380595000183',
      '01717958000160',
      '03229380000129',
      '07033440000194',
      '07845155000178',
      '06149917000139',
      '05795982000179',
      '07331875000115',
      '38005534000183',
      '06062729000179',
      '05539331000118',
      '02011578000179',
      '07862762000146']

      @enterprise = !@entities.include?(current_entity.cnpj)
    end

    def new
      @interest = Core::Entity::InterestForm.where(entity_id: current_entity.id, allotment_id: 6).new

    end

    def create
      @interest = Core::Entity::InterestForm.where(entity_id: current_entity.id, allotment_id: 6).new(set_params)

      if @interest.save

        Entity::RecoveryMailer.simple(@interest.entity.email).deliver_now rescue nil

        redirect_to entity_interest_path(@interest)
      else
        flash[:error] = t :error
        render action: :new
      end

    end

    def show
      @interest = current_entity.interests.find(params[:id])
    end

    def send_mail
      @interest = current_entity.interests.find(params[:entity_interest_id])

      begin

        Entity::RecoveryMailer.simple(@interest, @interest.entity.email).deliver_now

        flash[:success] = t :success

      rescue Exception => e
        puts e
      end

      redirect_to entity_interest_path(@interest)
    end

    private

    def set_params
      params.fetch(:entity_interest_form, {}).permit(unit_sale_ids: [])
    end


    def set_address
      @addresses = Core::Entity::UnitSale.where(status: true)
    end

  end
end
