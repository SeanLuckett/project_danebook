require 'rails_helper'

RSpec.describe Comment, type: :model do
  specify { expect(build(:comment_for_post)).to be_valid }

  it 'is invalid without body' do
    comment = build :comment_for_post, body: nil
    comment.valid?
    expect(comment.errors[:body]).to include "can't be blank"
  end
end
