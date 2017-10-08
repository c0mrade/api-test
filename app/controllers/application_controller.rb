class ApplicationController < ActionController::API
  #include DeviseTokenAuth::Concerns::SetUserByToken
  # We can ignore authentication for now, assuming gem devise_token_auth does that for us
  # I worked with this gem back in 2015, looked familiar when I was looking through your code
  # found 2 issues I raised back then still open
  # https://github.com/lynndylanhurley/devise_token_auth/issues/166 and https://github.com/lynndylanhurley/devise_token_auth/issues/101

  #protect_from_forgery with: :null_session - http://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection.html
  # Dont need this as API is probably stateless

  def welcome
    render json: { version: 'v1' }
  end

  rescue_from StandardError do |exception|
    #send_email_of_error #pretend that send_email_of_error sends the uncaught errors to bugsnag or rollbar
    # so that there is a way to capture and fix errors in production at earliest possible time
    raise exception
  end
end
