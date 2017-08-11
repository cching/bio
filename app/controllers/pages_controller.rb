class PagesController < ApplicationController
  def home
  	@section = Section.all.order(:index)
  	# Used to order the sections on the home page and to load te partials in the correct order
  	@skills = Skill.all.order('proficiency DESC')
  end

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
end
