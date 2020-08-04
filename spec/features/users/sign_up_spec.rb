require "rails_helper"

RSpec.describe "the user sign up process", type: :feature do
  let(:user) { create(:user) }
  let(:strong_password) { "@n3spR3sS0x" }

  context "renders form as expected" do
    it "has all fields, fields are correct type" do
      visit "/users/sign_up"

      expect(page).to have_field("user_email", type: 'email', visible: true)
      expect(page).to have_field("user_first_name", type: 'text', visible: true)
      expect(page).to have_field("user_last_name", type: 'text', visible: true)
      expect(page).to have_field("user_password", type: 'password', visible: true)
      expect(page).to have_field("user_password_confirmation", type: 'password', visible: true)
    end

    it "has a link to the login page" do
      visit "/users/sign_up"
      expect(page).to have_link "Log in"
      click_link "Log in"
      expect(page).to have_current_path new_user_session_path
    end
  end

  context "validates the password" do
    it "checks length and complexity" do
      visit "/users/sign_up"

      within("#new_user") do
        fill_in "user_email", with: "george@clooney.com"
        fill_in "user_password", with: "nespresso"
      end
      click_button "Sign up"
  
      expect(page).to have_content "Password is too short"
      expect(page).to have_content "Password is too weak"
    end
  end

  context "valid data" do
    it "creates a user and signs in" do
      visit "/users/sign_up"
  
      do_user_sign_up(strong_password)
  
      expect(page).to have_content "Welcome! You have signed up successfully."
      expect(page).to have_current_path root_path

      new_user = User.last
      expect(user.role).to eq "normal"
    end
  end

  context "invalid data" do
    it "validates email address" do
      visit "/users/sign_up"
  
      within("#new_user") do
        fill_in "user_email", with: "george"
      end
      click_button "Sign up"

      expect(page).to have_current_path new_user_registration_path
    end

    it "ensures that a first and last name is entered" do
      visit "/users/sign_up"
  
      within("#new_user") do
        fill_in "user_email", with: "george@clooney.com"
        fill_in "user_password", with: strong_password
        fill_in "user_password_confirmation", with: strong_password
      end
      click_button "Sign up"
      
      expect(page).to have_content "First name can't be blank"
      expect(page).to have_content "Last name can't be blank"
    end
  end
end
