module UserOath
  extend ActiveSupport::Concern

  def create_authorization(auth)
    # binding.pry
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end

  def full_name(auth)
    if auth.provider == 'facebook' && !auth.info.name.empty?
      self.first_name = auth.info.name.split(' ')[0] 
      self.last_name = auth.info.name.split(' ')[1] 
    elsif auth.provider == 'google_oauth2'
      self.first_name = auth.info.first_name unless auth.info.first_name.empty?
      self.last_name = auth.info.last_name unless auth.info.last_name.empty?
    end
    self.save
  end    
  
  class_methods do
    def find_for_oauth(auth)
      authorizations = Authorization.where(provider: auth.provider, uid: auth.uid).first
      return authorizations.user if authorizations

      email = auth.info[:email]
      user = User.where(email: email).first

      email ||= create_email(auth) if email.nil?

      if user 
        user.create_authorization(auth)
      else
        uniq_username = "#{email.split('@')[0]}[#{auth.provider}-#{auth[:uid]}]"
        password = Devise.friendly_token[0, 20]
        user = User.create!(email: email, username: uniq_username, password: password, password_confirmation: password)
        user.full_name(auth)

        user.create_authorization(auth)
      end
      return user
    end

    def create_email(auth)
      "#{auth[:uid]}@#{auth.provider}.com"
    end
  end
end