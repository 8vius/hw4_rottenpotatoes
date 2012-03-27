FactoryGirl.define do
  factory :movie do
    title 'A Fake Title'
    rating 'PG'
    director 'A Fake Director'
    release_date {10.years.ago}
  end
end
