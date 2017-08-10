class CreateUploadFiles < ActiveRecord::Migration
  def change
    create_table :upload_files do |t|
      t.string :file_name
      t.string :extension

      t.timestamps null: false
    end
  end
end
