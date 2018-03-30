require 'rails_helper'

RSpec.describe "sizes/edit", type: :view do
  before(:each) do
    @size = assign(:size, Size.create!(
      :sizes => "",
      :sizes_group => nil
    ))
  end

  it "renders the edit size form" do
    render

    assert_select "form[action=?][method=?]", size_path(@size), "post" do

      assert_select "input[name=?]", "size[sizes]"

      assert_select "input[name=?]", "size[sizes_group_id]"
    end
  end
end
