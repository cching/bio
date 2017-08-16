class PagesController < ApplicationController
  def home
  	@section = Section.all.order(:index)
  	# Used to order the sections on the home page and to load te partials in the correct order
  	@skills = Skill.all.order('proficiency DESC')
    # Order skills in descending order for skills section
  end

  # Controller actions for image manipulation section
  def image_manipulation
  	respond_to :js
  end

  def process_image
    @image = UploadFile.create 
    @job_id = ImageImport.perform_async(@image.id)
    # Queue image for background job
  	respond_to :js
  end

  def update_state
    @image = UploadFile.find(params[:id].to_i)
    # Update the state of the image after being queued for the background job to update display checkboxes
    respond_to :js
  end

  # controller actions for file management section
  def process_file
    @file = UploadFile.create
    @job_id = FileImport.perform_async(@file.id)
    # queue file for background job
    respond_to :js
  end

  def file_update_state
    @file = UploadFile.find(params[:id].to_i)
    # Update the state of the image after being queued for the background job to update display checkboxes
    respond_to :js
  end
end
