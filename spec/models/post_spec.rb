require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is invalid without a body' do
    post = build :post, body: nil
    post.valid?
    expect(post.errors[:body]).to include "can't be blank"
  end
end
