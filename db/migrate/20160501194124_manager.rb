class Manager < ActiveRecord::Migration
  def up
    manager = User.new
    manager.first_name = "Manager"
    manager.last_name = "Manager"
    manager.email = "manager@example.com"
    manager.password = "secret"
    manager.password_confirmation = "secret"
    manager.role = "manager"
    manager.save!
  end

  def down
    manager = User.find_by_email "manager@example.com"
    User.delete manager
  end
end
