class EmployeeAccount < ActiveRecord::Migration
  def up
	t = Employee.new
  	t.first_name = "employee"
    t.last_name = "employee"
    t.ssn = "023-00-3032"
    t.date_of_birth = 15.years.ago
    t.phone = "123-121-1212"
    t.role = "employee"
    t.active = true
    t.save!

    employeeAccount = User.new
    employeeAccount.employee_id = t.id
    employeeAccount.email = "employee@example.com"
    employeeAccount.password = "secret"
    employeeAccount.password_confirmation = "secret"
    employeeAccount.save!
  end

  def down
    employeeAccount = User.find_by_email "employee@example.com"
    User.delete employeeAccount
  end
end
