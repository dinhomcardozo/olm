class ClientProduct < ApplicationRecord
    belongs_to :client
    attribute :product_price, :decimal
end