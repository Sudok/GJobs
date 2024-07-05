class Job < ApplicationRecord
  enum status: { active: 'active', inactive: 'inactive'}
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :recruiter
end
