class Submission < ApplicationRecord
  belongs_to :job

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :name, presence: true
  validates :email, uniqueness: {scope: :job_id, message: "você já está participando desse processo!"}
end
