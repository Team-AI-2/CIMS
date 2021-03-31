class AddDbAdmin < ActiveRecord::Migration[6.1]
  def change
    Club.create(name: "DB Manager")
    Position.create(name: "DB Manager")
    Member.create(
      f_name: "Database",
      l_name: "Manager",
      email: "db@manager.com",
      password: "12345678",
      password_confirmation: "12345678",
      active: 1,
      club_id: 1,
      position_id: 1)
  end
end
