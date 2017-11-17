require 'rails_helper'

RSpec.describe "slides/index", type: :view do
  before(:each) do
    assign(:slides, [
      Slide.create!(
        :name => "Name",
        :link => "Link",
        :image => "Image"
      ),
      Slide.create!(
        :name => "Name",
        :link => "Link",
        :image => "Image"
      )
    ])
  end

  it "renders a list of slides" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
