require 'rack/test'

def get_data(response)
  JSON.parse(response.body)
end

describe 'Brighter API' do

  include Rack::Test::Methods

  def app
     API::App
  end

  it "subscribes a user to plans" do

    post '/user/1/subscriptions', {
        plans: [ 1, 3]
    }

    expect(last_response.status).to eq 201
  end

  it "lists all subscriptions" do

    get '/subscriptions'

    expect(last_response.status).to eq 200

    data = get_data(last_response)

    expect(data['subscriptions']).to be_a(Array)

  end

  it "deletes a user's subscription" do

    delete '/user/1/subscriptions/1'

    expect(last_response.status).to eq 200

  end




end