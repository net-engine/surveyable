FactoryGirl.define do

  sequence(:survey_title) { |n| "Survey #{n}" }
  sequence(:position) { |n| n }

  factory :survey, class: Surveyable::Survey do
    title { generate(:survey_title) }
    enabled true

    factory :survey_with_questions_and_answers do
      ignore do
        questions_count 2
      end

      after(:create) do |survey, evaluator|
        FactoryGirl.create_list(:question_with_answers, evaluator.questions_count, survey: survey)
      end
    end
  end

  factory :question, class: Surveyable::Question do
    content "What do you like?"
    field_type :radio_button_field

    factory :question_with_answers do
      ignore do
        answers_count 2
      end

      after(:create) do |question, evaluator|
        FactoryGirl.create_list(:answer, evaluator.answers_count, question: question)
      end
    end
  end

  factory :answer, class: Surveyable::Answer do
    content "Yes"
    position
  end

  factory :response, class: Surveyable::Response do
    access_token SecureRandom.uuid
    survey
  end

  factory :person do
    name 'Testing'
    email 'testing@email.com'
  end
end
