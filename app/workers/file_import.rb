class FileImport
 	include Sidekiq::Worker 
 	sidekiq_options queue: "file_import"

 	def perform file_id
 		@file = UploadFile.find(file_id)
 		@session = @file.init_session
 		# initiate google drive serive account session
 		
 		begin
 			upload
 		rescue
 			Error.log("Error uploading Google Drive object")
 		ensure
 			cleanup
 		end
 	end

 	def upload
 		@file_object = @session.upload_from_file("#{Rails.root.join("public", "resume.docx")}", "Chris Ching Resume", convert: true)
    	@file.update(file_name: @file_object.id, extension: ".doc")
    	#upload local file to google drive and set resource id to file
 		set_permissions
 	end

 	def set_permissions
 		@file_object.acl.push({type: "anyone", role: "writer", withLink: true})
 		@file.update(composited: true)
 		# set acl so anyone with link can view and edit, flag object 
 	end

 	def cleanup
 		UploadFile.where("created_at < ?", 1.days.ago).each do |file|
	 		if file.extension.try(:include?, "doc")
	 			@session.file_by_id(file.file_name).delete(permanent: true)
	 			file.delete
	 		elsif file.extension.nil?
	 			file.delete
	 			# extension can be nil if client exits prior to execution of the background job and doens't have a cloud object
	 		end
	 	end
	 	@file.update(completed: true)
	 	# only delete google drive objects and database items associated with google drive objects
 	end
 end