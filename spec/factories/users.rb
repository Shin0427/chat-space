FactoryBot.define do
  factory :user, class: User do
    password = Faker::Internet.password(min_length: 8)
    name {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password {password}
    password_confirmation {password}

    # name {'Taro'}
    # email {'aaa@gmail.com'}
    # password {'password'}
    # password_confirmation {'password'}

  end
end