class Resume < ActiveRecord::Base
  mount_uploader :resume_file, ResumeUploader
  
  belongs_to :user
  
  def filename
    File.basename(self.resume_file.to_s)
  end
end
