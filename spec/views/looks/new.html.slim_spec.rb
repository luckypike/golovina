require 'rails_helper'

RSpec.describe "looks/new", type: :view do
  before(:each) do
    assign(:look, Look.new(
      :title => "MyString"
    ))
  end

  it "renders new look form" do
    render

    assert_select "form[action=?][method=?]", looks_path, "post" do

      assert_select "input#look_title[name=?]", "look[title]"
    end
  end
end
