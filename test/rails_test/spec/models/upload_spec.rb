require File.dirname(__FILE__) + '/../spec_helper'

describe Upload do

  it { should belong_to :uploadable }
  it { should belong_to :creator }

  it { should have_attached_file :local }
  it { should have_attached_file :remote }
  it { should_not allow_mass_assignment_of :creator_id }
  it { should_not allow_mass_assignment_of :uploadable_id }
  it { should_not allow_mass_assignment_of :uploadable_type }
  it { should validate_attachment_size(:local).less_than(10.megabytes) }

  it 'should use id_partitioning' do
    upload = Upload.new
    upload.stub(:id).and_return(12345)
    upload.local = VALID_FILE
    upload.local.path.should include("/public/system/locals/000/012/345/original/rails.png")
    assert_equal '/system/locals/000/012/345/original/rails.png', upload.local.url(:original, false)
  end

  it 'should transliterate the filename' do
    upload = Upload.new
    file = fixture_file %Q{IT'sUPPERCASE!AND WeIRD.JPG}
    upload.local = file
    assert_equal 'itsuppercase-and-weird.jpg', upload.local.original_filename
    file.close
  end

  it 'should set the filename using the hard file name' do
    name = 'foo.jpg'
    upload = Upload.new(:hard_file_name => name)
    file = fixture_file %Q{IT'sUPPERCASE!AND WeIRD.JPG}
    upload.local = file
    assert_equal name, upload.local.original_filename
    file.close
  end

  describe "Named scopes" do
    describe "'newest' named scope" do
      before do
        Upload.delete_all
        @first = Factory(:upload, :created_at => 1.day.ago)
        @second = Factory(:upload, :created_at => 1.week.ago)
      end
      it "should sort by created_at" do
        assert_equal @first, Upload.newest[0]
        assert_equal @second, Upload.newest[1]
      end
    end
    describe "'recent' named scope" do
      before do
        Upload.delete_all
        @recent = Factory(:upload)
        @not_recent = Factory(:upload, :created_at => 10.weeks.ago)
      end
      it "should get recent" do
        Upload.recent.should include(@recent), "since didn't include recent upload"
      end
      it "should not get recent" do
        Upload.recent.should_not include(@not_recent), "since did include recent upload"
      end
    end
    describe "'by_filename' named scope" do
      before do
        Upload.delete_all
        @first = Factory(:upload, :local_file_name => 'a')
        @second = Factory(:upload, :local_file_name => 'b')
      end
      it "should sort by name" do
        Upload.by_filename[0].should == @first
        Upload.by_filename[1].should == @second
      end
    end
    describe "'is_public' named scope" do
      before do
        Upload.delete_all
        @first = Factory(:upload, :is_public => true)
        @second = Factory(:upload, :is_public => false)
      end
      it "should find public files" do
        Upload.is_public.should include(@first)
        Upload.is_public.should_not include(@second)
      end
    end
    describe "'pending_s3_migrations' named scope" do
      before do
        Upload.delete_all
        @first = Factory(:upload)
        @second = Factory(:upload, :remote_file_name => 'test.png')
      end
      it "should find pending_s3_migrations entries" do
        Upload.pending_s3_migrations.should include(@first)
        Upload.pending_s3_migrations.should_not include(@second)
      end
    end
    describe "'images' named scope" do
      before do
        Upload.delete_all
        @first = Factory(:upload) # default is png
        @second = Factory(:upload, :local => fixture_file_upload("#{FIXTURES_PATH}test.doc", 'application/msword'))
      end
      it "should find images" do
        Upload.images.should include(@first)
        Upload.images.should_not include(@second)
      end
    end
    describe "'documents' named scope" do
      before do
        Upload.delete_all
        @first = Factory(:upload, :local => fixture_file_upload("#{FIXTURES_PATH}test.doc", 'application/msword'))
        @second = Factory(:upload)
      end
      it "should find documents" do
        Upload.documents.should include(@first)
        Upload.documents.should_not include(@second)
      end
    end
    describe "'files' named scope" do
      before do
        Upload.delete_all
        @first = Factory(:upload, :local => fixture_file_upload("#{FIXTURES_PATH}test.pdf", 'application/pdf'))
        @second = Factory(:upload)
      end
      it "should find files (not images)" do
        Upload.files.should include(@first)
        Upload.files.should_not include(@second)
      end
    end
    describe "'created_by' named scope" do
      before do
        Upload.delete_all
        @creator_id = 28
        @first = Factory(:upload, :creator_id => @creator_id)
        @second = Factory(:upload)
      end
      it "should find by creator" do
        Upload.created_by(@creator_id).should include(@first)
        Upload.created_by(@creator_id).should_not include(@second)
      end
    end
  end

  def fixture_file(name)
    File.new(File.join(::Rails.root.to_s, 'spec', 'fixtures', 'files', name), 'rb')
  end
  
end