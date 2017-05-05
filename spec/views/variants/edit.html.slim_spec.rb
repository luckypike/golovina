require 'rails_helper'

RSpec.describe "variants/edit", type: :view do
  before(:each) do
    @variant = assign(:variant, Variant.create!(
      :product => nil,
      :color => nil,
      :sizes => ""
    ))
  end

  it "renders the edit variant form" do
    render

    assert_select "form[action=?][method=?]", variant_path(@variant), "post" do

      assert_select "input[name=?]", "variant[product_id]"

      assert_select "input[name=?]", "variant[color_id]"

      assert_select "input[name=?]", "variant[sizes]"
    end
  end
end
