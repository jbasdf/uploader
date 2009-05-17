class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads, :force => true do |t|
      t.integer  :user_id
      t.string   :name
      t.string   :caption,        :limit => 1000
      t.text     :description
      t.boolean  :is_public,      :default => true
      t.integer  :uploadable_id
      t.string   :uploadable_type
      t.string   :data_file_name
      t.string   :data_content_type
      t.integer  :data_file_size
      t.datetime :data_updated_at
      t.timestamps
    end

    add_index :uploads, ["user_id"]
    add_index :uploads, ["uploadable_id"]
    add_index :uploads, ["uploadable_type"]
    add_index :uploads, ["data_content_type"]

  end

  def self.down
    drop_table :uploads
  end
  
end
