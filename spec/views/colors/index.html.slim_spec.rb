require 'rails_helper'

RSpec.describe "colors/index", type: :view do
  before(:each) do
    assign(:colors, [
      Color.create!(
        :title => "Title",
        :slug => "Slug",
        :parent_color => nil
      ),
      Color.create!(
        :title => "Title",
        :slug => "Slug",
        :parent_color => nil
      )
    ])
  end

  it "renders a list of colors" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
