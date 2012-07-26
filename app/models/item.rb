class Item < ActiveRecord::Base
  belongs_to :user

  composed_of :cost,
    :class_name => "Money",
    :mapping => [%w(price cents), %w(currency currency_as_string)],
    :constructor => Proc.new { |price, currency| Money.new(price || 0, currency || Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  acts_as_taggable_on :tags, :brands, :types

  attr_accessible :name, :description, :serial, :currency, :cost, :purchased_from, :purchased_on, :tag_list, :brand_list, :type_list

  def update_with_currency(params, currency)
    status = self.update_attributes(params)

    if status
      self.currency = currency
      self.save
    end

    status
  end

  def all_tags
    (self.tags.map(&:name) + self.brands.map(&:name) + self.types.map(&:name)).sort.join(", ")
  end
end
