class Laboratory < ApplicationRecord
  has_many :campaigns
  has_many :challenges
  has_many :users

  validates :name, presence:true, length: {maximum: 50}

end
