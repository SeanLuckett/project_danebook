require 'rails_helper'

RSpec.describe LikedResource, type: :model do
  describe 'attributes and associated user' do
    context 'when resource is a post' do
      let(:post) { create :post }
      let(:params) { { likable: 'Post', post_id: post.id } }
      let(:liked_resource) { LikedResource.new(params) }

      specify { expect(liked_resource.user).to eq post.user }
      specify { expect(liked_resource.type).to eq 'Post' }
      specify { expect(liked_resource.record).to eq post }
    end

    context 'when resource is a comment' do
      let(:comment) { create :comment }
      let(:params) { { likable: 'Comment', comment_id: comment.id } }
      let(:liked_resource) { LikedResource.new(params) }

      specify { expect(liked_resource.user).to eq comment.post.user }
      specify { expect(liked_resource.type).to eq 'Comment' }
      specify { expect(liked_resource.record).to eq comment }
    end
  end
end
