require 'rails_helper'

RSpec.describe 'Account Requests', type: :request do
  describe 'POST #create' do
    it 'sends welcome email' do
      expect(SendWelcomeEmail).to receive(:delay_optional)
      post accounts_path,
           params: {
             account:
               attributes_for(:account)
                 .merge(user_attributes: { first_name: '' })
           }
    end
  end
end