require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      organiser_id: 1,
      title: "MyString",
      description: "MyText",
      all_day: false,
      restricted: false
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input[name=?]", "event[organiser_id]"

      assert_select "input[name=?]", "event[title]"

      assert_select "textarea[name=?]", "event[description]"

      assert_select "input[name=?]", "event[all_day]"

      assert_select "input[name=?]", "event[restricted]"
    end
  end
end
