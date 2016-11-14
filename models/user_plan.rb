class UserPlan < Sequel::Model(:users_plans)

  def unsubscribe
    update({status: 'unsubscribed'})
  end

end
