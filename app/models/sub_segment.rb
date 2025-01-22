class SubSegment < ApplicationRecord
    belongs_to :segment
    has_many :contacts
    belongs_to :clients
    has_many :companies
    belongs_to :users
end
