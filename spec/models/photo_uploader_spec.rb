require 'rails_helper'
require 'carrierwave/test/matchers'

RSpec.describe PhotoUploader, type: :model do
  include CarrierWave::Test::Matchers

  let(:photo) { double('Photo', id: 1) }
  let(:uploader) { PhotoUploader.new(photo, :file_path) }

  before do
    PhotoUploader.enable_processing = true
    allow(uploader).to receive(:store_dir) { 'tmp/test/fixtures/' }

    path_to_file = '/Users/seanluckett/work/viking_cs/web_projects/project_danebook/spec/fixtures/make-it-so.png'
    File.open(path_to_file) { |f| uploader.store!(f) }
  end

  after do
    PhotoUploader.enable_processing = false
    uploader.remove!
  end

  describe 'thumb version' do
    it 'scales image to be exactly 200 x 200 pixels' do
      expect(uploader.thumb).to have_dimensions(200, 200)
    end
  end
end