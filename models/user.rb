class User < Sequel::Model

  many_to_many :plans,  join_table: :users_plans, class: 'Plan'

  one_to_many :subscriptions, class: 'UserPlan'

  def subscribe_to(plan_id)

    return true if subscribed_to?(plan_id)

    return false unless plan = Plan[plan_id]

    subscription = UserPlan.create({
                      user_id:        id,
                      plan_id:        plan.id,
                      subscribed_on:  Date.today,
                    })

    true

  end

  def subscribed_to?(plan_id)
    subscription(plan_id).nil? ? false : true
  end

  def unsubscribe_from(plan_id)
    subscription = subscription(plan_id)

    return false unless subscription

    subscription.destroy

    true

  end

  def subscription(plan_id)
    subscriptions_dataset.where(user_id: id, plan_id: plan_id, status: 'active').first
  end

end