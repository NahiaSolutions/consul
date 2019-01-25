class House < ActiveRecord::Base
    belongs_to :zonal_administration
    has_many :workshops, :dependent => :destroy
    has_many :house_news, :dependent => :destroy
    has_many :house_images, :dependent => :destroy
    accepts_nested_attributes_for   :house_news
    has_one :map_location, :dependent => :destroy
    accepts_nested_attributes_for   :map_location
    include Imageable

    validates :name, :presence => true, format: {with: /\A^[a-zA-Z0-9ñáéíóú\s]+$\Z/i}
    validates :address, :presence => true, format: {with: /\A^[a-zA-Zñáéíóú0-9.\-#,\s]+$\Z/i}
    validates :schedule, :presence => true, format: {with: /\A^[a-zA-Z0-9\s\/:.\-]+$\Z/i}
    validates :phone, :presence => true, format: {with: /\A^[0-9\/]+$\Z/i}
    validates :email, :presence => true, format: { with: URI::MailTo::EMAIL_REGEXP }

end