require 'rails_helper'

RSpec.describe "sizes_groups/index", type: :view do
  before(:each) do
    assign(:sizes_groups, [
      SizesGroup.create!(
        :title => "Title"
      ),
      SizesGroup.create!(
        :title => "Title"
      )
    ])
  end

  it "renders a list of sizes_groups" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
