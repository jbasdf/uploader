require 'test_helper'

class UploadTest < ActiveSupport::TestCase

  context 'upload instance' do

    should_belong_to :uploadable
    should_belong_to :creator
    
    should_have_attached_file :local
    should_have_attached_file :remote
    should_not_allow_mass_assignment_of :creator_id, :uploadable_id, :uploadable_type
    should_validate_attachment_size :local, :less_than => 10.megabytes

    should 'use id_partitioning' do
      upload = Upload.new
      upload.stubs(:id).returns(12345)
      upload.local = VALID_FILE
      assert_equal "#{RAILS_ROOT}/public/system/locals/000/012/345/original/rails.png", upload.local.path
      assert_equal '/system/locals/000/012/345/original/rails.png', upload.local.url(:original, false)
    end

    should 'transliterate the filename' do
      upload = Upload.new
      file = fixture_file %Q{IT'sUPPERCASE!AND WeIRD.JPG}
      upload.local = file
      assert_equal 'it-suppercase-and-weird.jpg', upload.local.original_filename
      file.close
    end
 
  end

  # Named scopes
  should_have_named_scope :newest_first
  should_have_named_scope :alphabetic
  should_have_named_scope :recent
  should_have_named_scope :public
  should_have_named_scope :images
  should_have_named_scope :documents
  should_have_named_scope :files
  should_have_named_scope :since
  should_have_named_scope :pending_s3_migration
  
  private
    def fixture_file(name)
      File.new(File.join(RAILS_ROOT, 'test', 'fixtures', 'files', name), 'rb')
    end
end
