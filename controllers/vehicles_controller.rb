class VehiclesController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), '..')

  set :views, Proc.new { File.join(root, "views") }

  configure :development do
    register Sinatra::Reloader
  end

  # INDEX
  get "/" do
    @title = "Vehicle"
    @vehicle = Vehicle.all
    erb :"vehicles/index"
  end

  # NEW
  get "/new" do
    vehicle = Vehicle.new

    @vehicle = vehicle
    @vehicle.id=""

    erb :"vehicles/new"
  end

  # SHOW
  get "/:id" do
    id = params[:id].to_i
    @vehicle = Vehicle.find(id)

    erb :"vehicles/show"
  end

  #CREATE
  post "/" do
    vehicle = Vehicle.new

    vehicle.name = params[:name]
    vehicle.description = params[:description]

    vehicle.save

    redirect "/"
  end

  # EDIT
  get "/:id/edit" do
    id = params[:id].to_i
    @vehicle = Vehicle.find(id)
    erb :"vehicles/edit"
  end

  # UPDATE
  put "/:id" do
    id = params[:id].to_i
    vehicle = Vehicle.find(id)
    vehicle.name = params[:name]
    vehicle.description = params[:description]

    vehicle.save

    redirect "/"
  end

  # DESTROY
  delete "/:id" do
    # get the ID
    id = params[:id].to_i

    # delete the post from the database
    Vehicle.destroy(id)

    # redirect back to the homepage
    redirect "/"
  end
end
