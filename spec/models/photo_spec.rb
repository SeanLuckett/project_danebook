require 'rails_helper'

RSpec.describe Photo, type: :model do
  it 'is invalid without a file_path' do
    photo = build :photo, file_path: nil
    photo.valid?
    expect(photo.errors[:file_path]).to include "can't be blank"
  end
end
