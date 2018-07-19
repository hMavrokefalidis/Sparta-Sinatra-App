require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader" if development?
require "sinatra/cookies"
require "pg"
require_relative "controllers/vehicles_controller.rb"
require_relative "models/vehicle.rb"

use Rack::MethodOverride
run VehiclesController
