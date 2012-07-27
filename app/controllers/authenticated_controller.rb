class AuthenticatedController < ApplicationController
  before_filter :authenticate_user
  before_filter :clouds

  private

  def authenticate_user
    unless current_user
      redirect_to login_path
    end
  end


  def clouds
    @tags = Item.tag_counts_on(:tags)
    @brands = Item.tag_counts_on(:brands)
    @types = Item.tag_counts_on(:types)
    @doctypes = Document.tag_counts_on(:doctypes)
  end
end