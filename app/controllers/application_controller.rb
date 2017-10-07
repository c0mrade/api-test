class ApplicationController < ActionController::API
  #include DeviseTokenAuth::Concerns::SetUserByToken
  # We can ignore authentication for now, assuming gem devise_token_auth does that for us
  # I worked with this gem back in 2015, looked familiar when I was looking through your code
  # found 2 issues I raised back then still open
  # https://github.com/lynndylanhurley/devise_token_auth/issues/166 and https://github.com/lynndylanhurley/devise_token_auth/issues/101

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session - come back later to this

  def welcome
    render json: { version: 'v1' }
  end
end
