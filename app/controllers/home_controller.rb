class HomeController < ApplicationController

  def home
  	@current_assignments = Assignment.current.by_store.by_employee.chronological.paginate(page: params[:page]).per_page(15)
  	@active_jobs = Job.active.alphabetical.paginate(page: params[:page]).per_page(10)
  	@active_stores = Store.active.alphabetical.paginate(page: params[:page]).per_page(10)
  	@upcoming_shifts = Shift.upcoming.chronological.paginate(page: params[:page]).per_page(10)
    @today_shifts = Shift.today.chronological.paginate(page: params[:page]).per_page(10)
  	@active_flavors = Flavor.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @active_employees = Employee.active.regulars.alphabetical.paginate(page: params[:page]).per_page(10)
    @active_managers = Employee.active.managers.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  def about
  end

  def privacy
  end

  def contact
  end

end