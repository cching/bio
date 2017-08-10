class ImageImport
 	include Sidekiq::Worker 
 	sidekiq_options queue: "image_import"

	def perform image_id
		@image = UploadFile.find(image_id)
		#find image from id
		s3 = Aws::S3::Resource.new
		aws_obj = s3.bucket('diglab').object("images/#{image_id}/composite.png")
		#set S3 and define the object with the given key

		composite = Tempfile.new('composite.png')
		composite_image("background2", "image_manip").write(composite.path)
		#write the composite to a temp file
		 
		aws_obj.put(body: composite.read)
		#upload composite tempfile to specified s3 object
 		@image.update(:file_name => "composite", :extension => ".png")
 		#update model to trigger load event on html partial

 		signer = Aws::S3::Presigner.new
 		url = signer.presigned_url(:get_object, bucket: "diglab", key: "images/#{image_id}/composite.png")
 		#returns signed composite s3 url
 	end

 	def composite_image image, watermark
 		img = Magick::Image.read("#{return_url(image)}").first
 		#defines img as background
        mark = Magick::Image.read("#{return_url(watermark)}").first
        #defines mark as foreground
        mark.background_color = "transparent"
        mark = mark.adaptive_resize(0.52)
        #ensure foreground png background is transparent, resize foreground to match CSS sizing on page
        img = img.dissolve(mark, 1, 1, Magick::SouthWestGravity, 28, 0)
        #return composited image with foreground aligned bottom left, y-offset 28px with no changes in opacity
       	
 	end

 	def return_url image_name
 		Rails.root.join("app", "assets", "images", "#{image_name}.png")
 		#return absolute path of file name
 	end
 end