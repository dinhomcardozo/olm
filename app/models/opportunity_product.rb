class OpportunityProduct < ApplicationRecord
    belongs_to :opportunity, foreign_key: 'opp_id'
    belongs_to :client_product
    belongs_to :stage
    belongs_to :client
end