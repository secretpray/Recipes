class UserSerializer
  include JSONAPI::Serializer
  include ApplicationHelper
  include Rails.application.routes.url_helpers

  attributes :id, :first_name, :last_name, :email

  attribute :user_avatar_url do |user|
    unless user.avatar.attached?
      user.avatar.attach(io: File.open("#{Rails.root}/app/assets/images/Unknowns_user_avatar.png"), filename: 'Unknowns_user_avatar.png', content_type: 'image/png')
    end
    # always img processed
    user.avatar.variant(resize: "75x75!").processed.url
  end

  attribute :user_url do |object, params|
    # not worked in Heroku console (e.g. "/users/4")
    # params[:context].user_path(object)
    "/users/#{object.id}"
  end

  attribute :username do |user|
    if user.username.length < 36
      user.username
    else
      user.username[0...32] + ' ... '
    end
  end
end
