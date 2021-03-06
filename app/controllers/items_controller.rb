class ItemsController < AuthenticatedController
  before_filter :setup_form, :only => [:new, :edit]
  before_filter :find_item, :only => [:show, :edit, :update, :destroy]

  def index
    @items = current_user.items.sort_by(&:name)
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

  def tag
    @items = Item.tagged_with(params[:id], :on => :tags).select { |item| item.user == current_user }.sort_by(&:name)
    render :action => "index"
  end

  def brand
    @items = Item.tagged_with(params[:id], :on => :brands).select { |item| item.user == current_user }.sort_by(&:name)
    render :action => "index"
  end

  def type
    @items = Item.tagged_with(params[:id], :on => :types).select { |item| item.user == current_user }.sort_by(&:name)
    render :action => "index"
  end

  # TODO Tag support ownership - https://github.com/mbleigh/acts-as-taggable-on/issues/107

  def report
    pdf = ItemReport.new(current_user)
    send_data pdf.render, filename: "PhotoGear.pdf",
              type: "application/pdf"
  end

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
    @item = current_user.items.find(params[:id])
  end
end
