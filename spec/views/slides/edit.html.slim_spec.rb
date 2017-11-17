require 'rails_helper'

RSpec.describe "slides/edit", type: :view do
  before(:each) do
    @slide = assign(:slide, Slide.create!(
      :name => "MyString",
      :link => "MyString",
      :image => "MyString"
    ))
  end

  it "renders the edit slide form" do
    render

    assert_select "form[action=?][method=?]", slide_path(@slide), "post" do

      assert_select "input[name=?]", "slide[name]"

      assert_select "input[name=?]", "slide[link]"

      assert_select "input[name=?]", "slide[image]"
    end
  end
end
