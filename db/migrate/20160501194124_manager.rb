class Manager < ActiveRecord::Migration
  def up
  	m = Employee.new
  	m.first_name = "manager"
    m.last_name = "manager"
    m.ssn = "022-00-3032"
    m.date_of_birth = 15.years.ago
    m.phone = "122-121-1212"
    m.role = "manager"
    m.active = true
    m.save!

    manager = User.new
    manager.employee_id = m.id
    manager.email = "manager@example.com"
    manager.password = "secret"
    manager.password_confirmation = "secret"
    manager.save!
  end

  def down
    manager = User.find_by_email "manager@example.com"
    User.delete manager
  end
end
