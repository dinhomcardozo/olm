class Company < ApplicationRecord
    has_many :opportunities
    belongs_to :user
    belongs_to :group, optional: true
    belongs_to :segment, optional: true
    belongs_to :sub_segment, optional: true
    belongs_to :client
    has_many :contacts
end