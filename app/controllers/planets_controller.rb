class PlanetsController < ApplicationController
  include PlanetsHelper
  before_action :authenticate_user!
  respond_to :html, :js

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

  def show_object
    @object = PlanetObject.new
    @object.name = params[:name]
    @planet = Planet.where('id = ?', params[:id]).select([:id, :user_id, query_rdy(@object.name), query_lvl(@object.name)]).first
    if @planet != nil
      if @planet.user_id == current_user.id
        @object.cost = meta_cost_hash(@object.name, @planet)
        ready_at = meta_time(@object.name, @planet)
        @object.time = (ready_at > Time.now) ? (ready_at - Time.now) : nil
        @object.lvl = meta_lvl(@object.name, @planet).to_s
        respond_to do |format|
          format.js
        end
      else
        flash[:danger] = t('planet.actions.resources.not_your_planet')
        redirect_to root_path
      end
    else
      flash[:danger] = t('planet.actions.resources.no_planet')
      redirect_to root_path
    end
  end

  def update_object
    @object = PlanetObject.new
    @object.name = params[:name]
    @planet = Planet.where('id = ?', params[:id]).select([:id, :user_id, query_rdy(@object.name), query_lvl(@object.name)]).first
    if @planet != nil
      if (@planet.user_id == current_user.id)
        @object.cost = meta_cost_hash(@object.name)
        if @object.time <= Time.now
          @object.time = meta_time(@object.name).to_s
          meta_upgrade(@object.name, @planet)
          if @planet.save!
            respond_to do |format|
              format.js
            end
          end
        end
      end
    end
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
      (object + "_lvl").to_sym
    end

    def meta_cost_hash(name, planet)
      planet.public_send("calc_#{name}_cost", eval("planet.#{name}_lvl"))
    end

    def meta_time(name, planet)
      eval("planet.#{name}_rdy_at")
    end

    def meta_lvl(name, planet)
      eval("planet.#{name}_lvl")
    end

    def meta_upgrade(name, planet)
      eval("planet.upgrade_#{name}")
    end
end
