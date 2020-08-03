require 'rails_helper'

RSpec.describe "group_members/index", type: :view do
  before(:each) do
    assign(:group_members, [
      GroupMember.create!(
        group_id: 2,
        user_id: 3
      ),
      GroupMember.create!(
        group_id: 2,
        user_id: 3
      )
    ])
  end

  it "renders a list of group_members" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
