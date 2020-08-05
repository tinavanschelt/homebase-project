require 'rails_helper'

RSpec.describe "tasks/new", type: :view do
  before(:each) do
    assign(:task, Task.new(
      creator_id: 1,
      assigned_to: 1,
      title: "MyString",
      description: "MyText",
      completed_by: 1,
      restricted: false
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input[name=?]", "task[creator_id]"

      assert_select "input[name=?]", "task[assigned_to]"

      assert_select "input[name=?]", "task[title]"

      assert_select "textarea[name=?]", "task[description]"

      assert_select "input[name=?]", "task[completed_by]"

      assert_select "input[name=?]", "task[restricted]"
    end
  end
end
