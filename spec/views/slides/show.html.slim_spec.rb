require 'rails_helper'

RSpec.describe "slides/show", type: :view do
  before(:each) do
    @slide = assign(:slide, Slide.create!(
      :name => "Name",
      :link => "Link",
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/Image/)
  end
end
