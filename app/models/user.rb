class User < ActiveRecord::Base
  attr_accessible :name, :email

  # TODO acts_as_tagger - https://github.com/mbleigh/acts-as-taggable-on/issues/107

  has_many :authentications
  has_many :items

  def self.get_user(user_id)
    begin
      User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      logger.warn "User #{user_id} requested but not found"
    end
  end

  def get_auth_url(url)
    s = DropboxSession.new(ENV['DROPBOX_APP_KEY'], ENV['DROPBOX_APP_SECRET'])

    self.dropbox_session = s.serialize

    self.save

    return s.get_authorize_url url
  end

  def authorize
    s = DropboxSession.deserialize(self.dropbox_session)

    s.get_access_token

    self.dropbox_session = s.serialize

    self.save
  end

  def get_client
    s = DropboxSession.deserialize(self.dropbox_session)

    DropboxClient.new(s, :app_folder)
  end

end
