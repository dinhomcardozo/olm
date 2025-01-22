class Segment < ApplicationRecord
    has_many :companies
    has_many :contacts
    belongs_to :users
    belongs_to :client
    has_many :groups
    has_many :sub_segments
end
