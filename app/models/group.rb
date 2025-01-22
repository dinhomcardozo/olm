class Group < ApplicationRecord
    has_many :companies
    belongs_to :client

end