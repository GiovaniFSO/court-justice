FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    email { 'jhon@doe.com' }
    password { '123456' }
    role { 'user' }
    name { 'Jhon Doe' }
  end
end
