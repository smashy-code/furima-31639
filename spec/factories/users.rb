FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(min_length: 6)
    nickname { Faker::Name.initials(number: 2) }
    email { Faker::Internet.free_email }
    password { password }
    password_confirmation { password }
    last_name { '田中' }
    first_name { '太郎' }
    last_name_kana { 'タナカ' }
    first_name_kana { 'タロウ' }
    birthday { '1930年1月1日' }
  end
end
