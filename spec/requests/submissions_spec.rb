require 'rails_helper'

RSpec.describe "Submissions", type: :request do

let(:headers) { { "ACCEPT" => "application/json" } }
let(:valid_attributes) { attributes_for(:submission) }


  describe "GET /submissions" do
    before do
      @jobs = create_list(:submission, 3)
    end

    it "List all submissions applied" do
      get submissions_url, headers: headers

      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(3)
    end
  end

  describe "GET /show" do
    let(:submission) { create(:submission, name: "Steve Wozniak") }

    it "renders a successful response" do
      get "/submissions/#{submission.id}", headers: headers

      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eql submission.name
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Submission" do
        post submissions_url,
            params: { submission: attributes_for(:submission) }, headers: headers, as: :json

        expect(response).to be_successful
      end
    end

    context "when the user has already applied" do
      let(:submission) { create(:submission, email: "has_applied@jobs.com") }

      it "does not create a new Submission" do
        post submissions_url,
        params: { submission: submission}, headers: headers, as: :json

        expect(response).to have_http_status(422)
        expect(response.body).to match(/"você já está participando desse processo!"/)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        attributes_for(:submission, email: "antony@starkindustries.com")
      }

      it "updates the requested submission" do
        submission = Submission.create! valid_attributes
        patch submission_url(submission),
              params: { submission: new_attributes }, headers: headers, as: :json
        submission.reload

        json_response = JSON.parse(response.body)
        expect(json_response["email"]).to eql new_attributes[:email]
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) {
        attributes_for(:submission, email: "antonystarkindustriescom")
      }

      it "renders a JSON response with errors for the submission" do
        submission = Submission.create! valid_attributes
        patch submission_url(submission),
              params: { submission: invalid_attributes }, headers: headers, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested submission" do
      submission = Submission.create! valid_attributes
      expect {
        delete submission_url(submission), headers: headers, as: :json
      }.to change(Submission, :count).by(-1)
    end
  end
end
