require_relative '../lib/string_to_class'

def seed_tables

  # reload models
  Plan.set_dataset      :plans
  User.set_dataset      :users
  UserPlan.set_dataset  :users_plans

  # load seed data
  yaml = YAML.load_file('migrations/01_seed_initial_tables.yaml').each

  yaml.each do |type, collection|

    collection.each do |data|
      object = type.to_class.create(data)
    end

  end

end

Sequel.migration do

  up do

    create_table(:plans) do
      primary_key :id, type: Bignum
      DateTime  :created_at
      DateTime  :updated_at
      String    :name,              size: 20
      String    :description
    end

    create_table(:users) do
      primary_key :id, type: Bignum
      DateTime  :created_at
      DateTime  :updated_at
      String    :first_name,        size: 50,   null: false
      String    :last_name,         size: 50
      String    :email,             size: 150

      index :email
    end

    create_table(:users_plans) do
      primary_key :id, type: Bignum
      DateTime  :created_at
      DateTime  :updated_at
      Bignum    :user_id
      Bignum    :plan_id
      Date      :subscribed_on
      String    :status,            size: 10,   default: 'active'     # possible statuses could be active / expired / deleted

      index :user_id
    end

    seed_tables

  end

  down do
    drop_table(:plans)
    drop_table(:users)
    drop_table(:users_plans)
  end

end
