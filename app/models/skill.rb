class Skill < ActiveRecord::Base
	validates :name, :proficiency, :presence => true
	validates_inclusion_of :proficiency, :in => 1..100

	def return_float
		self.proficiency.to_d.round(2, :truncate)/100
		# convert data integer to decimal for progress bar
	end
end
