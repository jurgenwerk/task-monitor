# require 'rails_helper'

FactoryGirl.define do
  factory :application, class: Doorkeeper::Application do
    name 'my app'
    redirect_uri 'https://web.test'
  end

  factory :access_token, class: Doorkeeper::AccessToken
end
