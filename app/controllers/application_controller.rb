class ApplicationController < ActionController::Base
  helper_method :favorite_text

  def favorite_text
    return @favorite_exists ? "&#x2661;".html_safe : "&#x2764;&#xfe0f;".html_safe
  end
end
