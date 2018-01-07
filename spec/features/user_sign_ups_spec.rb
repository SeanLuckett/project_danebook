require 'rails_helper'

RSpec.feature 'UserSignUps', type: :feature do
  context 'with valid data' do
    let(:email) { 'joe.smith@.foobar.com' }
    let(:password) { 'Foo2Barr' }

    before do
      visit root_path
      click_link 'Sign up'

      fill_in 'Your email', with: email
      fill_in 'Your new password', with: password
      fill_in 'Confirm your password', with: password
      click_button 'Sign up!'
    end

    scenario 'user signs up' do
      expect(page).to have_content 'Contact information'
      expect(page).to have_content email
    end

    feature 'Send welcome email' do
      context 'when asynchronous flag is set' do
        before { ActiveJob::Base.queue_adapter = :test }

        scenario 'Enqueues the welcome email' do
          allow(ENV)
            .to receive(:[]).with('ENABLE_DELAYED_EMAILERS').and_return('true')

          user = Account.find_by(email: email).user
          expect { SendWelcomeEmail.delay_optional(user.id) }
            .to have_enqueued_job.on_queue 'mailers'
        end
      end

      context 'when asynchronous flag is NOT set' do
        before { ActiveJob::Base.queue_adapter = :test }

        scenario 'Enqueues the welcome email' do
          allow(ENV)
            .to receive(:[]).with('ENABLE_DELAYED_EMAILERS').and_return('false')

          user = Account.find_by(email: email).user
          expect { SendWelcomeEmail.delay_optional(user.id) }
            .not_to have_enqueued_job.on_queue 'mailers'
        end
      end
    end
  end

  context 'invalid data' do
    before do
      visit new_account_path
      click_button 'Sign up!'
    end

    scenario 'user fails to sign up' do
      expect(current_path).to eq accounts_path
      expect(page).to have_css '#error_explanation'
    end

    scenario 'page shows error count' do
      expect(page).to have_content '4 errors:'
    end
  end
end
