class ProfilesController < ApplicationController
  before_action :check_session
  def show
    #TODO sirializerの導入
    render json: @user, status: :ok
  end

  def update
    @user.update!(profile_params)
    render json: @user, status: :no_content
  end

  private
  def profile_params
    params.permit(:name)
  end
end
