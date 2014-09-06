class TradeShow
  include Mongoid::Document

  belongs_to :distributor

  field :name, type: String
  field :date, type: Date
  field :country, type: String
  field :years_participated, type: String
  field :website, type: String

end