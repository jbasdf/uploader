require File.dirname(__FILE__) + '/../test_helper'

class UploadTest < ActiveSupport::TestCase

  context "upload" do
        
    context 'upload instance' do

      should belong_to :uploadable
      should belong_to :creator
    
      should_have_attached_file :local
      should_have_attached_file :remote
      should_not allow_mass_assignment_of :creator_id
      should_not allow_mass_assignment_of :uploadable_id
      should_not allow_mass_assignment_of :uploadable_type
      should_validate_attachment_size :local, :less_than => 10.megabytes

      should 'use id_partitioning' do
        upload = Upload.new
        upload.stubs(:id).returns(12345)
        upload.local = VALID_FILE
        assert upload.local.path.include?("/public/system/locals/000/012/345/original/rails.png")
        assert_equal '/system/locals/000/012/345/original/rails.png', upload.local.url(:original, false)
      end

      should 'transliterate the filename' do
        upload = Upload.new
        file = fixture_file %Q{IT'sUPPERCASE!AND WeIRD.JPG}
        upload.local = file
        assert_equal 'itsuppercase-and-weird.jpg', upload.local.original_filename
        file.close
      end
 
      should 'set the filename using the hard file name' do
        name = 'foo.jpg'
        upload = Upload.new(:hard_file_name => name)
        file = fixture_file %Q{IT'sUPPERCASE!AND WeIRD.JPG}
        upload.local = file
        assert_equal name, upload.local.original_filename
        file.close
      end
      
    end

    context "Named scopes" do
      context "'newest' named scope" do
        setup do
          Upload.delete_all
          @first = Factory(:upload, :created_at => 1.day.ago)
          @second = Factory(:upload, :created_at => 1.week.ago)
        end
        should "sort by created_at" do
          assert_equal @first, Upload.newest[0]
          assert_equal @second, Upload.newest[1]
        end
      end
      context "'recent' named scope" do
        setup do
          Upload.delete_all
          @recent = Factory(:upload)
          @not_recent = Factory(:upload, :created_at => 10.weeks.ago)
        end
        should "get recent" do
          assert Upload.recent.include?(@recent), "since didn't include recent upload"
        end
        should "not get recent" do
          assert !Upload.recent.include?(@not_recent), "since did include recent upload"
        end
      end
      context "'by_filename' named scope" do
        setup do
          Upload.delete_all
          @first = Factory(:upload, :local_file_name => 'a')
          @second = Factory(:upload, :local_file_name => 'b')
        end
        should "sort by name" do
          assert_equal @first, Upload.by_filename[0]
          assert_equal @second, Upload.by_filename[1]
        end
      end
      context "'is_public' named scope" do
        setup do
          Upload.delete_all
          @first = Factory(:upload, :is_public => true)
          @second = Factory(:upload, :is_public => false)
        end
        should "find public files" do
          assert Upload.is_public.include?(@first)
          assert !Upload.is_public.include?(@second)
        end
      end
      context "'pending_s3_migrations' named scope" do
        setup do
          Upload.delete_all
          @first = Factory(:upload)
          @second = Factory(:upload, :remote_file_name => 'test.png')
        end
        should "find pending_s3_migrations entries" do
          assert Upload.pending_s3_migrations.include?(@first)
          assert !Upload.pending_s3_migrations.include?(@second)
        end
      end
      context "'images' named scope" do
        setup do
          Upload.delete_all
          @first = Factory(:upload) # default is png
          @second = Factory(:upload, :local => fixture_file_upload('test.doc', 'application/msword'))
        end
        should "find images" do
          assert Upload.images.include?(@first)
          assert !Upload.images.include?(@second)
        end
      end
      context "'documents' named scope" do
        setup do
          Upload.delete_all
          @first = Factory(:upload, :local => fixture_file_upload('test.doc', 'application/msword'))
          @second = Factory(:upload)
        end
        should "find documents" do
          assert Upload.documents.include?(@first)
          assert !Upload.documents.include?(@second)
        end
      end
      context "'files' named scope" do
        setup do
          Upload.delete_all
          @first = Factory(:upload, :local => fixture_file_upload('test.pdf', 'application/pdf'))
          @second = Factory(:upload)
        end
        should "find files (not images)" do
          assert Upload.files.include?(@first)
          assert !Upload.files.include?(@second)
        end
      end
      context "'created_by' named scope" do
        setup do
          Upload.delete_all
          @creator_id = 28
          @first = Factory(:upload, :creator_id => @creator_id)
          @second = Factory(:upload)
        end
        should "find by creator" do
          assert Upload.created_by(@creator_id).include?(@first)
          assert !Upload.created_by(@creator_id).include?(@second)
        end
      end
    end

  end
  
  private
    def fixture_file(name)
      File.new(File.join(::Rails.root.to_s, 'test', 'fixtures', 'files', name), 'rb')
    end
end
