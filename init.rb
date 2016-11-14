require 'sinatra'
require 'rack/mount'
require 'logger'
require 'sequel'
require 'mysql2'
require 'securerandom'
require 'addressable/uri'
require 'json'

require_relative 'helpers/request'
require_relative 'helpers/response'

require_relative 'app/endpoints.rb'

DB_NAME = 'brighter'

Sequel.connect("mysql2://root@localhost/#{DB_NAME}")

DB = Sequel::DATABASES.first

require_relative 'models/plan'
require_relative 'models/user'
require_relative 'models/user_plan'

if [:development, :test].include?(Sinatra::Application.environment)

  # debugging goodness :)
  require 'pry'

end
