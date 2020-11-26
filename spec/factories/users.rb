FactoryBot.define do
  factory :user do
    password = '1Aa' + Faker::Internet.password(min_length: 6)
    nickname { Faker::Name.initials(number: 2) }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
    last_name { '田中' }
    first_name { '太郎' }
    last_name_kana { 'タナカ' }
    first_name_kana { 'タロウ' }
    birthday { Date.today }
  end
end
