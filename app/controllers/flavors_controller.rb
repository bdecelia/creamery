class FlavorsController < ApplicationController
  before_action :set_flavor, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  def index
    @active_flavors = Flavor.active.alphabetical.paginate(page: params[:page]).per_page(10)
    @inactive_flavors = Flavor.inactive.alphabetical.paginate(page: params[:page]).per_page(10)
  end

  def new
    @flavor = Flavor.new
  end

  def edit
  end

  def create
    @flavor = Flavor.new(flavor_params)
    if @flavor.save
      # if saved to database
      flash[:notice] = "Successfully created flavor."
      redirect_to flavors_path
    else
      # return to the 'new' form
      render action: 'new'
    end
  end

  def update
  	if @flavor.update(flavor_params)
      redirect_to flavor_path(@flavor), notice: "Successfully updated #{@store.name}."
    else
      render action: 'edit'
    end
  end
  
  def destroy
  	@flavor.destroy
    redirect_to flavors_path, notice: "Successfully removed #{@flavor.name} from the AMC system."
  end

  def show
  end

  private
  def flavor_params
    params.require(:flavor).permit(:id, :name, :active)
  end

  def set_flavor
    @flavor = Flavor.find(params[:id])
  end

end