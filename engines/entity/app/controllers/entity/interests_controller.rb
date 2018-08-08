require_dependency 'entity/application_controller'

module Entity
  class InterestsController < ApplicationController
    before_action :set_address, only: [:new, :create, :send_mail]

    def index
      # @enterprise = Core::Entity::Enterprise.where(entity_id: current_entity.id)
      # @enterprise = (!current_entity.enterprises.present? && !@enterprise.present?)

      @entities = [
        '01332136000161',
        '01379405000145',
        '01632533000159',
        '01635507000184',
        '01642907000117',
        '01659656000183',
        '01716752000116',
        '01717958000160',
        '01798129000150',
        '01857055000185',
        '02011578000179',
        '02077074000151',
        '02196049000197',
        '02373016000175',
        '02380595000183',
        '02389599000122',
        '02447318000140',
        '02519512000194',
        '02529645000141',
        '02561231000108',
        '02573517000103',
        '02575884000138',
        '02577542000157',
        '02578961000103',
        '02603768000185',
        '02611186000140',
        '02611319000189',
        '02616651000136',
        '02677938000176',
        '02949994000112',
        '03112019000118',
        '03206519000119',
        '03229380000129',
        '03269295000275',
        '03400436000166',
        '03412091000160',
        '03440960000160',
        '03755707000104',
        '03803703000146',
        '03850205000154',
        '03876665000151',
        '03891370000154',
        '03892958000122',
        '03963848000104',
        '03966052000105',
        '04043530000178',
        '04066616000116',
        '04102169000103',
        '04102352000109',
        '04109147000175',
        '04110689000168',
        '04112305000146',
        '04113405000197',
        '04114317000100',
        '04114349000105',
        '04116266000155',
        '04116769000120',
        '04119131000143',
        '04646213000146',
        '04797706000187',
        '04896782000140',
        '04899517000115',
        '04922595000193',
        '05432490000119',
        '05539331000118',
        '05597081000172',
        '05780347000118',
        '05795982000179',
        '05982489000168',
        '06062729000179',
        '06072958000174',
        '06097385000133',
        '06104606000153',
        '06149917000139',
        '06178744000187',
        '06179614000169',
        '06207580000179',
        '06209509000125',
        '06215509000138',
        '06250855000157',
        '06264705000100',
        '06285220000195',
        '06286350000142',
        '06299516000165',
        '06787464000176',
        '07033440000194',
        '07075679000127',
        '07176958000187',
        '07176976000169',
        '07259511000171',
        '07263328000140',
        '07263425000132',
        '07275715000104',
        '07276690000155',
        '07276761000110',
        '07286182000158',
        '07298335000187',
        '07331875000115',
        '07361220000190',
        '07382122000139',
        '07387857000236',
        '07395187000119',
        '07467933000132',
        '07601535000167',
        '07711754000107',
        '07754155000162',
        '07845153000189',
        '07845155000178',
        '07862762000146',
        '08069029000131',
        '08094562000153',
        '08094572000199',
        '08161639000160',
        '08962407000101',
        '08998297000138',
        '09008204000143',
        '09399200000133',
        '10569203000157',
        '10651516000150',
        '11303650000122',
        '12362388000150',
        '13721271000188',
        '15486497000177',
        '18079352000140',
        '20049917000198',
        '20137905000115',
        '20968679000114',
        '23053324000193',
        '38005534000183'
      ]


      @enterprise = !@entities.include?(current_entity.cnpj)
    end

    def new
      @interest = Core::Entity::InterestForm.where(entity_id: current_entity.id, allotment_id: 8).new

    end

    def create
      @interest = Core::Entity::InterestForm.where(entity_id: current_entity.id, allotment_id: 8).new(set_params)

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
