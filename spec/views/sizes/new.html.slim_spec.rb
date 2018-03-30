require 'rails_helper'

RSpec.describe "sizes/new", type: :view do
  before(:each) do
    assign(:size, Size.new(
      :sizes => "",
      :sizes_group => nil
    ))
  end

  it "renders new size form" do
    render

    assert_select "form[action=?][method=?]", sizes_path, "post" do

      assert_select "input[name=?]", "size[sizes]"

      assert_select "input[name=?]", "size[sizes_group_id]"
    end
  end
end
