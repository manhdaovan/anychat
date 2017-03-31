FactoryGirl.define do
  factory :user do
    id 1
    username 'test123'
    password 'test123password'
    trait :full_info do
      email 'test@example.com'
      receive_msg_offline false
    end

    trait :receive_message_offline do
      receive_msg_offline false
    end

  end
end
