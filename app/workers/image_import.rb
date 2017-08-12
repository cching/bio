class ImageImport
 	include Sidekiq::Worker 
 	sidekiq_options queue: "image_import"

	def perform image_id
		@image = UploadFile.find(image_id)
		#find image from id
		@s3 = Aws::S3::Resource.new
		aws_obj = s3_composite_object(@image.id)
		#set S3 and define the object with the given key

		composite = Tempfile.new('composite.png')
		composite_image("background2", "image_manip").write(composite.path)
		@image.update(:composited => true)
		#write the composite to a temp file, pass in image file names for the background and foreground composite function

		begin
			aws_obj.put(body: composite.read, acl: "public-read")
			#upload composite tempfile to specified s3 object
 			@image.update(:file_name => "composite", :extension => ".png")
 			#update model to trigger load event on html partial
		rescue
			Error.log("Error while uploading image")
			# exceptions due to incorrect keys, aws server issues, or change in pkeys
		ensure
			cleanup
			# remove old job data
		end
		
 	end

 	def composite_image image, watermark
 		img = Magick::Image.read("#{return_url(image)}").first
 		#defines img as background
        mark = Magick::Image.read("#{return_url(watermark)}").first
        #defines mark as foreground
        mark.background_color = "transparent"
        mark = mark.adaptive_resize(0.52)
        #ensure foreground png background is transparent, resize foreground to match CSS sizing on page by 52%
        img = img.dissolve(mark, 1, 1, Magick::SouthWestGravity, 28, 0)
        #return composited image with foreground aligned bottom left, y-offset 28px with no changes in opacity
 	end

 	def return_url image_name
 		Rails.root.join("app", "assets", "images", "#{image_name}.png")
 		#return absolute path of file name
 	end

 	def s3_composite_object image_id
 		@s3.bucket('diglab').object("images/#{image_id}/composite.png")
 		# Defines object key in s3 bucket
 	end

 	def cleanup
 		UploadFile.where("created_at < ?", 1.days.ago).each do |file|
 			s3_composite_object(file.id).delete
 			file.delete
 		end
 		# Find upload files created more than 24 hours ago and delete both db record and s3 image record
 		@image.update(:completed => true)
 		# Update image for callback on job completion
 	end
 end