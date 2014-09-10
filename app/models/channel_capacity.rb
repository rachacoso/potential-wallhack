class ChannelCapacity
  include Mongoid::Document

  belongs_to :brand
  belongs_to :distributor

  field :channel_id, type: String
  field :capacity, type: Integer

  validates :channel_id, presence: true

end
