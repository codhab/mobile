module Person
  class DataReferenceUpload < ActiveRecord::Base
    self.table_name = 'extranet.schedule_data_reference_uploads'

    mount_uploader :document, Core::Attendance::DocumentUploader

  end
end