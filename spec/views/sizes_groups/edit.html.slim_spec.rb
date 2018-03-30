require 'rails_helper'

RSpec.describe "sizes_groups/edit", type: :view do
  before(:each) do
    @sizes_group = assign(:sizes_group, SizesGroup.create!(
      :title => "MyString"
    ))
  end

  it "renders the edit sizes_group form" do
    render

    assert_select "form[action=?][method=?]", sizes_group_path(@sizes_group), "post" do

      assert_select "input[name=?]", "sizes_group[title]"
    end
  end
end
