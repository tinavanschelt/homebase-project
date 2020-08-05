require "rails_helper"

RSpec.describe "manage groups", type: :feature do
  let!(:admin) { users(:admin) }
  let!(:user) { users(:normal) }
  let!(:group) { create(:group)}

  context "normal users" do
    before do
      login_as(user)
      group.add_member(user)
      visit groups_path
    end

    it "lists group, but cannot edit or manage group" do
      expect(page).to have_content group.title
      expect(page).not_to have_link "Edit"
      expect(page).not_to have_link "Members"
    end

    it "redirects when the user tries to access the page directly" do
      visit group_path(group)
      expect(page).to have_current_path groups_path
    end
  end

  context "admin users" do
    before do
      login_as(admin)
      group.add_admin(admin)
      visit groups_path
    end

    it "lists group, but cannot edit or manage group" do
      expect(page).to have_content group.title
      expect(page).to have_link "Edit"
      expect(page).to have_link "Members"
    end

    it "redirects when the user tries to access the page directly" do
      visit group_path(group)
      expect(page).to have_current_path group_path(group)
    end
  end
end


