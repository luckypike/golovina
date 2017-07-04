require 'rails_helper'

RSpec.describe "kinds/edit", type: :view do
  before(:each) do
    @kind = assign(:kind, Kind.create!(
      :title => "MyString",
      :category => nil
    ))
  end

  it "renders the edit kind form" do
    render

    assert_select "form[action=?][method=?]", kind_path(@kind), "post" do

      assert_select "input[name=?]", "kind[title]"

      assert_select "input[name=?]", "kind[category_id]"
    end
  end
end
