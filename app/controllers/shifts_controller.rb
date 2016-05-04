class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  before_action(only: [:create, :destroy]) { deny_access(:employee) }

  def index
    @upcoming_shifts = Shift.upcoming.chronological.paginate(page: params[:page]).per_page(10)
    @past_shifts = Shift.past.chronological.paginate(page: params[:page]).per_page(10)
    #@list ||= Assignment.current.to_a.each {|a| @list.push [a.proper_name, a]}
    #@list = Array.new(Assignment.current.to_a.length) dAssignment.each }
  end
  
  def new
    @shift = Shift.new
  end

  def edit
  end

  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      # if saved to database
      flash[:notice] = "Successfully created shift."
      redirect_to shifts_path
    else
      # return to the 'new' form
      render action: 'new'
    end
  end

  def update
    if @shift.update(shift_params)
      redirect_to shift_path(@shift), notice: "Successfully updated #{@shift.employee.name}'s shift."
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @shift.destroy
    redirect_to shifts_path, notice: "Successfully removed #{@shift.employee.name}'s shift."
  end

  def show
  end

  private
  def shift_params
    params.require(:shift).permit()
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end

end