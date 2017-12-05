require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is invalid without a body' do
    post = build :post, body: nil
    post.valid?
    expect(post.errors[:body]).to include "can't be blank"
  end

  describe '#is_liked?' do
    let(:post) { create :post }
    context 'when liked at least once' do
      it 'is true' do
        post.likes.create user_id: post.user.id
        expect(post.reload.is_liked?).to be_truthy
      end
    end

    context 'when unliked' do
      it 'is false' do
        expect(post.is_liked?).to be_falsey
      end
    end
  end
end
