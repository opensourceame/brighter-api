class Plan < Sequel::Model

  many_to_many :users,  join_table: :users_plans

end