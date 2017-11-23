require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe '#name' do
    it 'returns first and last name' do
      user = build :user
      profile = user.build_profile first_name: 'Joe', last_name: 'Seephus'
      expect(profile.name).to eq 'Joe Seephus'
    end
  end
end
