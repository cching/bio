class AddCompletedToUploadFile < ActiveRecord::Migration
  def change
  	add_column :upload_files, :completed, :boolean
  end
end
