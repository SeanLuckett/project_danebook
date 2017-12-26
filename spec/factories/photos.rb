FactoryBot.define do
  factory :photo do
    user
    file_path {
      Rack::Test::UploadedFile.new(
        File.open(
          Rails.root.join('spec', 'fixtures', 'make-it-so.png')
        ), 'image/png'
      )
    }
  end
end
