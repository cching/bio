class AddGlyphiconTypeToExperience < ActiveRecord::Migration
  def change
  	add_column :experiences, :glyphicon, :string
  end
end
