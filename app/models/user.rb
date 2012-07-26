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
end
