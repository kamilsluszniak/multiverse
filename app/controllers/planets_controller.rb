class PlanetsController < ApplicationController
  before_action :authenticate_user!


  def index
    @planet = current_user.planets.first
  end

  def resources
    @planet = Planet.where('id = ?', params[:id]).select([:id, :user_id, :metal_lvl, :crystal_lvl, :hydrogen_lvl, :solar_lvl]).first
    if @planet.user_id == current_user.id
      respond_with(@planet)
    else
      flash[:danger] = t('planet.actions.resources.not_your_planet')
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
end
