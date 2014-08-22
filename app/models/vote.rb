class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates :user, presence: true
  validates :product, presence: true
  validates :user, uniqueness: { scope: :product }
end
