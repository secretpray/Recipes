module RecipesHelper

  def image_preview(recipe, small = nil)
    sized = small.nil? ? '200x200!' : '75x75!'
    if recipe.recipe_image.attached?
      image_tag recipe.recipe_image.variant(resize: sized).processed
    else
      image_tag("Default_image.png", size: sized)
    end
  end

  def full_name(user)
    if user&.first_name? && user&.last_name?
      "#{user.first_name.capitalize} #{user.last_name.capitalize}"
    else
     user.username.blank? ? user.email.split('@')[0].capitalize : user.username
    end
  end

  def parse_time(record)
    unless record.nil?
      unless record.strftime("%H:%M").split(':')[0] == '00'
        time_record = record.strftime("%H:%M").split(':')[0] + ' hrs '
      end
      time_record = "#{time_record}".concat(record.strftime("%H:%M").split(':')[1] + ' mins')
    end
  end

  def validate_tag_path(tag)
    return '#' if tag.nil?
    tag.include?('javascript:') || tag.include?('xss!') ? '#' : tag_path(tag)
  end
end
