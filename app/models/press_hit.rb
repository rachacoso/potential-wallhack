class PressHit
  include Mongoid::Document

  belongs_to :brand

  field :source, type: String
  field :date, type: Date
  field :quotes, type: String
  field :link, type: String

end