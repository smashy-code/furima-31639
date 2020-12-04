FactoryBot.define do
  factory :listing do
    product { '商品名hogehoge' }
    explanation { '長文　1000字まで' }
    category_id { 2 }
    status_id { 2 }
    delivery_id { 2 }
    area_id { 2 }
    day_id { 2 }
    price { 300 }

    association :user

    after(:build) do |listings|
      listings.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
