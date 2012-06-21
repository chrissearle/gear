class Authentication < ActiveRecord::Base
  belongs_to :user

  delegate :id, :to => :user, :prefix => true

  def self.create_with_omniauth(auth)
    authentication = Authentication.new

    auth_name = get_auth_name(auth)

    authentication.provider = auth["provider"]
    authentication.uid = auth["uid"].to_s
    authentication.name = auth_name
    authentication.email = auth["info"]["email"]
    authentication.build_user(:name => auth_name, :email => authentication.email)

    authentication.save

    authentication
  end


  def self.add_with_omniauth(current_user, auth)
    authentication = Authentication.new

    auth_name = get_auth_name(auth)

    authentication.provider = auth["provider"]
    authentication.uid = auth["uid"].to_s
    authentication.name = auth_name
    authentication.email = auth["info"]["email"]
    authentication.user = current_user

    if (current_user.email.blank? || current_user.name.blank?)
      update_current_user(current_user, auth_name, auth["info"]["email"])
    end

    authentication.save

    authentication
  end

  private

  def self.get_auth_name(auth)
    Rails.logger.debug(auth.to_yaml)
    auth_name = auth["info"]["name"]
    if (auth_name.blank?)
      auth_name = auth["provider"] + ":" + auth["uid"]
    end
    auth_name
  end

  def self.update_current_user(current_user, name, email)
    if (current_user.email.blank? || current_user.email.include?(":"))
      current_user.email = email
    end

    if (current_user.name.blank? || current_user.name.include?(":"))
      current_user.name = name
    end

    current_user.save
  end
end
