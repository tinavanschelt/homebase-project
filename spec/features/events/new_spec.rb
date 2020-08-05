require "rails_helper"

RSpec.describe "create events", type: :feature do
  let!(:admin) { users(:admin) }
  let!(:user) { users(:normal) }

  context "create a new event" do
    before { login_as(user) }

    it "successfully creates a new event" do
      visit root_path
      expect(page).to have_content "Hi, Anna!"
      click_link "Create New Event"
      expect(page).to have_current_path new_event_path

      fill_in "Title", with: "Party!"
      fill_in "Description", with: "It's my party and I'll cry if I want to."
      click_button "Create Event"

      expect(page).to have_content "Event was successfully created."

      # Event is listed
      visit events_path
      expect(page).to have_content "Party!"
    end
  end
end


