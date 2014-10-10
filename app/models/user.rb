class User
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :authorizations
  validates :name, :email, :location, :presence => true

  field :name, type: String
  field :email, type: String
  field :location, type: String
  field :role, type: String
  # fields for omni auth in twitter
  field :provider, type:String
  field :uid, type:String




  def self.create_with_omniauth(auth_hash)
    create! do |user|
      user.provider = auth_hash["provider"]
      user.uid = auth_hash["uid"]
      if auth_hash['info']
        user.name = auth_hash['info']['name']
        user.location = auth_hash['info']['location']
        user.email = 'ejemplo@dominio.com'
        user.role = 'guest'
      end
      user.location = 'El mundo' if user.location.blank?



    end
  end


end
