class User < ActiveRecord::Base
  has_many :authentications

  def self.get_user(user_id)
    begin
      User.find(user_id, :include => [:points])
    rescue ActiveRecord::RecordNotFound
      logger.warn "User #{user_id} requested but not found"
    end
  end
end
