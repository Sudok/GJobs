class Job < ApplicationRecord
  include PgSearch::Model

  enum status: { active: 'active', inactive: 'inactive'}
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :recruiter

  pg_search_scope :search_jobs,
    against: [:title, :description, :skills],
    using: {tsearch: {prefix: true}}
end
