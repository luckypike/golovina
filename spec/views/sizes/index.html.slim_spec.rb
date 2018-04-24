require 'rails_helper'

RSpec.describe "sizes/index", type: :view do
  before(:each) do
    assign(:sizes, [
      Size.create!(
        :sizes => "",
        :sizes_group => nil
      ),
      Size.create!(
        :sizes => "",
        :sizes_group => nil
      )
    ])
  end

  it "renders a list of sizes" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
