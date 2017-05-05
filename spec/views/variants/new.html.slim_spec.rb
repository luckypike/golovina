require 'rails_helper'

RSpec.describe "variants/new", type: :view do
  before(:each) do
    assign(:variant, Variant.new(
      :product => nil,
      :color => nil,
      :sizes => ""
    ))
  end

  it "renders new variant form" do
    render

    assert_select "form[action=?][method=?]", variants_path, "post" do

      assert_select "input[name=?]", "variant[product_id]"

      assert_select "input[name=?]", "variant[color_id]"

      assert_select "input[name=?]", "variant[sizes]"
    end
  end
end
