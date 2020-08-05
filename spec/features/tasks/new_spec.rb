require "rails_helper"

RSpec.describe "create tasks", type: :feature do
  let!(:admin) { users(:admin) }
  let!(:user) { users(:normal) }

  context "create a new task" do
    before { login_as(user) }

    it "successfully creates a new task" do
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


