class Document < ActiveRecord::Base
  attr_accessible :path

  belongs_to :item

  acts_as_taggable_on :doctypes
end
