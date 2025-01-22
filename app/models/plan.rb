class Plan < ApplicationRecord
    has_many :clients

    validates :plan_name, presence: true
    validates :plan_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
