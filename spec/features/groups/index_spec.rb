require "rails_helper"

RSpec.describe "create and manage groups", type: :feature do
  let!(:user) { users(:admin) }
  let!(:group) { groups(:beecham) }

  context "non users" do
    it "does not grant user access to the group index, edit or members pages" do
      visit groups_path
      expect(page).to have_current_path new_user_session_path

      visit group_path(group)
      expect(page).to have_current_path new_user_session_path

      visit edit_group_path(group)
      expect(page).to have_current_path new_user_session_path
    end
  end

  context "create new group" do
    before do 
      login_as(user)
      group.add_admin(user)
    end

    it "successfully creates a new group" do
      visit groups_path
      expect(page).to have_current_path groups_path

      # lists groups
      expect(page).to have_content "The Beechams"

      # can create new group
      expect(page).to have_link "New Group"
      click_link "New Group"

      # links to new group page
      expect(page).to have_current_path new_group_path

      # creates new group
      fill_in "Title", with: "Another Group"
      click_button "Create Group"
      expect(page).to have_content "Group was successfully created."

      # new group has access_code
      new_group = Group.last
      expect(new_group.access_code.length).not_to eq 0

      expect(page).to have_current_path group_path(new_group)
      expect(page).to have_content "john@beecham.com"
    end
  end

  context "invite members to a group" do
    before do 
      login_as(user)
      group.add_admin(user)
    end

    it "url takes invitee to registration page with code and adds them to the correct group" do
      visit group_path(group)
      expect(page).to have_content "The Beechams"
      
      expect(page).to have_content "john@beecham.com"
      expect(page).to have_content 'This group does not have any invitees yet.'

      sign_out

      visit invitation_path(group.access_code)
      expect(page).to have_current_path new_user_registration_path(code: group.access_code)

      do_user_sign_up
      expect(page).to have_content("Welcome! You have signed up successfully.")
      visit group_path(group)
      expect(page).to have_current_path groups_path

      sign_out
      login_as(user)
      visit group_path(group)

      expect(page).to have_content "john@beecham.com"
      expect(page).to have_content "george@clooney.com"
    end
  end

  def sign_out
    visit root_path
    click_link "Sign Out"
  end
end


