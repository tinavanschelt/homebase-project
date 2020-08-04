require "rails_helper"

RSpec.describe "the user sign in process", type: :feature do
  let(:user) { create(:user) }
  let(:strong_password) { "@n3spR3sS0x" }

  context "renders form as expected" do
    it "has all fields, fields are correct type" do
      visit "/users/sign_in"

      expect(page).to have_field("user_email", type: 'email', visible: true)
      expect(page).to have_field("user_password", type: 'password', visible: true)
    end

    it "has a link to the login page" do
      visit "/users/sign_in"
      expect(page).to have_link "Sign up"
      click_link "Sign up"
      expect(page).to have_current_path new_user_registration_path
    end
  end

  context "when logged out" do
    it "restricted pages redirect to login page" do
      visit groups_path
      expect(page).to have_current_path new_user_session_path
    end
  end 

  context "validates the password" do
    it "checks length and complexity" do
      visit "/users/sign_in"

      within("#new_user") do
        fill_in "user_email", with: "george@clooney.com"
      end
      click_button "Log in"
  
      expect(page).to have_content "Invalid Email or password."
      
      within("#new_user") do
        fill_in "user_password", with: strong_password
      end
      click_button "Log in"

      expect(page).to have_content "Invalid Email or password."
    end
  end

  context "valid data" do
    it "creates a user and signs in" do
      visit "/users/sign_up"
      do_user_sign_up(strong_password)
      click_link "Sign Out"
      do_user_sign_in(strong_password)
  
      expect(page).to have_content "Signed in successfully."
      expect(page).to have_current_path root_path
    end
  end

  context "invalid data" do
    it "validates email address" do
      visit "/users/sign_in"
  
      within("#new_user") do
        fill_in "user_email", with: "george"
      end
      click_button "Log in"

      expect(page).to have_current_path new_user_session_path
    end
  end
end


