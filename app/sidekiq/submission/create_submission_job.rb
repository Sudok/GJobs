class Submission::CreateSubmissionJob
  include Sidekiq::Job

  def perform(submission_params)
    submission = Submission.new(submission_params)
    submission.save
  end
end
