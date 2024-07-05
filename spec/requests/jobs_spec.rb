require 'rails_helper'

RSpec.describe "Jobs", type: :request do

  let(:headers) { { "ACCEPT" => "application/json" } }
  let!(:recruiter) { create(:recruiter) }
  let(:valid_attributes) { attributes_for(:job) }
  let(:invalid_attributes) { attributes_for(:job, title: '', description: '') }

  before do
    post recruiter_login_session_url, params: { email: recruiter.email, password: recruiter.password }
    @auth_headers = response.headers.slice('client', 'access-token', 'uid')
  end


  context "GET /jobs" do
    before do
      @jobs = create_list(:job, 5)
    end

    it 'list all jobs' do
      get '/jobs', headers: headers

      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(5)
    end

    it 'list querying jobs' do
      job = create(:job, title: 'Desenvolvedor SAP')

      get "/jobs/?query=#{job.title}", headers: headers

      expect(response).to be_successful
      json_response = JSON.parse(response.body)

      expect(json_response.size).to eq(1)
      response_job = json_response.first
      expect(response_job["id"]).to eql job.id
    end
  end

  describe "GET /show" do
    let(:job) { create(:job, title: "Dev Lua") }

    it "renders a successful response" do
      get "/jobs/#{job.id}", headers: headers

      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response["title"]).to eql job.title
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Job" do
        post jobs_url, params: {job: valid_attributes}, headers: @auth_headers, as: :json

        expect(response).to be_successful
        json_response = JSON.parse(response.body)
        expect(json_response["title"]).to eql valid_attributes[:title]
      end

      it "renders a JSON response with the new job" do
        post jobs_url,
             params: {job: valid_attributes}, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Job" do
        expect {
          post jobs_url,
               params: { job: invalid_attributes }, headers: @auth_headers, as: :json
        }.to change(Job, :count).by(0)
      end

      it "renders a JSON response with errors for the new job" do
        post jobs_url,
             params: { job: invalid_attributes }, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        attributes_for(:job, title: "Desenvolvedor HTML")
      }

      it "updates the requested job" do
        job = Job.create! valid_attributes
        patch job_url(job),
              params: { job: new_attributes }, headers: @auth_headers, as: :json
        job.reload

        json_response = JSON.parse(response.body)
        expect(json_response["title"]).to eql new_attributes[:title]
      end

      it "renders a JSON response with the job" do
        job = Job.create! valid_attributes
        patch job_url(job),
              params: { job: new_attributes }, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the job" do
        job = Job.create! valid_attributes
        patch job_url(job),
              params: { job: invalid_attributes }, headers: @auth_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested job" do
      job = Job.create! valid_attributes
      expect {
        delete job_url(job), headers: @auth_headers, as: :json
      }.to change(Job, :count).by(-1)
    end
  end
end
