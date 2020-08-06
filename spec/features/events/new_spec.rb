require "rails_helper"

RSpec.describe "create events", type: :feature do
  let!(:admin) { users(:admin) }
  let!(:user) { users(:normal) }
  let!(:group) { groups(:beecham) }
  let!(:birthday) { events(:birthday)}
  let!(:bread) { tasks(:bread)}


  context "non users" do
    it "does not grant user access to the group index, edit or members pages" do
      visit events_path
      expect(page).to have_current_path new_user_session_path

      visit event_path(birthday)
      expect(page).to have_current_path new_user_session_path

      visit edit_event_path(birthday)
      expect(page).to have_current_path new_user_session_path
    end
  end

  context "create a new event" do
    before { login_as(user) }

    it "redirects user if user does not have a group" do
      visit event_path(birthday)
      expect(page).to have_current_path root_path
    end

    it "successfully creates a new event" do
      group.add_member(user)
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


