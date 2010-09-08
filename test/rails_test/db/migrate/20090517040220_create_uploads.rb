class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads, :force => true do |t|
      t.integer  :creator_id
      t.string   :name
      t.string   :caption,        :limit => 1000
      t.text     :description
      t.boolean  :is_public,      :default => true
      t.integer  :uploadable_id
      t.string   :uploadable_type
      t.string   :width   
      t.string   :height
      
      t.string   :local_file_name
      t.string   :local_content_type
      t.integer  :local_file_size
      t.datetime :local_updated_at
      
      t.string   :remote_file_name
      t.string   :remote_content_type
      t.integer  :remote_file_size
      t.datetime :remote_updated_at
            
      t.timestamps
    end

    add_index :uploads, ["creator_id"]
    add_index :uploads, ["uploadable_id"]
    add_index :uploads, ["uploadable_type"]
    add_index :uploads, ["local_content_type"]

  end

  def self.down
    drop_table :uploads
  end
  
end
