require "rails_helper"

RSpec.describe "create tasks", type: :feature do
  let!(:admin) { users(:admin) }
  let!(:user) { users(:normal) }
  let!(:group) { groups(:beecham) }
  let!(:bread) { tasks(:bread)}

  context "create a new event" do
    before { login_as(user) }

    it "redirects user if user does not have a group" do
      visit task_path(bread)
      expect(page).to have_current_path root_path
    end

    it "successfully creates a new task" do
      group.add_member(user)
      visit root_path
      expect(page).to have_content "Hi, Anna!"
      click_link "Create New Task"
      expect(page).to have_current_path new_task_path

      fill_in "Title", with: "Do this!"
      fill_in "Description", with: "This is the thing I have to do."
      click_button "Create Task"

      expect(page).to have_content "Task was successfully created."

      # Task is listed
      visit tasks_path
      expect(page).to have_content "Do this!"
    end
  end
end


