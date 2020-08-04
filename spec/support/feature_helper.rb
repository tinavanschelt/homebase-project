module FeatureHelper
  def do_user_sign_up
    within("#new_user") do
      fill_in "user_email", with: "george@clooney.com"
      fill_in "user_password", with: "@n3spR3sS0x"
      fill_in "user_password_confirmation", with: "@n3spR3sS0x"
      fill_in "user_first_name", with: "George"
      fill_in "user_last_name", with: "Clooney"
    end

    click_button "Sign up"
  end

  def do_user_sign_in
    within("#new_user") do
      fill_in "user_email", with: "george@clooney.com"
      fill_in "user_password", with: "@n3spR3sS0x"
    end

    click_button "Log in"
  end
end

RSpec.configure do |config|
  config.include FeatureHelper, type: :feature
end