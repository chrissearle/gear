class SearchController < AuthenticatedController
  def search
    @items = Item.search(params[:search])

    @items += Item.tagged_with(params[:search], :on => :tags).all
    @items += Item.tagged_with(params[:search], :on => :brands).all
    @items += Item.tagged_with(params[:search], :on => :types).all

    @items.select{|item| item.user == current_user}.sort_by(&:name)
  end
end