FactoryGirl.define do
  factory :user_account_access do
    access_type 0
    user
    account
  end
end
