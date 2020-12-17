class UsersController < ApplicationController
  before_action :check_session, only: [:profile]
  def login
    user = User.find_by({email: params[:email]})
    raise StandardError, 'ログインIDかpasswordが違います' if user.nil? || !user.authenticate(params[:password])
    user.login
    render json: {access_token: user.access_token}, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: 401
  end

  def profile
    #TODO sirializerの導入
    render json: @user, status: :ok
  end
end
