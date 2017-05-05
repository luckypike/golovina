require 'rails_helper'

RSpec.describe "colors/new", type: :view do
  before(:each) do
    assign(:color, Color.new(
      :title => "MyString",
      :slug => "MyString",
      :parent_color => nil
    ))
  end

  it "renders new color form" do
    render

    assert_select "form[action=?][method=?]", colors_path, "post" do

      assert_select "input[name=?]", "color[title]"

      assert_select "input[name=?]", "color[slug]"

      assert_select "input[name=?]", "color[parent_color_id]"
    end
  end
end
