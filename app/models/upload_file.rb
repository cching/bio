class UploadFile < ActiveRecord::Base
	def public_url
		s3 = Aws::S3::Resource.new
 		aws_obj = s3.bucket('diglab').object("images/#{self.id}/composite.png")
 		aws_obj.public_url
	end

	def human_url
		session = self.init_session
		session.file_by_id(self.file_name).human_url
		# return readable url from google drive file object
	end

	def init_session
		GoogleDrive::Session.from_service_account_key(ENV['GOOGLE_SECRETS'])
		# initiates google drive session from json secret file
	end

end
