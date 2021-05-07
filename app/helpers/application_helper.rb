module ApplicationHelper
  
  def is_active(controller, action)       
    params[:action] == action && params[:controller] == controller ? "active" : nil        
  end

  def link_form(object)
    object.persisted? ? 'Update' : 'Create'
  end

  def background_select       
    if cookies[:theme] == 'light'
      'navbar-light bg-light'
    else
      'navbar-light bg-warning'
    end
  end
end

