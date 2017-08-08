class Experience < ActiveRecord::Base
	validates :title, :glyphicon, :presence => true
	has_many :duties

	def self.display_order i
		if i.odd?
			Experience.last(i)
		else
			Experience.first(i)
		end
	end
	# return block of 2 or 3 based on position of row
end
