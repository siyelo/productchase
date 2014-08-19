require 'rails_helper'

module UserSupport
  def create_user variant = nil
    user = User.create! uid: "productchase_uid#{variant}", \
      provider: 'twitter',
      name: "ProductChase User #{variant}",
      password: "rAnD0mPaSsW0rD#{variant}",
      twitter_username: "productchase_user#{variant}"

    self.instance_variable_set(["@user", variant].compact.join('_'), user)
  end
end
