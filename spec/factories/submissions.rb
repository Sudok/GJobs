FactoryBot.define do
  factory :submission do
    name { "Bruce Banner" }
    email { Faker::Internet.email }
    mobile_phone { "1197655132" }
    resume { "Pessoa empenhada" }
    job_id { create(:job).id }
  end
end
