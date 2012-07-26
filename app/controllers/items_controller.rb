class ItemsController < AuthenticatedController
  before_filter :setup_form, :only => [:new, :edit]
  before_filter :find_item, :only => [:show, :edit, :update, :destroy]

  def index
    @items = current_user.items
  end

  def new
    @item = Item.new
    @item.user = current_user
  end

  def create
    @item = Item.new(params[:item])
    @item.user = current_user
    @item.currency = params[:item][:currency]

    if @item.save
      redirect_to items_url, notice: t('item.create.ok')
    else
      render :action => "new"
    end
  end

  def edit
  end

  def show
  end

  def update
    if @item.update_with_currency(params[:item], params[:item][:currency])
      redirect_to items_url, notice: t('item.update.ok')
    else
      render :action => "edit"
    end
  end

  def destroy
    @item.destroy

    redirect_to items_url, notice: t('item.delete.ok')
  end

  # TODO Tag support ownership - https://github.com/mbleigh/acts-as-taggable-on/issues/107

  private

  def setup_form
    @currencies = []
    Money::Currency.table.keys.sort.each do |currency|
      iso_code = Money::Currency.table[currency][:iso_code]
      name = "#{iso_code} - #{Money::Currency.table[currency][:name]}"
      @currencies << [name, iso_code]
    end

    @tags = Item.tag_counts_on(:tags).map(&:name)
    @brands = Item.tag_counts_on(:brands).map(&:name)
    @types = Item.tag_counts_on(:types).map(&:name)
  end

  def find_item
    @item = current_user.items.find(params[:id])
  end
end
