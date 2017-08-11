class UploadFile < ActiveRecord::Base
	def public_url
		s3 = Aws::S3::Resource.new
 		aws_obj = s3.bucket('diglab').object("images/#{self.id}/composite.png")
 		aws_obj.public_url
	end
end
