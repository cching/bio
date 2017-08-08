module PagesHelper
	def downcase_name name
		name.downcase.tr(" ", "_") 
		# function to return easily readable partial names and div ID's
	end
end
