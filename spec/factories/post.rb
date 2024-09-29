FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    
    association :user
    association :genre

    after(:build) do |post|
      post.image.attach(
        io: File.open(Rails.root.join('spec', 'images', 'files', 'no_image_square.jpg')),
        filename: 'no_image_square.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end