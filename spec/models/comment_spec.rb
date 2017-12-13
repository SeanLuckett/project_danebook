require 'rails_helper'

RSpec.describe Comment, type: :model do
  specify { expect(build(:comment)).to be_valid }

  it 'is invalid without body' do
    comment = build :comment, body: nil
    comment.valid?
    expect(comment.errors[:body]).to include "can't be blank"
  end
end
