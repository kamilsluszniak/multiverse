class PlanetsController < ApplicationController
  before_action :authenticate_user!

  def summary
  end

  def resources
    @planet = Planet.where('id = ?', params[:id]).select([:metal_lvl, :crystal_lvl, :hydrogen_lvl, :solar_lvl])
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
