require 'rails_helper'

RSpec.describe UserDecorator, type: :model do
  describe '#formatted_birthdate' do
    context 'with birthdate' do
      it 'formats the date for viewing' do
        user = build :user, birthdate: DateTime.new(1971, 6, 16)
        decorated_user = UserDecorator.new(user)
        expect(decorated_user.formatted_birthdate).to eq 'June 16, 1971'
      end
    end

    context 'without birthdate (nil)' do
      it 'returns empty string' do
        decorated_user = UserDecorator.new(build(:user))
        expect(decorated_user.formatted_birthdate).to eq ''
      end
    end
  end
end
