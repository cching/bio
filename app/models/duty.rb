class Duty < ActiveRecord::Base
	validates :name, :presence => true
	belongs_to :experiences
end
