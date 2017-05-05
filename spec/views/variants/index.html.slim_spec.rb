require 'rails_helper'

RSpec.describe "variants/index", type: :view do
  before(:each) do
    assign(:variants, [
      Variant.create!(
        :product => nil,
        :color => nil,
        :sizes => ""
      ),
      Variant.create!(
        :product => nil,
        :color => nil,
        :sizes => ""
      )
    ])
  end

  it "renders a list of variants" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
