require 'rails_helper'

RSpec.describe "sizes_groups/new", type: :view do
  before(:each) do
    assign(:sizes_group, SizesGroup.new(
      :title => "MyString"
    ))
  end

  it "renders new sizes_group form" do
    render

    assert_select "form[action=?][method=?]", sizes_groups_path, "post" do

      assert_select "input[name=?]", "sizes_group[title]"
    end
  end
end
