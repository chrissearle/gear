class ItemReport < Prawn::Document
  def initialize(user)
    @user = user
    super(top_margin: 70)
    report_title
    items
    details
  end

  def report_title
    text "Photo Gear report for #{@user.name}", size: 30, style: :bold
  end

  def items
    move_down 20
    table item_rows do
        row(0).font_style = :bold
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
      end
  end

  def item_rows
    [["ID", "Name", "Serial", "Purchase Price"]] +
        @user.items.sort_by(&:name).map do |item|
          [item.id, item.name, item.serial, "#{item.currency} #{item.cost}"]
        end
  end

  def details
    @user.items.sort_by(&:name).each do |item|
      start_new_page
      detail_item(item)
    end
  end

  def detail_item(item)
    text "#{item.id}: #{item.name}", size: 25, style: :bold

    move_down 20

    unless item.serial.empty?
      text "Serial \# #{item.serial}"
    end

    move_down 10

    unless item.description.empty?
      text "Description:", style: :bold
      text item.description
    end

    move_down 10
    text "Purchase Price:", style: :bold
    text "#{item.currency} #{item.cost}"

    move_down 10
    text "Brand:", style: :bold
    text item.brand_list.join ", "

    move_down 10
    text "Tags:", style: :bold
    text item.tag_list.join ", "

    move_down 10
    text "Type:", style: :bold
    text item.type_list.join ", "
  end
end