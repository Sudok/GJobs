require 'rails_helper'

RSpec.describe "Jobs", type: :request do

  context "GET /jobs" do
    before do
      @jobs = create_list(:job, 5)
    end

    it 'list all jobs' do
      get jobs_url

      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      job = Job.create! valid_attributes
      get job_url(job), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Job" do
        expect {
          post jobs_url,
               params: { job: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Job, :count).by(1)
      end

      it "renders a JSON response with the new job" do
        post jobs_url,
             params: { job: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Job" do
        expect {
          post jobs_url,
               params: { job: invalid_attributes }, as: :json
        }.to change(Job, :count).by(0)
      end

      it "renders a JSON response with errors for the new job" do
        post jobs_url,
             params: { job: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested job" do
        job = Job.create! valid_attributes
        patch job_url(job),
              params: { job: new_attributes }, headers: valid_headers, as: :json
        job.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the job" do
        job = Job.create! valid_attributes
        patch job_url(job),
              params: { job: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the job" do
        job = Job.create! valid_attributes
        patch job_url(job),
              params: { job: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested job" do
      job = Job.create! valid_attributes
      expect {
        delete job_url(job), headers: valid_headers, as: :json
      }.to change(Job, :count).by(-1)
    end
  end
end
