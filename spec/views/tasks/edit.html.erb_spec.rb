require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      creator_id: 1,
      assigned_to: 1,
      title: "MyString",
      description: "MyText",
      completed_by: 1,
      restricted: false
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", task_path(@task), "post" do

      assert_select "input[name=?]", "task[creator_id]"

      assert_select "input[name=?]", "task[assigned_to]"

      assert_select "input[name=?]", "task[title]"

      assert_select "textarea[name=?]", "task[description]"

      assert_select "input[name=?]", "task[completed_by]"

      assert_select "input[name=?]", "task[restricted]"
    end
  end
end
