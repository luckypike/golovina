require 'rails_helper'

RSpec.describe "slides/new", type: :view do
  before(:each) do
    assign(:slide, Slide.new(
      :name => "MyString",
      :link => "MyString",
      :image => "MyString"
    ))
  end

  it "renders new slide form" do
    render

    assert_select "form[action=?][method=?]", slides_path, "post" do

      assert_select "input[name=?]", "slide[name]"

      assert_select "input[name=?]", "slide[link]"

      assert_select "input[name=?]", "slide[image]"
    end
  end
end
