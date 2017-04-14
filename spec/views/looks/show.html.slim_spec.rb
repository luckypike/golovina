require 'rails_helper'

RSpec.describe "looks/show", type: :view do
  before(:each) do
    @look = assign(:look, Look.create!(
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
