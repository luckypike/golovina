require 'rails_helper'

RSpec.describe "colors/edit", type: :view do
  before(:each) do
    @color = assign(:color, Color.create!(
      :title => "MyString",
      :slug => "MyString",
      :parent_color => nil
    ))
  end

  it "renders the edit color form" do
    render

    assert_select "form[action=?][method=?]", color_path(@color), "post" do

      assert_select "input[name=?]", "color[title]"

      assert_select "input[name=?]", "color[slug]"

      assert_select "input[name=?]", "color[parent_color_id]"
    end
  end
end
