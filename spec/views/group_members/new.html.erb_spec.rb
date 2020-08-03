require 'rails_helper'

RSpec.describe "group_members/new", type: :view do
  before(:each) do
    assign(:group_member, GroupMember.new(
      group_id: 1,
      user_id: 1
    ))
  end

  it "renders new group_member form" do
    render

    assert_select "form[action=?][method=?]", group_members_path, "post" do

      assert_select "input[name=?]", "group_member[group_id]"

      assert_select "input[name=?]", "group_member[user_id]"
    end
  end
end
