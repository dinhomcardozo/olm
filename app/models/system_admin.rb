class SystemAdmin < ApplicationRecord
    validates :email, presence: true, uniqueness: true
end