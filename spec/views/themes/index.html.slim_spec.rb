require 'rails_helper'

RSpec.describe "themes/index", type: :view do
  before(:each) do
    assign(:themes, [
      Theme.create!(
        :title => "Title",
        :slug => "Slug"
      ),
      Theme.create!(
        :title => "Title",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of themes" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
