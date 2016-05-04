class Admin < ActiveRecord::Migration
  def up
  	a = Employee.new
  	a.first_name = "admin"
    a.last_name = "admin"
    a.ssn = "021-00-3032"
    a.date_of_birth = 15.years.ago
    a.phone = "121-121-1212"
    a.role = "admin"
    a.active = true
    a.save!
    
    admin = User.new
    admin.employee_id = a.id
    admin.email = "admin@example.com"
    admin.password = "secret"
    admin.password_confirmation = "secret"
    admin.save!
  end

  def down
    admin = User.find_by_email "admin@example.com"
    User.delete admin
  end
end
