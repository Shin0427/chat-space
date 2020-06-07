FactoryBot.define do
  factory :group, class: Group do
    # name 'Group1' Wrong
    # name { "Group1" }
    name {Faker::Team.name}
  end
end