class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = current_user.nil? ? User.find_or_create_for_oauth(env["omniauth.auth"]) : current_user

    sign_in_and_redirect @user, event: :authentication
  end
end
