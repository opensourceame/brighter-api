describe 'Test models' do

  it 'subscribes a user to a plan' do

    user    = User.first
    result  = user.subscribe_to(3)

    expect(result).to eq true

    plan = user.plans.last

    expect(plan.name).to eq 'video'

    subscription = user.subscription(plan.id)

    expect(subscription.status).to eq 'active'
    expect(subscription.subscribed_on).to eq Date.today

  end

  it 'tries to subscribe a user to a nonexistent plan' do

    user    = User.first
    result  = user.subscribe_to(666)

    expect(result).to eq false

  end


  it 'tries to unsubscribe a user from a plan' do

    user    = User.first
    result  = user.unsubscribe_from(3)

    expect(result).to eq true

  end





end