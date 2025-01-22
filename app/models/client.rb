class Client < ApplicationRecord
    has_many :users
    has_many :groups
    has_many :companies
    has_many :opportunities
    belongs_to :plan
  
    validates :cnpj, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
end
