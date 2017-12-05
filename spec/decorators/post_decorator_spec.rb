require 'rails_helper'

RSpec.describe PostDecorator, type: :model do
  describe '#likes_info' do
    let(:post) { create :post }
    let(:current_user) { post.user }

    describe 'Current user with liked posts' do
      let(:called_out_user) { UserDecorator.new(create :user, first_name: 'Arnold', last_name: 'Rimmer') }

      before :each do
        post.likes.create user_id: post.user.id
      end

      context 'only current_user likes post' do
        it 'tells current_user they liked it' do
          decorated_post = PostDecorator.new(post.reload)
          expect(decorated_post.likes_info(current_user)).to eq 'You like this.'
        end
      end

      context 'current_user and 1 other like post' do
        it 'shows current_user and the other like it' do
          post.likes.create user_id: called_out_user.id
          decorated_post = PostDecorator.new(post.reload)

          expect(decorated_post.likes_info(current_user))
            .to eq "You and #{called_out_user.name} like this."
        end
      end

      context 'current user and 2 others like post' do
        it 'shows current_user, another by name, and the likes count' do
          post.likes.create user_id: called_out_user.id
          decorated_post = PostDecorator.new(post.reload)

          allow(decorated_post).to receive(:likable_count) { 3 }
          expect(decorated_post.likes_info(current_user))
            .to eq "You and #{called_out_user.name} and 1 other like this."
        end
      end

      context 'current user and 3 others like post' do
        it 'shows current_user, another by name, and the likes count' do
          post.likes.create user_id: called_out_user.id
          decorated_post = PostDecorator.new(post.reload)

          allow(decorated_post).to receive(:likable_count) { 4 }
          expect(decorated_post.likes_info(current_user))
            .to eq "You and #{called_out_user.name} and 2 others like this."
        end
      end
    end

    describe 'Current user without liked posts' do
      let(:other_user) do
        other_user = UserDecorator.new(
          create(:user, first_name: 'Dave', last_name: 'Lister')
        )
      end

      context 'post has 1 like' do
        it 'shows the liker name' do
          post.likes.create user_id: other_user.id

          decorated_post = PostDecorator.new(post.reload)
          expect(decorated_post.likes_info(current_user))
            .to eq "#{other_user.name} likes this."
        end
      end

      context 'post has 2 likes' do
        it 'shows the liker name and 1 other like post' do
          post.likes.create user_id: other_user.id

          decorated_post = PostDecorator.new(post.reload)
          allow(decorated_post).to receive(:likable_count) { 2 }

          expect(decorated_post.likes_info(current_user))
            .to eq "#{other_user.name} and 1 other like this."
        end
      end

      context 'post has 3 likes' do
        it 'shows the liker name and 1 other like post' do
          post.likes.create user_id: other_user.id

          decorated_post = PostDecorator.new(post.reload)
          allow(decorated_post).to receive(:likable_count) { 3 }

          expect(decorated_post.likes_info(current_user))
            .to eq "#{other_user.name} and 2 others like this."
        end
      end
    end
  end
end