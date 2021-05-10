module ApplicationHelper
  
  # Navigation menu activa
  def is_active(controller, action)       
    params[:action] == action && params[:controller] == controller ? "active" : nil        
  end

  # Form helper
  def link_form(object)
    object.persisted? ? 'Update' : 'Create'
  end

  # Theme select
  def background_select       
    if cookies[:theme] == 'light'
      'navbar-light bg-light'
    else
      'navbar-light bg-warning'
    end
  end

  #  Breadcrumbs
  def build_breadcrumbs(category)
    result = []
    category.ancestors.each do |ancestor|
      result << content_tag(:li, class: 'breadcrumb-item') do
        link_to(ancestor.name, ancestor, class: 'text-decoration-none')
      end
    end
    result << content_tag(:li, category.name, class: 'breadcrumb-item active ')
    result.join('').html_safe
  end

  # Create cloud tag: tag_cloud(tagssorted, ["tag1", "tag2", "tag3", "tag4", "tag5"])
  def tag_cloud(tags, classes)
    # max = tags.sort_by(&:count).last
    tags.each do |tag|
    #  index = tag.count.to_f / max.count * (classes.size - 1)
     index = tag.recipes.count.to_f / tags.last.recipes.count * (classes.size - 1)
     yield(tag, classes[index.round])
    end
  end
  
  # Helpers for User avatar
  def user_avatar(user, size=40)
    if user.avatar.attached?
      user.avatar.variant(resize: "#{size}x#{size}!")
    else
      gravatar_image_url(user&.email, size: size)
    end
  end
end

