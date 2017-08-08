require 'simple_token_authentication'

class User < ApplicationRecord
  acts_as_token_authenticatable
  belongs_to :laboratory, optional: true
  belongs_to :pharmacy, optional: true

  has_many :campaigns
  has_many :challenges
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates :first_name, presence:true, length: {maximum: 50}
  # validates :last_name, presence:true, length: {maximum: 50}
  # validates :role, presence:true, length: {maximum: 50}
end
