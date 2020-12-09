class ApplicationController < ActionController::API
  def check_session
    access_token = request.headers[:Authorization]
    raise Exception 'アクセストークンを指定してください' if access_token.nil?
    @user = User.find_by(access_token: access_token)
    raise Exception 'アクセストークンが正しくありません' if @user.nil?
  rescue StandardError => e
    render json: { error: e.message }, status: 401
  end
end
