class Opportunity < ApplicationRecord
  belongs_to :company
  belongs_to :clients
  belongs_to :contact
  has_many :opportunity_products, foreign_key: 'opp_id', dependent: :destroy
  has_many :client_products
  belongs_to :stage

  has_many :prospected_products, -> { where(stage: 'Prospect') }, class_name: 'OpportunityProduct'
  has_many :interested_products, -> { where(stage: 'Lead') }, class_name: 'OpportunityProduct'
  has_many :demonstrated_products, -> { where(stage: 'Demonstration') }, class_name: 'OpportunityProduct'
  has_many :quoted_products, -> { where(stage: 'Quote') }, class_name: 'OpportunityProduct'
  has_many :sold_products, -> { where(stage: ['Sale', 'PostSale', 'AboutToRenew']) }, class_name: 'OpportunityProduct'
  has_many :rejected_products, -> { where(stage: 'LossSale') }, class_name: 'OpportunityProduct'
  has_many :canceled_products, -> { where(stage: 'NotRenewed') }, class_name: 'OpportunityProduct' #alterar o stage para 'Canceled' quando fizer Stage Canceled

  # Método para calcular o preço total
  def total_product_price
    opportunity_products.sum { |op| op.client_product.product_price }
  end
end