FactoryBot.define do
  factory :staff do
    email { 'staff@test.com' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
