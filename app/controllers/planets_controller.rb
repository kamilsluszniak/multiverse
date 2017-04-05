class PlanetsController < ApplicationController
  before_action :authenticate_user!


  def index
    @planet = current_user.planets.first
  end

  def resources
    @planet = Planet.where('id = ?', params[:id]).select([:id, :user_id, :metal_lvl, :crystal_lvl, :hydrogen_lvl, :solar_lvl]).first

    if @planet != nil
      if @planet.user_id == current_user.id
        respond_with(@planet)
      else
        flash[:danger] = t('planet.actions.resources.not_your_planet')
        redirect_to root_path
      end
    else
      flash[:danger] = t('planet.actions.resources.no_planet')
      redirect_to root_path
    end
  end

  def show_metal
    @object = PlanetObject.new
    @object.name = params[:name]
    @planet = Planet.where('id = ?', params[:id]).select([:id, :user_id, query_rdy(@object.name), query_lvl(@object.name)]).first
    if @planet != nil
      if @planet.user_id == current_user.id
        @object.cost = meta_cost_hash(@object.name)
      else
        flash[:danger] = t('planet.actions.resources.not_your_planet')
        redirect_to root_path
      end
    else
      flash[:danger] = t('planet.actions.resources.no_planet')
      redirect_to root_path
    end
  end

  def build_metal

  end

  def research
  end

  def offensive
  end

  def defensive
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def planet_params
        params.require(:planet).permit(:name)
    end

    def query_rdy(object)
      (object + "_rdy_at").to_sym
    end

    def query_lvl(object)
      (object + "_lvl").to.sym
    end

    def meta_cost_hash(name)
      @planet.public_send("calc_#{name}_cost", eval("@planet.#{name}_lvl"))
    end
end
