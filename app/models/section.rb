class Section < ActiveRecord::Base
	validates :name, :index, :presence => true

	def color index
		index.odd? ? "gray" : "white"
	end
end
