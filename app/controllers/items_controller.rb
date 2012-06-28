class ItemsController < AuthenticatedController
  before_filter :setup_form, :only => [:new, :edit]
  before_filter :find_item, :only => [:edit, :update, :destroy]

  def index
    @items = current_user.items
  end

  def new
    @item = Item.new
    @item.user = current_user
  end

  def create
    # See http://stackoverflow.com/questions/7988882/setting-currency-with-form-select-with-money-gem for getting the correct currency
  end

  def edit
  end

  def update

  end

  def destroy
  end

  # TODO Tag support (acts as taggable with type completion on the fields)

  private

  def setup_form
    @currencies = []
    Money::Currency.table.keys.sort.each do |currency|
      iso_code = Money::Currency.table[currency][:iso_code]
      name = "#{iso_code} - #{Money::Currency.table[currency][:name]}"
      @currencies << [name, iso_code]
    end
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
