class ModsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_mod, only: [:destroy]
  before_action :setup_mod_service

  def index
    @mods = Mod.all
    render json: @mods
  end

  def create
    maybe = @mod_service.create_mod(mod_params["project_url"])
    if maybe.just?
      render json: maybe.just, status: :created, location: maybe.just
    else
      render json: maybe.reason, status: :unprocessable_entity
    end
  end

  def destroy
    @mod.destroy
  end

  def check_updates
    render json: @mod_service.retrieve_mods_updated
  end

  private

  def set_mod
    @mod = Mod.find(params[:id])
  end

  def setup_mod_service
    @mod_service = ModService.new
  end

  def mod_params
    params.require(:mod).permit(:project_url)
  end
end
