class Employee < ActiveRecord::Migration
  def up
    employee = User.new
    employee.first_name = "Employee"
    employee.last_name = "Employee"
    employee.email = "employee@example.com"
    employee.password = "secret"
    employee.password_confirmation = "secret"
    employee.role = "employee"
    employee.save!
  end

  def down
    employee = User.find_by_email "employee@example.com"
    User.delete employee
  end
end
