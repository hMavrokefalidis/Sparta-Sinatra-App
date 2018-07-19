class Vehicle
  attr_accessor :id, :name, :description

  def self.open_connection
    conn = PG.connect(dbname: "vehicles", user: "postgres", password: "1234")
  end

  def self.all
    conn = self.open_connection

    sql = "SELECT * FROM vehicle ORDER BY id"

    results = conn.exec(sql)

    vehicles = results.map do |data|
      self.hydrate data
    end

    return vehicles
  end

  def self.hydrate vehicle_data
    vehicle = Vehicle.new

    vehicle.id = vehicle_data["id"]
    vehicle.name = vehicle_data["name"]
    vehicle.description = vehicle_data["description"]

    return vehicle
  end

  def self.find id
    conn = self.open_connection

    sql = "SELECT * FROM vehicle WHERE id = #{id}"

    vehicles = conn.exec(sql)

    return self.hydrate vehicles[0]
  end

  def save
    conn = Vehicle.open_connection

    if !self.id
      sql = "INSERT INTO vehicle (name, description) VALUES ('#{self.name}', '#{self.description}')"
    else
      sql = "UPDATE vehicle SET name='#{self.name}', description='#{self.description}' WHERE id = #{self.id}"
    end
    conn.exec(sql)
  end

  def self.destroy id
    conn = self.open_connection

    sql = "DELETE FROM vehicle WHERE id = #{id}"

    conn.exec(sql)
  end
end
