module API

end

class API::App < Sinatra::Base

  before do
    content_type 'application/json'
  end

  # service is alive :-)
  get '/' do
    response.add_data(status: :ok)
  end

  # get a list of subscribed users on each plan
  get '/subscriptions' do

    plans = Plan.all

    data = {
        status:         :ok,
        subscriptions:  []
    }

    plans.each do |plan|

      plan_data = {
                    plan_id:        plan.id,
                    name:           plan.name,
                    total_users:    plan.users.count,
                    users:          []
                  }

      plan.users_dataset.where(status: 'active').all.each do |user|

        plan_data[:users].push({
                                    id:           user.id,
                                    first_name:   user.first_name,
                                    last_name:    user.last_name,
                                    email:        user.email,
                                   })
      end

      data[:subscriptions].push(plan_data)

    end

    response.set_data(data)

  end

  # subscribe a user to one or more plans
  post '/users/:user_id/subscriptions' do

    user = User[params[:user_id]]
    plans = request.data['plans']

    response.fail('no such user', 404) unless user
    response.fail('no plans specified', 403) unless plans.is_a?(Array) && plans.count > 0

    # subscribe the user to each plan
    plans.each do |plan_id|
      response.fail("unable to subscribe user to plan #{plan_id}") unless user.subscribe_to(plan_id)
    end

    response.code = 201
    response.set_data({status: :ok})

  end

  # unsubscribe a user from a plan
  # XXX:
  delete '/users/:user_id/subscriptions/:plan_id' do

    plan_id = params[:plan_id]
    plan    = Plan[plan_id]
    user    = User[params[:user_id]]

    response.fail('no such user', 404) unless user
    response.fail('no such plan', 404) unless plan
    response.fail('user not subscribed', 403) unless user.subscribed_to?(plan_id)

    user.unsubscribe_from(plan_id)

    response.set_data({status: :ok})

  end



end
