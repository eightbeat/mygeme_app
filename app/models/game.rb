class Game < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500}
  validates :score, presence: true

  belongs_to :user
  validates :user_id, presence: true
end
