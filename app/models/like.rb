class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validate do
    unless user && user.likable_for?(post)
      errors.add(:base, :invalid)
    end
  end
end
