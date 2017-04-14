require 'rails_helper'

RSpec.describe "looks/edit", type: :view do
  before(:each) do
    @look = assign(:look, Look.create!(
      :title => "MyString"
    ))
  end

  it "renders the edit look form" do
    render

    assert_select "form[action=?][method=?]", look_path(@look), "post" do

      assert_select "input#look_title[name=?]", "look[title]"
    end
  end
end
