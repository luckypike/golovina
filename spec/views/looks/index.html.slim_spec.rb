require 'rails_helper'

RSpec.describe "looks/index", type: :view do
  before(:each) do
    assign(:looks, [
      Look.create!(
        :title => "Title"
      ),
      Look.create!(
        :title => "Title"
      )
    ])
  end

  it "renders a list of looks" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
