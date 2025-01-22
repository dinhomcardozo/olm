class Contact < ApplicationRecord
    belongs_to :company
    belongs_to :group
    belongs_to :segment, optional: true
    belongs_to :sub_segment, class_name: "SubSegment", optional: true
    has_and_belongs_to_many :opportunities

    validates :email, presence: true, uniqueness: true

    def full_name
        "#{first_name} #{last_name}"
    end

end