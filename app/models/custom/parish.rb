class Parish < ActiveRecord::Base
    has_many :neighborhoods

    def self.parish_options
        Parish.all.order(:name).pluck(:name, :id)
    end
end
