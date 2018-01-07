require 'rails_helper'

RSpec.describe 'SendWelcomeEmail', type: :model do
  describe '#delay_optional' do
    context 'When enable_delayed_emails: true' do
      before do
        allow(ENV)
          .to receive(:[]).with('ENABLE_DELAYED_EMAILERS').and_return('true')
      end

      it 'it enqueues the email job' do
        user = create :user
        mailer_spy = double('UserMailer')

        allow(UserMailer).to receive(:welcome).with(user) { mailer_spy }
        expect(mailer_spy).to receive(:deliver_later)

        SendWelcomeEmail.delay_optional(user.id)
      end
    end

    context 'When enable_delayed_emails: false' do
      before do
        allow(ENV)
          .to receive(:[]).with('ENABLE_DELAYED_EMAILERS').and_return('false')
      end

      it 'it enqueues the email job' do
        user = create :user
        mailer_spy = double('UserMailer')

        allow(UserMailer).to receive(:welcome).with(user) { mailer_spy }
        expect(mailer_spy).to receive(:deliver_now)

        SendWelcomeEmail.delay_optional(user.id)
      end
    end
  end
end