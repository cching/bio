class AddCompBooleanToUploadFile < ActiveRecord::Migration
  def change
  	add_column :upload_files, :composited, :boolean
  end
end
