require 'rails_helper'

RSpec.describe "colors/show", type: :view do
  before(:each) do
    @color = assign(:color, Color.create!(
      :title => "Title",
      :slug => "Slug",
      :parent_color => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(//)
  end
end
