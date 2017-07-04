require 'rails_helper'

RSpec.describe "kinds/new", type: :view do
  before(:each) do
    assign(:kind, Kind.new(
      :title => "MyString",
      :category => nil
    ))
  end

  it "renders new kind form" do
    render

    assert_select "form[action=?][method=?]", kinds_path, "post" do

      assert_select "input[name=?]", "kind[title]"

      assert_select "input[name=?]", "kind[category_id]"
    end
  end
end
