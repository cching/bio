class PagesController < ApplicationController
  def home
  	@section = Section.all.order(:index)
  	# Used to order the sections on the home page and to load te partials in the correct order
  	@skills = Skill.all.order('proficiency DESC')
  end

  def image_manipulation
  	respond_to :js
  end
end
