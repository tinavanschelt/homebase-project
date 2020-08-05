require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        creator_id: 2,
        assigned_to: 3,
        title: "Title",
        description: "MyText",
        completed_by: 4,
        restricted: false
      ),
      Task.create!(
        creator_id: 2,
        assigned_to: 3,
        title: "Title",
        description: "MyText",
        completed_by: 4,
        restricted: false
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
