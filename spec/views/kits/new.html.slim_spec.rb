require 'rails_helper'

RSpec.describe "kits/new", type: :view do
  before(:each) do
    assign(:kit, Kit.new(
      :title => "MyString"
    ))
  end

  it "renders new kit form" do
    render

    assert_select "form[action=?][method=?]", kits_path, "post" do

      assert_select "input#kit_title[name=?]", "kit[title]"
    end
  end
end
