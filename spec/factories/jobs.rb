FactoryBot.define do
  factory :job do
    title { "Desenvolvedor ruby" }
    description { "desenvolver aplicações" }
    start_date { Date.today }
    end_date { Date.today + 30 }
    status { "open" }
    skills { "Skill1, Skill2, Skill3" }
    association :recruiter

    trait :closed do
      status { "closed" }
    end

    trait :with_custom_dates do
      start_date { Date.today - 10 }
      end_date { Date.today + 10 }
    end
  end
end
