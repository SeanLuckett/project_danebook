require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome' do
    let(:user) { create :user, first_name: 'Sean' }
    let(:mail) { UserMailer.welcome(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to Danebook')
      expect(mail.to).to eq([user.account.email])
      expect(mail.from).to eq(['danebook@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("Hi, #{user.first_name}.")
      expect(mail.body.encoded).to match('Thanks for signing up with Danebook')
    end
  end

end
