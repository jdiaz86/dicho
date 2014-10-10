class Authorization
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  validates :provider, :uid, :presence => true

  field :provider, type: String
  field :uid, type: String
end
