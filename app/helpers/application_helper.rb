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
end

