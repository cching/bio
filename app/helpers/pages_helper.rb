module PagesHelper
	def downcase_name name
		name.downcase.tr(" ", "_") 
		# function to return easily readable partial names and div ID's
	end

	def checkbox_items
		["Background selected", "Background job initiated via Sidekiq <span class='job_id'></span>", "Image composited via ImageMagick", "Composite uploaded to S3 via AWS SDK", "Job successfully completed <span class='job_id'></span>"]
	end

	def file_checkbox_items
		["Background job initiated via Sidekiq <span class='file_job_id'></span>", "Local file uploaded to Google Drive via Drive REST API", "File permissions set to public write", "Job successfully completed <span class='file_job_id'></span>"]
	end
end
