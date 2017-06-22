FactoryGirl.define do
  factory :ticket do 
    from_name "Test"
    from_email "test@gmail.com"
    subject "test"
    body "Test test test test test"
  end
end
