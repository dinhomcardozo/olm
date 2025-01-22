class User < ApplicationRecord
    self.primary_key = 'user_id'  # Adicione isso caso esteja usando um campo diferente de 'id'
    # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
