class CreateTechnicalAssistancePreRegisters < ActiveRecord::Migration[5.0]
  def change
    create_table :technical_assistance_pre_registers do |t|

      t.timestamps
    end
  end
end
