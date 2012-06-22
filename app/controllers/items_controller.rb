class ItemsController < AuthenticatedController
  def index
    @items = current_user.items
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
