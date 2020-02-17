# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  name                   :string
#  phone                  :string
#  email                  :string           not null
#  password_digest        :string           not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  confirmation_token     :string
#  confirmation_sent_at   :datetime
#  confirmed_at           :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :with_confirmation_token do
      confirmation_token { SecureRandom.urlsafe_base64.to_s }
      confirmed_at { nil }
    end

    trait :confirmed do
      confirmed_at { Time.current }
    end
  end
end
