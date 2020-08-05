require 'rails_helper'

RSpec.describe "events/index", type: :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        organiser_id: 2,
        title: "Title",
        description: "MyText",
        all_day: false,
        restricted: false
      ),
      Event.create!(
        organiser_id: 2,
        title: "Title",
        description: "MyText",
        all_day: false,
        restricted: false
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
