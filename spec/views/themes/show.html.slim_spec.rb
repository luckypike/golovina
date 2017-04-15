require 'rails_helper'

RSpec.describe "themes/show", type: :view do
  before(:each) do
    @theme = assign(:theme, Theme.create!(
      :title => "Title",
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Slug/)
  end
end
