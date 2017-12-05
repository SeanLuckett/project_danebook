class PostDecorator < SimpleDelegator
  def formatted_date
    created_at.strftime '%A, %m/%-d/%Y'
  end

  def likes_info(current_user)
    return unless is_liked?

    called_out_msg = likable_count_msg = ''

    if liked_by_user? current_user
      msg = ' like this.'
      user_msg = 'You'

      if liked_by_others?
        called_out = UserDecorator.new(likes_not_by(current_user).first.user)
        called_out_msg = " and #{called_out.name}"

        if likable_count > 2
          display_count = likable_count - 2
          likable_count_msg = " and #{display_count} #{'other'.pluralize(display_count)}"
        end
      end

    else
      called_out = UserDecorator.new(likes_not_by(current_user).first.user)
      user_msg = called_out.name
      msg = ' likes this.'

      if likable_count > 1
        msg = ' like this.'
        display_count = likable_count - 1
        likable_count_msg = " and #{display_count} #{'other'.pluralize(display_count)}"
      end

    end

    msg.prepend(user_msg, called_out_msg, likable_count_msg)
  end

  private

  def liked_by_others?
    likable_count > 1
  end
end