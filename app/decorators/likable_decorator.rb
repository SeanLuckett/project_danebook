class LikableDecorator < SimpleDelegator
  def formatted_date
    created_at.strftime '%A, %m/%-d/%Y'
  end

  # TODO: Extract logic to service object
  def likes_info(current_user)
    return unless is_liked?

    # initialize text fragments
    called_out_text = like_counter_text = other_or_others = ''
    like_or_likes = 'like '
    msg = 'this.'

    # process likes
    likes = likes_not_by current_user
    other_likes_count = likes.size
    called_out_user = likes.first.try(:user)

    # build text fragments
    current_user_text = liked_by_user?(current_user) ? 'You ' : ''
    if current_and_another_user_liked?(called_out_user, current_user_text)
      current_user_text += 'and '
    end

    if called_out_user.present?
      called_out_text = "#{UserDecorator.new(called_out_user).name} "
      other_likes_count -= 1
    end

    if other_likes_count > 0
      like_counter_text = "and #{other_likes_count} "
      other_or_others = 'other'.pluralize(other_likes_count) + ' '
    end

    if change_like_to_likes?(called_out_user, current_user_text, other_likes_count)
      like_or_likes = 'likes '
    end

    msg.prepend(
      current_user_text,
      called_out_text,
      like_counter_text,
      other_or_others,
      like_or_likes
    )
  end

  private

  def current_and_another_user_liked?(called_out_user, current_user_text)
    called_out_user.present? && current_user_text.present?
  end

  def change_like_to_likes?(called_out_user, current_user_text, other_likes_count)
    called_out_user.present? && other_likes_count.zero? &&
      current_user_text.empty?
  end
end