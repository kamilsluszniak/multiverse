class Planet < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :system
  validates :name, presence: true
end
