module I18n
  def self.log_missing(*args)
    Rails.logger.debug "i18n #{args.first}"
  end
end

I18n.exception_handler = :log_missing
