class User < ActiveRecord::Base
  attr_accessible :name, :email

  has_many :authentications

  def self.get_user(user_id)
    begin
      User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      logger.warn "User #{user_id} requested but not found"
    end
  end
end
